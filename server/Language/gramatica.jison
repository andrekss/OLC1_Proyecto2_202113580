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
'-'                      { return 'MENOS'; }
'*'                      {return 'POR'; }
'/'                      {return 'DIVISION'; }
'('                      {return 'P_ABRE'; }
')'                      {return 'P_CIERRA'; }
"["                      {return 'C_Abre'; }
"]"                      {return 'C_Cierra'; }
"{"                      { return 'LLAVE_A'; }
"}"                      { return 'LLAVE_C'; }
"%"                      { return 'MODULO'; }

{decimal}                { return 'DECIMAL'; }
{entero}                 { return 'ENTERO'; }
{booleano}               { return 'BOOLEANO'; }
{CARACTER}               { return 'CAR'; }
{CADENA}                 { return 'CAD'; }
{Identificador}          { return 'ID'; }


// -----> FIN DE CADENA Y ERRORES
<<EOF>>               return 'EOF';
.  { console.error('Error léxico: \"' + yytext + '\", linea: ' + yylloc.first_line + ', columna: ' + yylloc.first_column);  }
/lex



// ################## ANALIZADOR SINTACTICO ######################
// -------> Precedencia

%{

   const Dato = require("../src/Interpreter/Expresion/Dato.js");
   const Aritmetica = require("../src/Interpreter/Expresion/Aritmetica.js");
   let { DatosDef,Signos } = require("../src/Interpreter/Expresion/Operaciones.js"); // arreglos para hacer operaciones logicas
   const Estructuras = require("../src/Interpreter/Structs/Estructura.js");
   let {Declarar_Linea, structs,Default_Values} = require("../src/Interpreter/Structs/Funciones.js"); // //VariableS Y Vectores
   let {Ejecutar} =require("../src/Interpreter/Expresion/Ejecución.js");
   let Vector =require("../src/Interpreter/Structs/Vector.js");
   
   const Print =require("../src/Interpreter/instruccion/Print.js");
   
   //VariableS Y Vectores
   var valores =[];
   var ids =[];

   //Print
   

   function GetDato(Valor, Tipo){
 	let dato = new Dato(Valor,Tipo); 
	return dato.interpretar();
   }

   function Imprimir(){
    console.log("-------------------------");
	console.log("Datos");
	for (let i = 0; i < DatosDef.length; i++) {
     console.log(DatosDef[i].valor);
    }

    console.log("Signos")
	for (let i = 0; i < Signos.length; i++) {
     console.log(Signos[i]);
    }
	console.log("-------------------------");
	DatosDef = [];
	Signos = [];	
   }
   
   function Reset(){
	structs = new Estructuras(); 	
   }

   function Reset_Structs_Variables(){
	DatosDef=[]; 
	Signos =[];
	valores = [];
	ids=[];
   }

   parser.parseError = function (message, hash) {
    // Tu código para ejecutar al final de la cadena
    console.log("Se ha alcanzado el final de la cadena.");
};




%}

//%left 'MAS' 'MENOS'
/*
%left  IGUAL, DIFERENCIA, MENOR, MENOR_IGUAL, MAYOR, MAYOR_IGUAL
%left MAS
%right MENOS
%left DIVISION, POR
%left MODULO
*/

%left DIVISION, POR, MODULO
%left MAS, MENOS
%left IGUAL, DIFERENCIA, MENOR, MENOR_IGUAL, MAYOR, MAYOR_IGUAL
%right NOT
%left AND
%left OR

// -------> Simbolo Inicial
%start inicio


%% // ------> Gramatica

inicio
	: instrucciones EOF { /*console.log(structs.Variables);*/ Reset(); $$=$1; return $$;}
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
        : INT { $$=$1; }
		| DOUBLE { $$=$1; }
		| BOOL { $$=$1; }
		| CHAR { $$=$1; }
		| STRING { $$=$1; }
;

Vectores_Acceso // Acceso de valores de un vector vectores
            : ID C_Abre Valores C_Cierra // 1 dimensión
			| ID C_Abre Valores C_Cierra C_Abre Valores C_Cierra 
;

Variables // Todo tipo de variables
        : Tipo_Dato Dec_Variables { Declarar_Linea($1, ids, valores, structs); Reset_Structs_Variables();  } 
		| Dec_Variables // solo aqui van modificadores de vector
; 

Datos // Retorno de datos
    : ENTERO {  $$= GetDato($1, "INT"); }
	| DECIMAL { $$= GetDato($1, "DOUBLE"); }
	| BOOLEANO { $$= GetDato($1, "BOOL"); }
	| CAR { $$= GetDato($1, "CHAR"); }
	| CAD { $$= GetDato($1, "STRING"); }
	| Vectores_Acceso  // acceso a valores
	| ID { llamada={ Id:$1, Modo:"Vars", }; $$= GetDato(structs.interpretar(llamada).valor, structs.interpretar(llamada).tipo.toUpperCase()); }// Llamamos la variable
	| Llamadas_Funcs_Methods // Solo podrán ir funciones
	| Funciones
	| Natives_Funcs
	| POW P_ABRE Datos COMA Datos P_CIERRA {
	   let Entorno = {
        Dato1: $3, 
        Dato2: $5,
       };
		let Operación =  new Aritmetica(Entorno.Dato1.valor,"Pot",Entorno.Dato2.valor);
		
		$$ = Operación.interpretar(Entorno);
	}
;

Valores 
 		: Datos { DatosDef.push($1); }
		| Valores Op_Logicos Datos { Signos.push($2); DatosDef.push($3); }
;


Tipos_Valores
            : Valores 
			| P_ABRE Tipo_Dato P_CIERRA Valores //Casteo
;

Modificador
        : ID { $$=$1; }
		| Vectores_Acceso // vectores
;

ID_Formas
        : Modificador { ids.push($1); valores.push("Default"); }
		| Modificador IGUAL Tipos_Valores { let valor = Ejecutar(DatosDef,Signos); DatosDef=[]; Signos=[]; ids.push($1); valores.push(valor); }
;

Dec_Variables
        : ID_Formas 
		| ID_Formas COMA Dec_Variables 
;



// Incremento y Decremento
Crece_Decrece
        : MAS MAS { $$="+";}
		| MENOS MENOS { $$="-";}
;

Incremento_Decremento
                    : ID Crece_Decrece { structs.Incremento_Decremento($1,$2); }
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
			{   
				let x = Number(Ejecutar(DatosDef,Signos).valor); DatosDef = []; Signos =[];
				let vector = new Array(x).fill(Default_Values("Default",$1).valor);
				var Objvector = new Vector($1,vector); 
			    structs.pushVector($2,Objvector,$1); 
				console.log(structs.Vectores);	
			} 
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
        : COUT MENOR MENOR Valores { var Imprimir = new Print(Ejecutar(DatosDef,Signos),"no");  Imprimir.interpretar();  	DatosDef=[]; Signos =[];}
		| COUT MENOR MENOR Valores MENOR MENOR ENDL { var Imprimir = new Print(Ejecutar(DatosDef,Signos),"si"); Imprimir.interpretar(); DatosDef=[]; Signos =[];}
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