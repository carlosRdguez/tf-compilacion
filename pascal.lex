/*========================================== DEFINICIONES DEL PROGRAMADOR ==========================================*/

%{
    /* Estas variables se retornan como enteros */

	typedef enum {
        IF, THEN, ELSE, // condicionales
        LT, LE, EQ, NE, GT, GE, RELOP, // comparaciones
        PESO
	} Terminal;

	int yylval; // se guarda la operacion de comparacion especifica
	int installID();
	int installNum();

%}

%option noyywrap

/*========================================== RELAS SINTACTICAS DEL LENGUAJE ==========================================*/



delimitador [ \t\n]
separador_de_palabras {delimitador}+
digito [0-9]
cte_real {digito}+(\.{digito}+)?(E[+-]?{digito}+)?
cte_entera {digito}+
cte_boolena true|false
cte_caracter [A-Za-z]
identificador {cte_caracter}({cte_caracter}|{digito})*
programa {encabezamiento_de_programa} {bloque}.
encabezamiento_de_programa_program {identificador}
bloque {parte_definicion_de_tipo} {parte_declaracion_de_variable} {parte_de_instrucciones} {cuerpo_del_bloque}
cuerpo_de_bloque {inicio_de_bloque} {lista_de_instrucciones} end
lista de instrucciones {instruccion} | {lista_de_instrucciones}; {instruccion}
instruccion {instruccion_etiquetada} | {instruccion_no_etiquetada}
instruccion_etiquetada {etiquetada} : {instruccion_no_etiquetada}
etiquetada {identificador}
instruccion_no_etiquetada {asignacion} | {desvio} | {case} | {lazo_for} | {lazo_repeat} I {lazo_while} | {condicional} {llamado_a_procedimiento} | {instruccion_compuesta} {vacio}
parte_definicion_de_tipo type {lista_definicion_de_tipo}; {vacio}
lista_definicion_de_tipo {definicion_de_tipo} | {lista_definicion_de_tipo}; {definicion de tipo}
definicion_de_tipo {identificador_de_tipo} = {tipo}
identificador_de_tipo {identificador}
tipo {tipo_simple} | {tipo_record} | {tipo_arreglo}
tipo_simple {identificador}
tipo_record {inicio_de_record} {lista_de_campos} end
inicio_de_record record
lista_de_campos {campo} | {lista de campos}; {campo}
campo {especificadores_de_campo} : {tipo_simple}
especificadores_de_campo {identificador} | {especificadores_de_campo}, {identificador}
tipo_arreglo array[{lista_de_pares_de_cotas}] of {tipo_record} | array [{lista_de_pares_de_cotas}[ of {tipo_simple}
lista_de_pares_de_cotas {par_de_cotas} | {lista de pares de cotas}; {par de cotas}
par_de_cotas {expr} .. {expr}
parte_declaracion_de_variables var {lista_de_declaracion_de_variables}; | {vacio}
lista_de_declaracion_de_variables {declaracion_de_variable} | {lista_de_declaracion_de_variables}; {declaracion_de_variable}
declaracion_de_variable {lista_de_variables} : {tipo}
lista_de_variables {identificador} | {lista de variables}; {identificador}
parte_declaracion_de_procedimientos_y_funciones  {declaracion_de_funcion_o_procedimiento} | {parte_declaracion_de_procedimientos_y_funciones}; {declaracion_de_funcion_o_procedimiento} | {vacio}
declaracion_de_funcion_o_procedimiento {declaracion de funcion} | {declaracion_de_procedimiento}
declaracion_de_funcion {encabezamiento_de_funcion}; {bloque} | {encabezamiento_de_funcion}; forward | {encabezamiento_de_funcion_sin_parms}; {bloque}
encabezamiento_de_funcion | function {identificador_de_funcion} ({parametros_formales}) : {tipo}
encabezamiento_de_funcion_sin_par function {identificador}
condicional {parte_then} {instruccion} {clausula_if} {instruccion}
parte_then {clausula_if} {instruccion} else
clausula_if if {expr} then
lazo_while {condicion} {instruccion}
condicion {comienzo_while} {expr} do
comienzo_while while
lazo_repeat {comienzo_repeat} {instruccion} until {expr}
comienzo_repeat_ repeat
lazo_for {control_de_ciclo_to} do {instruccion} {control_de_ciclo_downto} do {instruccion}
control_de_ciclo_to {inicio_de_ciclo} to {expr}
control_de_ciclo_downto {inicio_de_ciclo} downto {expr}
inicio_de_ciclo for {variable} := {expr}
case {encabezamiento_case} {lista_de_alternativas} end
encabezamiento_case case {expr} of
lista_de_alternativas  {alternativa} | {lista de alternativas}; {alternativa}
alternativa {lista_de_etiquetas_case} : {instruccion_no_etiquetada}
lista_de_etiquetas case {etiqueta case} | {lista_de_etiquetas_case} : {etiqueta case}
etiqueta_case {cteentera} | {ctecaracter}
desvio goto {identificador}
asignacion {variable} := {expr}
expr {expr_simple} | {expr_simple} {op_relacional} {expr_simple}
op_relacional = | <> | < | > | <= | >= 
expr_simple:= {term} | + {term} | - {term} | {expr_simple} + {term} | {expr_simple} - {term} or {term}
term {factor} | {term} * {factor} | {term} | {factor} {term} div {factor} | {term} mod {factor} | {term} and {factor}
factor {variable} | {constante_sin_signo} | ({expr}) | not {factor} | {designador_de_funcion}
variable {variable_completa} | {elemento_de_arreglo} | {componente_de_record}
variable_completa {identificador}
elemento_dearreglo {nombre_de_arreglo} [{lista_de_indices}]
lista_de_indices {expr} | {lista de indices}, {expr}
nombre de arreglo {identificador}
componente_de_record {nombre de record}.{identificadores_de_campo}
nombre_de_record {identificador}
identificadores_de_campo {identificador} {identificadores_de_campo}.{identificador}
constante_sin_signo {cte-entera} | {cte-caracter} | {cte-booleana} | {cte_real}
designador_de_funcion {identificador_de_funcion}  ({lista_de_parametros_reales})
identificador_de_funcion {identificador}
lista_de_parametros_reales {expr} | {lista_de_parametros_reales} , {expr}




/*========================================== TOKENS A ADQUIRIR ==========================================*/


%%


{separador_de_palabras}		{/* no action and no return */}
if		{return(IF);}
then		{return(THEN);}
else		{return(ELSE);}
{identificador}		{yylval = (int) installID(); return(ID);}
{cte_real}	{yylval = (int) installNum() ; return(NUMBER);}
"<"		{yylval = LT; return(RELOP);}
"<="		{yylval = LE; return(RELOP);}
"="		{yylval = EQ ; return(RELOP);}
"<>"		{yylval = NE; return(RELOP);}
">"		{yylval = GT; return(RELOP);}
">="		{yylval = GE; return(RELOP);}
<<EOF>>	{return(PESO);}


%%

/*========================================== FUNCIONES DEL PROGRAMADOR ==========================================*/


int installID() {/* 	function to install the lexeme, whose
				first character is pointed to by yytext,
				and whose length is yyleng, into the
				symbol table and return a pointer
				thereto */
    return 1;
}

int installNum() {/* 	similar to installID, but puts numerical
				constants into a separate table */
    return 1;
}



