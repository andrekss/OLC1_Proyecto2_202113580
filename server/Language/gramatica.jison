// ################### ANALIZADOR LEXICO #######################
%lex
%options case-insensitive 

// ---------> Expresiones Regulares
entero  [0-9]+;
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
'=='                     {return 'COMPARACION'; }
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
'-'                      { return 'NMENOS'; }
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
   const Estructuras = require("../src/Interpreter/Structs/Estructura.js");
   let {Declarar_Linea, structs,Default_Values} = require("../src/Interpreter/Structs/Funciones.js"); // //VariableS Y Vectores
   let Negativo =require("../src/Interpreter/Expresion/Negativo.js");
   let Vector =require("../src/Interpreter/Structs/Vector.js");
   const Print =require("../src/Interpreter/instruccion/Print.js");
   const IF =require("../src/Interpreter/Sentencias_Control/IF.js");

   //const If =require("../src/Interpreter/Sentencias_Control/IF.js");
  
   const Condicion =require("../src/Interpreter/instruccion/Condiciones.js");
   const Negacion =require("../src/Interpreter/instruccion/Negación.js");
   
   //VariableS Y Vectores
   var valores =[];
   var ids =[];
   var Matriz=[];
   var type ="";  // tipo de dato de vectores

   //Print
   

   function GetDato(Valor, Tipo, linea,columna){
 	let dato = new Dato(Valor,Tipo,linea,columna); 
	return dato.interpretar();
   }

   function GetAritmetica(izq, op, der, linea, columna){
	let entorno = { Dato1:izq, Dato2:der, }; 
	let operation= new Aritmetica(izq.valor, op, der.valor, linea, columna);

	return operation.interpretar(entorno);
   }

   function GetCondición(expIzq, operador, expDer,Linea,Columna){
	let Operado =new Condicion(expIzq, operador, expDer,Linea,Columna);
	return Operado.interpretar();
   }

   function Negar(expresion,fila,columna){
	let niega =  new Negacion(expresion,fila,columna);
	return niega.interpretar();
   }

   function GetNegación(valor,linea,columna){
	let negar = new Negativo(valor,linea,columna);
	return negar.interpretar();

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

   function Reset_Structs(){
	valores = [];
	ids=[];
   }

%}

//%left 'MAS' 'MENOS'
/*
%left  IGUAL, DIFERENCIA, MENOR, MENOR_IGUAL, MAYOR, MAYOR_IGUAL
%left MAS
%right MENOS
%left DIVISION, POR
%left MODULO
*/


%left MAS, MENOS
%left COMPARACION, DIFERENCIA, MENOR, MENOR_IGUAL, MAYOR, MAYOR_IGUAL
%right NOT
%left AND
%left OR
%left DIVISION, POR, MODULO
%nonassoc POW
%right NMENOS




// -------> Simbolo Inicial
%start inicio


%% // ------> Gramatica

inicio
	: instrucciones EOF {  /*console.log(structs.Identificadores );*/ /*console.log(typeof $1);*/ Reset(); $$ = $1; return $$;}
	| EOF {return [];}
;

instrucciones 
            : instrucciones instruccion {$$ = $1; $$.push($2);}
			| instruccion  {$$ = []; $$.push($1);}
          	| error 	{console.error('Error sintáctico: ' + yytext + ',  linea: ' + this._$.first_line + ', columna: ' + this._$.first_column);}
;

instruccion
	// Sentencias principales
	: Variables PUNTO_C              {$$ = $1;}
	| Incremento_Decremento PUNTO_C  {$$ = $1;}
	| Vectores PUNTO_C               {$$ = $1;}
	| Sentencias_Control             {$$ = $1;}
	| Sen_Ciclicas                   {$$ = $1;}
	| Funcs_Methods                  {$$ = $1;}
	| Sen_Cout PUNTO_C               {$$ = $1;}
	
	// Partes de las sentencias principales
	| Llamadas_Funcs_Methods PUNTO_C {$$ = $1;}
	| BREAK PUNTO_C                  {$$ = $1;} // SOLO DENTRO DE CICLOS
	| CONTINUE PUNTO_C               {$$ = $1;}// SOLO DENTRO DE CICLOS
	| RETURN Valores PUNTO_C         {$$ = $1;}// SOLO DENTRO DE CICLOS Y FUNCIONES
	| RETURN PUNTO_C                 {$$ = $1;}// SOLO DENTRO DE CICLOS Y FUNCIONES
	| Sen_Execute PUNTO_C            {$$ = $1;}// selecciona la función main a ejecutar
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
            : ID C_Abre Valores C_Cierra {if(structs.Identificadores[$1].tipo.toLowerCase()=="std::string".toLowerCase()){type="STRING"}else{ type =structs.Identificadores[$1].tipo;} $$= structs.Identificadores[$1].valor[$3.valor]; }// 1 dimensión
			| ID C_Abre Valores C_Cierra C_Abre Valores C_Cierra
			{ if(structs.Identificadores[$1].tipo.toLowerCase()=="std::string".toLowerCase())
			{type="STRING"}
			else{ type =structs.Identificadores[$1].tipo;} 
			$$= structs.Identificadores[$1].valor[$3.valor][$6.valor]; } //2 dimensiones
;

Variables // Todo tipo de variables
        : Tipo_Dato Dec_Variables { Declarar_Linea($1, ids, valores, structs); Reset_Structs();  } 
		| Dec_Variables // solo aqui van modificadores de vector
; 

Valores // retorna objeto con tipo y valor
	: MENOS Valores %prec NMENOS                 { $$ = GetNegación($2, @1.first_line, @1.first_column); }
	| POW P_ABRE Valores COMA Valores P_CIERRA   { $$ = GetAritmetica($3, $1, $5, @1.first_line, @1.first_column); }
	| Valores POR Valores                        { $$ = GetAritmetica($1, $2, $3, @1.first_line, @1.first_column); }
	| Valores DIVISION Valores                   { $$ = GetAritmetica($1, $2, $3, @1.first_line, @1.first_column); }
	| Valores MODULO Valores                     { $$ = GetAritmetica($1, $2, $3, @1.first_line, @1.first_column); }
	| Valores MAS Valores                        { $$ = GetAritmetica($1, $2, $3, @1.first_line, @1.first_column); }
	| Valores MENOS Valores                      { $$ = GetAritmetica($1, $2, $3, @1.first_line, @1.first_column); }
	| P_ABRE Valores P_CIERRA                    { $$ = $2; }                                    
    | ENTERO                                     { $$ = GetDato($1, "INT", @1.first_line, @1.first_column); }
	| DECIMAL                                    { $$ = GetDato($1, "DOUBLE", @1.first_line, @1.first_column); }
	| BOOLEANO                                   { $$ = GetDato($1, "BOOL", @1.first_line, @1.first_column); }
	| CAR                                        { $$ = GetDato($1, "CHAR", @1.first_line, @1.first_column); }
	| CAD                                        { $$ = GetDato($1, "STRING", @1.first_line, @1.first_column); }
	| Vectores_Acceso                            { $$ = GetDato($1, type.toUpperCase(), @1.first_line, @1.first_column); }  // acceso a valores 
	| ID                                         { llamada={ Id:$1, }; $$= GetDato(structs.interpretar(llamada).valor , structs.interpretar(llamada).tipo.toUpperCase()); }// Llamamos la variable
	| Llamadas_Funcs_Methods // Solo podrán ir funciones
	| Funciones
	| Natives_Funcs 
;

Tipos_Valores
            : Valores {$$=$1;}
			| P_ABRE Tipo_Dato P_CIERRA Valores {if($1.toUpperCase()=="std::string"){$1="STRING";} $$ = GetDato($4.valor, $1.toUpperCase(), @1.first_line, @1.first_column); }//Casteo 
;

Modificador
        : ID { $$=$1; }
		| Vectores_Acceso // vectores
;

ID_Formas
        : Modificador { ids.push($1); valores.push("Default"); }
		| Modificador IGUAL Tipos_Valores { ids.push($1); valores.push($3); }
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
            : Valores { valores.push($1.valor); }
			| Valores_Separado COMA Valores {  valores.push($3.valor); }
;

Valores_Corchete_Separado
                    : C_Abre Valores_Separado C_Cierra { Matriz.push(valores); Reset_Structs(); }
					| Valores_Corchete_Separado COMA C_Abre Valores_Separado C_Cierra { Matriz.push(valores); Reset_Structs();}
;

Declaracion_1 // declarar el vector
            : Tipo_Dato ID C_Abre C_Cierra IGUAL NEW Tipo_Dato C_Abre Valores C_Cierra // 1 dimensión
			{ 
				let vector = new Array(Number($9.valor)).fill(Default_Values("Default",$1).valor);
				var Objvector = new Vector($1,vector); 
			    structs.push($2,Objvector,$1); 
			} 
			| Tipo_Dato ID C_Abre C_Cierra C_Abre C_Cierra IGUAL NEW Tipo_Dato C_Abre Valores C_Cierra C_Abre Valores C_Cierra // 2 dimensiones
			{   
				let matriz = new Array(Number($11.valor)).fill(Default_Values("Default",$1).valor).map(() => new Array(Number($14.valor)).fill(Default_Values("Default",$1).valor));
				var ObjMatriz = new Vector($1,matriz); 
			    structs.push($2,ObjMatriz,$1); 
			} 
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
            : Tipo_Dato ID C_Abre C_Cierra IGUAL Asignaciones_Vectores { var Objvector = new Vector($1,valores); structs.push($2,Objvector,$1);  Reset_Structs(); /*console.log(structs.Identificadores["vector4"].valor[0] );*/ } // 1 dimensión
			| Tipo_Dato ID C_Abre C_Cierra C_Abre C_Cierra IGUAL Asignaciones_Vectores_Mas 
			{ var ObjMatriz = new Vector($1,Matriz); structs.push($2,ObjMatriz,$1); Matriz=[];  /*console.log(structs.Identificadores["vector"].valor[1][0] );*/ } // 2 dimensiones
;



// Condiciones

Condicion
        : NOT Condicion                      { $$ = Negar($2,@1.first_line, @1.first_column)}
        | Condicion COMPARACION Condicion    { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
        | Condicion DIFERENCIA Condicion     { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
        | Condicion MENOR_IGUAL Condicion    { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
        | Condicion MAYOR_IGUAL Condicion    { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
        | Condicion MENOR Condicion          { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
        | Condicion MAYOR Condicion          { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
        | Condicion AND Condicion            { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
        | Condicion OR Condicion             { $$ = GetCondición($1,$2,$3,@1.first_line, @1.first_column);}
		| Valores                            { $$ = $1.valor; }  
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
        : IF P_ABRE Condicion P_CIERRA LLAVE_A instrucciones LLAVE_C  {$$ = new IF($3, $6, @1.first_line, @1.first_column);}
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
        : COUT MENOR MENOR Valores {  Imprimir = new Print($4,"no");  Imprimir.interpretar();  }
		| COUT MENOR MENOR Valores MENOR MENOR ENDL { var Imprimir = new Print($4,"si"); Imprimir.interpretar(); }
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
			| TYPEOF P_ABRE Valores P_CIERRA { $$= GetDato($3.valor, $3.tipo.toUpperCase()); }
			| TOSTRING P_ABRE Valores P_CIERRA 
			| ID PUNTO C_STR P_ABRE P_CIERRA
;

Sen_Execute
        : EXECUTE ID P_ABRE P_CIERRA
		| EXECUTE ID P_ABRE Parametros P_CIERRA
;