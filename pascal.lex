%{
    #include <cstring>
	typedef enum {
        PALABRA_RESERVADA, TIPO,
        PUNTO, DOS_PUNTOS, PUNTO_Y_COMA, COMA, PARENTESIS,
        OPERACION_ARITMETICA, OPERACION_RELACIONAL,
        INSTRUCCION_READ, INSTRUCCION_WRITE,
        LITERAL_ENTERA, LITERAL_BOOLEANA, LITERAL_CARACTER, LITERAL_CADENA,
        IDENTIFICADOR,
        SALTO_DE_LINEA, PESO,
	} Terminal;

    char LEX_nombreToken[20];
    int LEX_lineaActual = 1;

%}

%option noyywrap

/* regular definitions */
separador [\t ]
separador_de_tokens {separador}+
salto_de_linea \n
punto \.
dos_puntos \:
punto_y_coma \;
coma \,
operador_asignacion \:\=
operador_suma \+
operador_resta \-
operador_multiplicacion \*
operador_division \/
parentesis_abierto \(
parentesis_cerrado \)
operador_relacional \=|\<\>|\<|\>|\<\=|\>\=
literal_entera 0|[1-9][0-9]*
literal_caracter \'[A-Za-z]\'
identificador ([A-Za-z]|\_)(([A-Za-z]|\_)|[0-9])*
literal_booleana (true)|(false)
literal_cadena \"([A-Za-z]|\ )*\"
tipo (integer)|(bool)|(string)|(char)



%%

{separador_de_tokens} {}
{salto_de_linea} {strcpy(LEX_nombreToken, "\n"); LEX_lineaActual++; return(SALTO_DE_LINEA);}


program {strcpy(LEX_nombreToken, "pr_program"); return(PALABRA_RESERVADA);}
begin {strcpy(LEX_nombreToken, "pr_begin"); return(PALABRA_RESERVADA);}
input {strcpy(LEX_nombreToken, "pr_input"); return(PALABRA_RESERVADA);}
output {strcpy(LEX_nombreToken, "pr_output"); return(PALABRA_RESERVADA);}
end {strcpy(LEX_nombreToken, "pr_end"); return(PALABRA_RESERVADA);}
if {strcpy(LEX_nombreToken, "pr_if"); return(PALABRA_RESERVADA);}
then {strcpy(LEX_nombreToken, "pr_then"); return(PALABRA_RESERVADA);}
else {strcpy(LEX_nombreToken, "pr_else"); return(PALABRA_RESERVADA);}
var {strcpy(LEX_nombreToken, "pr_var"); return(PALABRA_RESERVADA);}
for {strcpy(LEX_nombreToken, "pr_for"); return(PALABRA_RESERVADA);}
to {strcpy(LEX_nombreToken, "pr_to"); return(PALABRA_RESERVADA);}
do {strcpy(LEX_nombreToken, "pr_do"); return(PALABRA_RESERVADA);}
Read {strcpy(LEX_nombreToken, "instruccion_read"); return(PALABRA_RESERVADA);}
Write {strcpy(LEX_nombreToken, "instruccion_write"); return(PALABRA_RESERVADA);}


{punto} {strcpy(LEX_nombreToken, "punto"); return(PUNTO);}
{dos_puntos} {strcpy(LEX_nombreToken, "dos_puntos"); return(DOS_PUNTOS);}
{punto_y_coma} {strcpy(LEX_nombreToken, "punto_y_coma"); return(PUNTO_Y_COMA);}
{coma} {strcpy(LEX_nombreToken, "coma"); return(COMA);}


{operador_asignacion} {strcpy(LEX_nombreToken, "operador_asignacion"); return(OPERACION_ARITMETICA);}
{operador_suma} {strcpy(LEX_nombreToken, "operador_suma"); return(OPERACION_ARITMETICA);}
{operador_resta} {strcpy(LEX_nombreToken, "operador_resta"); return(OPERACION_ARITMETICA);}
{operador_multiplicacion} {strcpy(LEX_nombreToken, "operador_multiplicacion"); return(OPERACION_ARITMETICA);}
{operador_division} {strcpy(LEX_nombreToken, "operador_division"); return(OPERACION_ARITMETICA);}
{parentesis_abierto} {strcpy(LEX_nombreToken, "parentesis_abierto"); return(PARENTESIS);}
{parentesis_cerrado} {strcpy(LEX_nombreToken, "parentesis_cerrado"); return(PARENTESIS);}
{operador_relacional} {strcpy(LEX_nombreToken, "operador_relacional"); return(OPERACION_RELACIONAL);}


{literal_entera} {strcpy(LEX_nombreToken, "literal_entera"); return(LITERAL_ENTERA);}
{literal_caracter} {strcpy(LEX_nombreToken, "literal_caracter"); return(LITERAL_CARACTER);}
{literal_booleana} {strcpy(LEX_nombreToken, "literal_booleana"); return(LITERAL_BOOLEANA);}
{literal_cadena} {strcpy(LEX_nombreToken, "literal_cadena"); return(LITERAL_CADENA);}

{tipo} {strcpy(LEX_nombreToken, "tipo"); return(TIPO);}

{identificador} {strcpy(LEX_nombreToken, "identificador"); return(IDENTIFICADOR);}

<<EOF>>	{strcpy(LEX_nombreToken, "$"); return(PESO);}


%%


