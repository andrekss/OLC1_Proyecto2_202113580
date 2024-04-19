// ################### ANALIZADOR LEXICO #######################
%lex
%options case-insensitive 

// ---------> Expresiones Regulares
entero  [0-9]+|'-'[0-9]+;
decimal   {entero}'.'[0-9]+;
booleano      "true"|"false";
CADENA     "\""[^"\""]*"\"";
CARACTER   "'"[^"'"]"'"| "'""'";
Identificador [a-zA-Z][a-zA-Z0-9\_]*;

%%
// -----> Espacios en Blanco
[ \s\r\n\t]             {/* Espacios se ignoran */}
"//".*                  {/* Comentario de una linea */}
"/*"[^]*?"*/"           {/* Comentario multilinea */}

// -----> Reglas Lexicas


"int"                    { return 'INT'; }
"double"                 { return 'DOUBLE'; }
"bool"                   { return 'BOOL'; }
"Char"                   { return 'CHAR'; }
"std::string"            { return 'STRING'; }

"else"                   { return 'ELSE'; }
"new"                    { return 'NEW'; }
"if"                     { return 'IF'; }
"switch"                 { return 'SWITCH'; }
"case"                   { return 'CASE'; }
"break"                  { return 'BREAK'; }
"default"                { return 'DEFAULT'; }
"continue"               { return 'CONTINUE'; }
"return"                 { return 'RETURN'; }
"void"                   { return 'VOID'; }
"cout"                   { return 'COUT'; }
"endl"                   { return 'ENDL'; }

"pow"                    { return 'POW'; }
"Tolower"                { return 'TOLOWER'; }
"Toupper"                { return 'TOUPPER'; }
"Round"                  { return 'ROUND'; }

// Funciones Nativas
"Length"                 { return 'LENGTH'; }
"Typeof"                 { return 'TYPEOF'; }
"std::ToString"          { return 'TOSTRING'; }
"c_str"                  { return 'C_STR'; }
"execute"                 { return 'EXECUTE'; }

"do"                     { return 'DO'; }
"while"                  { return 'WHILE'; }
"for"                    { return 'FOR'; }


{decimal}                { return 'DECIMAL'; }
{entero}                 { return 'ENTERO'; }
{booleano}               { return 'BOOLEANO'; }
{CARACTER}               { return 'CAR'; }
{CADENA}                 { return 'CAD'; }
{Identificador}          { return 'ID'; }

'.'                      {return 'PUNTO'; }
':'                      {return 'DOS_PUNTOS'; }
';'                      {return 'PUNTO_C'; }
','                      {return 'COMA'; }

// operadores relacionales
'='                      {return 'IGUAL'; }
'!='                     {return 'DIFERENCIA'; }
'<='                     {return 'MENOR_IGUAL'; }
'>='                     {return 'MAYOR_IGUAL'; }
'<'                      {return 'MENOR'; }
'>'                      {return 'MAYOR'; }

'&&'                     {return 'AND'; }
'||'                     {return 'OR'; }
'!'                      {return 'NOT'; }

//Operadores Lógicos
'+'                      {return 'MAS'; }
'-'                      {return 'MENOS'; }
'*'                      {return 'POR'; }
'/'                      {return 'DIVISION'; }
'('                      {return 'P_ABRE'; }
')'                      {return 'P_CIERRA'; }
"["                      {return 'C_Abre'; }
"]"                      {return 'C_Cierra'; }
"{"                      { return 'LLAVE_A'; }
"}"                      { return 'LLAVE_C'; }
"%"                      { return 'MODULO'; }


// -----> FIN DE CADENA Y ERRORES
<<EOF>>               return 'EOF';
.  { console.error('Error léxico: \"' + yytext + '\", linea: ' + yylloc.first_line + ', columna: ' + yylloc.first_column);  }
/lex



// ################## ANALIZADOR SINTACTICO ######################
// -------> Precedencia

%{

   const Dato = require("../Interpreter/expresion/Dato.js");

%}

//%left 'MAS' 'MENOS'
%left  IGUAL, DIFERENCIA, MENOR, MENOR_IGUAL, MAYOR, MAYOR_IGUAL
%left MAS, MENOS
%left DIVISION, POR
%left MODULO

// -------> Simbolo Inicial
%start inicio


%% // ------> Gramatica

inicio
	: instrucciones EOF {$$=$1; return $$;}
;

instrucciones 
            : instrucciones instruccion {$$ = $1;}
			| instruccion 
          	| error 	{console.error('Error sintáctico: ' + yytext + ',  linea: ' + this._$.first_line + ', columna: ' + this._$.first_column);}
;

instruccion
	// Sentencias principales
	: Variables PUNTO_C
	| Incremento_Decremento PUNTO_C
	| Vectores PUNTO_C
	| Sentencias_Control 
	| Sen_Ciclicas
	| Funcs_Methods
	| Sen_Cout PUNTO_C
	
	// Partes de las sentencias principales
	| Llamadas_Funcs_Methods PUNTO_C
	| BREAK PUNTO_C // SOLO DENTRO DE CICLOS
	| CONTINUE PUNTO_C // SOLO DENTRO DE CICLOS
	| RETURN Valores PUNTO_C // SOLO DENTRO DE CICLOS Y FUNCIONES
	| RETURN PUNTO_C // SOLO DENTRO DE CICLOS Y FUNCIONES
	| Sen_Execute PUNTO_C // selecciona la función main a ejecutar
;

// Variables
Tipo_Dato
        : INT
		| DOUBLE
		| BOOL
		| CHAR
		| STRING
;

Vectores_Acceso // Acceso de valores de un vector vectores
            : ID C_Abre Valores C_Cierra 
			| ID C_Abre Valores C_Cierra C_Abre Valores C_Cierra 
;

Variables // Todo tipo de variables
        : Tipo_Dato Dec_Variables
		| Dec_Variables // solo aqui van modificadores de vector
; 

Datos
    : ENTERO { Dato }
	| DECIMAL
	| BOOLEANO 
	| CAR 
	| CAD 
	| Vectores_Acceso  // acceso a valores
	| ID 
	| Llamadas_Funcs_Methods // Solo podrán ir funciones
	| Funciones
	| Natives_Funcs
	| POW P_ABRE Datos COMA Datos P_CIERRA 
;

Valores
        : Datos
		| Valores Op_Logicos Datos 
;

Tipos_Valores
            : Valores
			| P_ABRE Tipo_Dato P_CIERRA Valores //Casteo
;

Modificador
        : ID
		| Vectores_Acceso // vectores
;

ID_Formas
        : Modificador
		| Modificador IGUAL Tipos_Valores 
;

Dec_Variables
        : ID_Formas 
		| ID_Formas COMA Dec_Variables
;

// Incremento y Decremento
Crece_Decrece
        : MAS MAS
		| MENOS MENOS
;

Incremento_Decremento
                    : ID Crece_Decrece
;

// vectores

Vectores
    : Declaracion_1
	| Declaracion_2
;

Valores_Separado
            : Valores
			| Valores_Separado COMA Valores
;

Valores_Corchete_Separado
                    : C_Abre Valores_Separado C_Cierra
					| Valores_Corchete_Separado COMA C_Abre Valores_Separado C_Cierra
;

Declaracion_1 // declarar el vector
            : Tipo_Dato ID C_Abre C_Cierra IGUAL NEW Tipo_Dato C_Abre Valores C_Cierra // 1 dimensión
			| Tipo_Dato ID C_Abre C_Cierra C_Abre C_Cierra IGUAL NEW Tipo_Dato C_Abre Valores C_Cierra C_Abre Valores C_Cierra // 2 dimensiones
;

Asignaciones_Vectores
                : C_Abre Valores_Separado C_Cierra
				| Valores
;

Asignaciones_Vectores_Mas
                    : C_Abre Valores_Corchete_Separado C_Cierra
					| Valores
;

Declaracion_2 // declarar y asignar valores al vector
            : Tipo_Dato ID C_Abre C_Cierra IGUAL Asignaciones_Vectores // 1 dimensión
			| Tipo_Dato ID C_Abre C_Cierra C_Abre C_Cierra IGUAL Asignaciones_Vectores_Mas // 2 dimensiones
;
// Condiciones

Op_Logicos
        : MAS
		| MENOS
		| POR
		| DIVISION
		| MODULO
;


Op_Racionales 
            : IGUAL IGUAL
            | DIFERENCIA
			| MENOR_IGUAL
			| MAYOR_IGUAL
			| MENOR
			| MAYOR
			| AND
			| OR
			| NOT
;

Condicion
            : Valores
			| Valores Op_Racionales Condicion
;

// Sentencias de control

Sentencias_Control
                : Sen_IF
				| Sen_Switch
;

Sen_Else
        : ELSE LLAVE_A instrucciones LLAVE_C
;

Sen_Else_If
		: ELSE IF P_ABRE Condicion P_CIERRA LLAVE_A instrucciones LLAVE_C
;

Bloque_Else_If
    : Sen_Else_If
    | Bloque_Else_If Sen_Else_If
;

If_Simple
        : IF P_ABRE Condicion P_CIERRA LLAVE_A instrucciones LLAVE_C
;

Sen_IF
    : If_Simple
	| If_Simple Sen_Else
	| If_Simple Bloque_Else_If
	| If_Simple Bloque_Else_If Sen_Else
;

Entry_Cases
        : CASE Valores
		| DEFAULT // Este solo irá al final y solo uno
;

Cases
    : Entry_Cases DOS_PUNTOS instrucciones // uso de break
;

Strcuct_Switch
            : Cases
			| Strcuct_Switch Cases
;

Sen_Switch
        : SWITCH P_ABRE Valores P_CIERRA LLAVE_A Strcuct_Switch LLAVE_C
;

// Sentencias Cíclicas

Sen_Ciclicas // todas pueden llevar Break, continue y return
        : Sen_While
		| Sen_For
		| Sen_Do_While
;


Sen_While
        : WHILE P_ABRE Condicion P_CIERRA LLAVE_A instrucciones LLAVE_C
;

Signos_For
        : MAYOR
		| MENOR
		| MAYOR_IGUAL
		| MENOR_IGUAL
		| IGUAL
;

Sen_For
    : FOR P_ABRE Tipo_Dato ID Signos_For Valores PUNTO_C ID Signos_For Valores PUNTO_C Incremento_Decremento P_CIERRA LLAVE_A instrucciones LLAVE_C
;

Sen_Do_While
        : DO LLAVE_A instrucciones LLAVE_C WHILE P_ABRE Condicion P_CIERRA
;

// Funciones y métodos
Variable_Parametros
                : ID 
				| ID P_ABRE P_CIERRA
				| ID P_ABRE P_CIERRA P_ABRE P_CIERRA
;

Parametros
        : Tipo_Dato Variable_Parametros 
		| Tipo_Dato Variable_Parametros COMA Parametros
;

Funcs_Methods
        // Funciones
        : Tipo_Dato ID P_ABRE Parametros P_CIERRA LLAVE_A instrucciones LLAVE_C
		| Tipo_Dato ID P_ABRE P_CIERRA LLAVE_A instrucciones LLAVE_C // sin parametros
		//Metodos
        | VOID ID P_ABRE Parametros P_CIERRA LLAVE_A instrucciones LLAVE_C
		| VOID ID P_ABRE P_CIERRA LLAVE_A instrucciones LLAVE_C // sin parametros
;

Llamadas_Funcs_Methods
                    : ID P_ABRE Valores_Separado P_CIERRA
					| ID P_ABRE P_CIERRA
;

// imprimir

Sen_Cout
        : COUT MENOR MENOR Valores
		| COUT MENOR MENOR Valores MENOR MENOR ENDL
;

// Funciones

Funciones
        : TOLOWER P_ABRE Valores P_CIERRA
		| TOUPPER P_ABRE Valores P_CIERRA
		| ROUND P_ABRE Valores P_CIERRA
;

// Funciones Nativas

Natives_Funcs
            : ID PUNTO LENGTH P_ABRE P_CIERRA // el id puede ser una cadena, lista o vector
			| TYPEOF P_ABRE Valores P_CIERRA
			| TOSTRING P_ABRE Valores P_CIERRA
			| ID PUNTO C_STR P_ABRE P_CIERRA
;

Sen_Execute
        : EXECUTE ID P_ABRE P_CIERRA
		| EXECUTE ID P_ABRE Parametros P_CIERRA
;