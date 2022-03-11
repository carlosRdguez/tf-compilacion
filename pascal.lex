%{
    #include <cstring>
	typedef enum {
        PALABRA_RESERVADA,
        PUNTO, DOS_PUNTOS, PUNTO_Y_COMA, COMA, PARENTESIS,
        OPERACION_ARITMETICA, OPERACION_RELACIONAL,
        INSTRUCCION_READ, INSTRUCCION_WRITE,
        LITERAL_ENTERA, LITERAL_BOOLEANA, LITERAL_CADENA,
        IDENTIFICADOR,
        SALTO_DE_LINEA, PESO,
	} Terminal;

    char yyreservada[20];
    int yylinea = 1;

%}

%option noyywrap

/* regular definitions */
separador		[ \t]
separador_de_tokens {separador}+
salto_de_linea \n
digito [0-9]
punto \.
dos_puntos \:
punto_y_coma \;
coma \,
operador_asignacion \:\=
operador_suma \+
operador_resta \-
operador_multiplicacion \*
operador_division \/
operador_igualdad \=
operador_diferente \<\>
operador_menor \<
operador_menor_o_igual \<\=
operador_mayor \>
operador_mayor_o_igual \>\=
parentesis {parentesis_abierto}|{parentesis_cerrado}
parentesis_abierto \(
parentesis_cerrado \)
instruccion_read (r)|(R)ead(Ln|ln)?
instruccion_write (w)|(W)rite(Ln|ln)?
literal_entera {digito}+
literal_booleana true|false
literal_caracter [A-Za-z]
palabra ({digito}|{literal_caracter}|\¿|\?|\!|\¡|{parentesis}|{coma}|{dos_puntos})*
literal_cadena \"{palabra}(\ {palabra})*\"
identificador ({literal_caracter}|\_)(({literal_caracter}|\_)|{digito})*



%%

{separador_de_tokens} {}
{salto_de_linea} {yylinea++; return(SALTO_DE_LINEA);}


program {strcpy(yyreservada, "PROGRAM"); return(PALABRA_RESERVADA);}
input {strcpy(yyreservada, "INPUT"); return(PALABRA_RESERVADA);}
output {strcpy(yyreservada, "OUTPUT"); return(PALABRA_RESERVADA);}
begin {strcpy(yyreservada, "BEGIN"); return(PALABRA_RESERVADA);}
end {strcpy(yyreservada, "END"); return(PALABRA_RESERVADA);}
var {strcpy(yyreservada, "VAR"); return(PALABRA_RESERVADA);}
integer {strcpy(yyreservada, "INTEGER"); return(PALABRA_RESERVADA);}
bool {strcpy(yyreservada, "BOOL"); return(PALABRA_RESERVADA);}
string {strcpy(yyreservada, "STRING"); return(PALABRA_RESERVADA);}
if {strcpy(yyreservada, "IF"); return(PALABRA_RESERVADA);}
then {strcpy(yyreservada, "THEN"); return(PALABRA_RESERVADA);}
else {strcpy(yyreservada, "ELSE"); return(PALABRA_RESERVADA);}
for {strcpy(yyreservada, "FOR"); return(PALABRA_RESERVADA);}
to {strcpy(yyreservada, "TO"); return(PALABRA_RESERVADA);}
do {strcpy(yyreservada, "DO"); return(PALABRA_RESERVADA);}


{punto} {return(PUNTO);}
{dos_puntos} {return(DOS_PUNTOS);}
{punto_y_coma} {return(PUNTO_Y_COMA);}
{coma} {return(COMA);}


{operador_asignacion} {return(OPERACION_ARITMETICA);}
{operador_suma} {return(OPERACION_ARITMETICA);}
{operador_resta} {return(OPERACION_ARITMETICA);}
{operador_multiplicacion} {return(OPERACION_ARITMETICA);}
{operador_division} {return(OPERACION_ARITMETICA);}
{operador_igualdad} {return(OPERACION_RELACIONAL);}
{operador_diferente} {return(OPERACION_RELACIONAL);}
{operador_menor} {return(OPERACION_RELACIONAL);}
{operador_menor_o_igual} {return(OPERACION_RELACIONAL);}
{operador_mayor} {return(OPERACION_RELACIONAL);}
{operador_mayor_o_igual} {return(OPERACION_RELACIONAL);}


{parentesis_abierto} {return(PARENTESIS);}
{parentesis_cerrado} {return(PARENTESIS);}


{instruccion_read} {return(INSTRUCCION_READ);}
{instruccion_write} {return(INSTRUCCION_WRITE);}


{literal_booleana} {return(LITERAL_BOOLEANA);}
{literal_entera} {return(LITERAL_ENTERA);}
{literal_cadena} {return(LITERAL_CADENA);}


{identificador} {return(IDENTIFICADOR);}

<<EOF>>	{return(PESO);}


%%


