%{  // importaciones
    const print = require('../build/Interprete/Print/Expresion.js');
	const Err = require('../build/Interprete/Errors/Expresion.js');
	const Var = require('../build/Interprete/Variables/Expresion.js');

	let guardar= new print.TerminalExpression();  
    let Op = new print.NonTerminalExpression(guardar);

	let guardarError= new Err.TerminalExpression();  
	let TablaErrores = new Err.NonTerminalExpression(guardarError);
	
	let Variables= new Var.TerminalExpression(); 
	let PrintVars = new Var.NonTerminalExpression(Variables);
%}

// ################### ANALIZADOR LEXICO #######################
%lex
%options case-insensitive 

// ---------> Expresiones Regulares
entero  [0-9]+;
ID        "@"[a-zA-Z][a-zA-Z0-9\_]*;
comilla   "'"|"\""
CADENA     {comilla}[^{comilla}]*{comilla};
//CADENA    {comilla}.*{comilla};
decimal   {entero}'.'{entero};
booleano      "TRUE"|"FALSE";
date       [0-9][0-9][0-9][0-9]"-"[0-1][0-9]"-"[0-3][0-9];
NameTables [a-zA-Z][a-zA-Z0-9\_]*;

%%


// -----> Espacios en Blanco
[ \r\n\t]                {/* Espacios se ignoran */}

"--".*                  {/* Comentario de una linea */}
"/*"[^]*?"*/"           {/* Comentario multilinea */}

// -----> Reglas Lexicas

"declare"                {return 'DECLARE'; }
"int"                    {return 'INT'; }
"double"                 {return 'DOUBLE'; }
"date"                   {return 'DATE'; }
"varchar"                {return 'VARCHAR'; }
"bool"                   {return 'BOOLEANO'; }
{booleano}               {return 'BOOLEAN'; }
{date}                   {return 'DATES'; }
"NULL"                   {return 'NULL'; }
"SET"                    {return 'SET'; }
"DEFAULT"                {return 'DEFAULT'; }
"SELECT"                 {return 'SELECT'; }
"CREATE"                 {return 'CREATE'; }
"TABLE"                  {return 'TABLE'; }
"ALTER"                  {return 'ALTER'; }
"ADD"                    {return 'ADD'; }
"DROP"                   {return 'DROP'; }
"COLUMN"                 {return 'COLUMN'; }
"RENAME"                 {return 'RENAME'; }
"TO"                     {return 'TO'; }
"INSERT"                 {return 'INSERT'; }
"INTO"                   {return 'INTO'; }
"VALUES"                 {return 'VALUES'; }
"FROM"                   {return 'FROM'; }
"WHERE"                  {return 'WHERE'; }
"WHEN"                   {return 'WHEN'; }
"WHILE"                  {return 'WHILE'; }
"FOR"                    {return 'FOR'; }
"IN"                     {return 'IN'; }
"LOOP"                   {return 'LOOP'; }
"BEGIN"                  {return 'BEGIN'; }
"END"                    {return 'END'; }
"AS"                     {return 'AS'; }
"UPDATE"                 {return 'UPDATE'; }
"TRUNCATE"               {return 'TRUNCATE'; }
"DELETE"                 {return 'DELETE'; }
"CAST"                   {return 'CAST'; }
"IF"                     {return 'IF'; }
"BREAK"                  {return 'BREAK'; }
"ELSE"                   {return 'ELSE'; }
"THEN"                   {return 'THEN'; }
"PROCEDURE"              {return 'PROCEDURE'; }
"CASE"                   {return 'CASE'; }
"FUNCTION"               {return 'FUNCTION'; }
"RETURNS"                {return 'RETURNS'; }
"RETURN"                 {return 'RETURN'; }
"PRINT"                  {return 'PRINT'; }
"LOWER"                  {return 'LOWER'; }
"UPPER"                  {return 'UPPER'; }
"ROUND"                  {return 'ROUND'; }
"LEN"                    {return 'LEN'; }
"TYPEOF"                 {return 'TYPEOF'; }

'AND'                    {return 'AND'; }
'OR'                     {return 'OR'; }
'NOT'                    {return 'NOT'; }

{ID}                     {return 'IDENTIFICADOR'; }
{NameTables}             {return 'NOMBRESTABLAS'; }
{decimal}                {return 'DECIMAL'; }
{entero}                 {return 'ENTERO'; }
{CADENA}                 {return 'CADENA'; }

'.'                      {return 'PUNTO'; }
';'                      {return 'PUNTO_C'; }
','                      {return 'COMA'; }
// operadores relacionales
'='                      {return 'IGUAL'; }
'!='                     {return 'DIFERENCIA'; }
'<='                     {return 'MENOR_IGUAL'; }
'>='                     {return 'MAYOR_IGUAL'; }
'<'                      {return 'MENOR'; }
'>'                      {return 'MAYOR'; }
// operadores lógicos

// operadores lógicos
'+'                      {return 'MAS'; }
'-'                      {return 'MENOS'; }
'*'                      {return 'POR'; }
'/'                      {return 'DIVISION'; }
"("                      {return 'P_Abre'; }
")"                      {return 'P_Cierra'; }
'%'                      {return 'MODULO'; }

// -----> FIN DE CADENA Y ERRORES
<<EOF>>               return 'EOF';
.  { //console.error('Error léxico: \"' + yytext + '\", linea: ' + yylloc.first_line + ', columna: ' + yylloc.first_column); 
   guardarError.interprete('Error léxico','El caracter \"'+yytext+'\" no pertenece al lenguaje',yylloc.first_line, yylloc.first_column)
   }



 


//--------------------------------------------------------------------------------------------------------





/lex

// ################## ANALIZADOR SINTACTICO ######################
// -------> Precedencia

//%left 'MAS' 'MENOS'
%right NOT
%left AND
%left OR
%left IGUAL, DIFERENCIA, MENOR, MENOR_IGUAL, MAYOR, MAYOR_IGUAL
%left MAS, MENOS
%left DIVISION, POR
%left MODULO

// -------> Simbolo Inicial
%start inicio

%% // ------> Gramatica

inicio
	: instrucciones EOF    {TablaErrores.interprete(); guardarError.Recorrer(); $$=$1; return $$;  }
;

instrucciones
	: instrucciones instruccion    {$$ = $1; }
	| instruccion 
	| error      	{//console.error('Error sintáctico: ' + yytext + ',  linea: ' + this._$.first_line + ', columna: ' + this._$.first_column);
	guardarError.interprete('Error Sintáctico','Caracter \"'+yytext+'\" inválido en la sintaxis',this._$.first_line, this._$.first_column)
	}
;

instruccion  // raiz de todo
        : dec_variables PUNTO_C 
		| Sen_Set PUNTO_C 
		| SEN_Select PUNTO_C
		| Sen_CTable
		| Sen_ATable
		| DROP TABLE NOMBRESTABLAS PUNTO_C
		| Sen_Insert PUNTO_C
		| Sen_Select_DML PUNTO_C
		| Sen_SelectFrom_DML
		| Sen_SelectClausula_DML
		| Encapsular_Sen
		| Sen_SelectAs
		| Sen_update
		| Sen_truncate
		| Sen_Delete
		| If_Simple
		| If_Else
		| Case_Simple
		| Case_Buscado
		| Sen_While
		| Sen_For
		| Sen_Funciones
		| Sen_Metodos
		| Llamadas_Metodos
		| Sen_Print
		| Sen_Lower
		| Sen_Upper
		| Sen_Round
		| Sen_Length
		| Sen_truncate_Nativa
		| Sen_TypeOf
		| BREAK PUNTO_C // solo valido para ciclos for y while
;

Encapsular_Sen
            : BEGIN instrucciones END PUNTO_C
;

TipoDato
        : INT
        | DOUBLE
		| DATE
		| VARCHAR
		| BOOLEANO
;

dec_variables
    : DECLARE variables
;

variables 
        : DeclareODAsignado 
		| DeclareODAsignado COMA variables 
;

DeclareODAsignado
                : IDENTIFICADOR TipoDato  { Variables.Interprete($1,"NULL"); }
				| IDENTIFICADOR TipoDato DEFAULT Op_Valores {Op.Ordenar(); Op.Interprete(); Variables.Interprete($1,Op.Recorrer()); Op.Vaciar();}
;

Sen_Set
        : SET valores_asignar
;

valores_asignar
            : ValorVariable Signo Op_Valores 
			| ValorVariable Signo Op_Valores COMA valores_asignar
			| ValorVariable IGUAL Sen_Llamada
;

Signo
    : IGUAL
	| DIFERENCIA
	| MENOR
	| MENOR_IGUAL
	| MAYOR
	| MAYOR_IGUAL
;

valor 
    : ENTERO {guardar.Interprete(Number($$)); }
	| CADENA {guardar.Interprete($$); }
	| DECIMAL {guardar.Interprete(Number($$)); }
	| BOOLEAN {guardar.Interprete(JSON.parse($$.toLowerCase())); } // lo volvemos booleano
	| DATES {guardar.Interprete($$); }
	| NULL {guardar.Interprete($$); }
;

Op_Valores
        : valor
		| valor Signos_Declaraciones Op_Valores {guardar.GetSignos().push($2)}
;

Signos_Declaraciones
                : MAS
				| MENOS
				| POR
				| DIVISION
				| MODULO
;

SEN_Select
        : SELECT IDENTIFICADOR {console.log(PrintVars.GetValor($2)); }
;

// DML
instruccion_CTable
                : NOMBRESTABLAS TipoDato
				| NOMBRESTABLAS TipoDato COMA instruccion_CTable
;

Sen_CTable
        : CREATE TABLE NOMBRESTABLAS P_Abre instruccion_CTable P_Cierra PUNTO_C
;

instruccion_ATable
                : ADD NOMBRESTABLAS
				| DROP COLUMN NOMBRESTABLAS
				| RENAME TO NOMBRESTABLAS
				| RENAME COLUMN NOMBRESTABLAS TO NOMBRESTABLAS
				| DROP TABLE NOMBRESTABLAS
;

Sen_ATable
        : ALTER TABLE NOMBRESTABLAS instruccion_ATable PUNTO_C
;

Sen_Insert 
        : INSERT INTO NOMBRESTABLAS P_Abre instruccion_Sen_Insert_Columns P_Cierra VALUES P_Abre instruccion_Sen_Insert_Values P_Cierra
;


instruccion_Sen_Insert_Columns 
                : NOMBRESTABLAS
				| NOMBRESTABLAS COMA instruccion_Sen_Insert_Columns
;

variables_Select
                : NOMBRESTABLAS
				| Sen_Casteo

;

instruccion_Sen_Select 
                : variables_Select
				| variables_Select COMA instruccion_Sen_Select 
;

instruccion_Sen_Insert_Values 
                : valor
				| valor COMA instruccion_Sen_Insert_Values
;

Sen_Select_DML 
            : SELECT instruccion_Sen_Select FROM NOMBRESTABLAS 
; 

Sen_SelectFrom_DML
                : SELECT POR FROM NOMBRESTABLAS PUNTO_C
;

Sen_SelectClausula_DML
                : Sen_Select_DML WHERE Condicion PUNTO_C
;

Condicion  
		: ValorVariable
		| ValorVariable Signos_Condicion Condicion
;

ValorVariable
            : IDENTIFICADOR
			| valor
			| NOMBRESTABLAS
;

Signos_Condicion
                : Signo
				| AND
				| OR
				| NOT
;

Sen_SelectAs
            : SELECT IDENTIFICADOR AS NOMBRESTABLAS PUNTO_C
;

Sen_update
    : UPDATE NOMBRESTABLAS Sen_Set WHERE Condicion PUNTO_C
;

Sen_truncate
        : TRUNCATE TABLE NOMBRESTABLAS PUNTO_C
;

Sen_Delete
        : DELETE FROM NOMBRESTABLAS WHERE Condicion PUNTO_C
;

Sen_Casteo
        : CAST P_Abre ValorVariable AS TipoDato P_Cierra
;

If_Simple
        : IF Condicion THEN BEGIN instrucciones END IF PUNTO_C
;

If_Else
    : IF Condicion THEN instrucciones ELSE instrucciones END IF PUNTO_C
;

Case_Simple
        : CASE ValorVariable instrucciones_Case_Simple ELSE ValorVariable END AS ValorVariable PUNTO_C
;

instrucciones_Case_Simple
                        : WHEN ValorVariable THEN ValorVariable
						| WHEN ValorVariable THEN ValorVariable instrucciones_Case_Simple
;

Case_Buscado
            : CASE instrucciones_Case_Buscado ELSE ValorVariable END PUNTO_C
;

instrucciones_Case_Buscado
                        : WHEN Condicion THEN ValorVariable
						| WHEN Condicion THEN ValorVariable instrucciones_Case_Buscado
;

Sen_While
        : WHILE Condicion Encapsular_Sen
;

Sen_For
    : FOR NOMBRESTABLAS IN ENTERO PUNTO PUNTO ENTERO BEGIN instrucciones END LOOP PUNTO_C
;

Sen_Funciones
            : CREATE FUNCTION NOMBRESTABLAS P_Abre variables P_Cierra RETURNS TipoDato BEGIN instrucciones RETURN IDENTIFICADOR PUNTO_C END PUNTO_C
;

Sen_Metodos
        : CREATE PROCEDURE NOMBRESTABLAS variables AS Encapsular_Sen
;

Llamadas_Metodos
                : SELECT Sen_Llamada PUNTO_C
;

Sen_Llamada
        : NOMBRESTABLAS P_Abre Parametros_Llamada P_Cierra
;

Parametros_Llamada
                : IDENTIFICADOR 
				| IDENTIFICADOR COMA Parametros_Llamada
;

Sen_Print
        : PRINT Entrada_Print PUNTO_C {Op.Ordenar(); Op.Interprete(); console.log(Op.Recorrer()); Op.Vaciar();  }
;

Entrada_Print
            : valores_Print
			| valores_Print Signos_Declaraciones Entrada_Print {guardar.GetSignos().push($2)}
;

valores_Print
    : ENTERO {guardar.Interprete(Number($$))}
	| CADENA {guardar.Interprete($$)}
	| DECIMAL {guardar.Interprete(Number($$))}
	| BOOLEAN {guardar.Interprete(JSON.parse($$.toLowerCase()))} // lo volvemos booleano
	| DATES {guardar.Interprete($$)}
	// para estas dos últimas se necesita extraer el valor exacto
	| IDENTIFICADOR { guardar.Interprete(PrintVars.GetValor($$)); }
	| NOMBRESTABLAS
;

Sen_Lower
        : SELECT LOWER P_Abre CADENA P_Cierra PUNTO_C
;

Sen_Upper
        : SELECT UPPER P_Abre CADENA P_Cierra PUNTO_C
;

Sen_Round
        : SELECT ROUND P_Abre DECIMAL COMA ENTERO P_Cierra PUNTO_C
;

Sen_Length
        : SELECT LEN P_Abre CADENA P_Cierra PUNTO_C
;

Sen_truncate_Nativa
                : SELECT TRUNCATE P_Abre DECIMAL COMA ENTERO P_Cierra PUNTO_C
;

Sen_TypeOf
        : SELECT TYPEOF P_Abre valor P_Cierra PUNTO_C
;