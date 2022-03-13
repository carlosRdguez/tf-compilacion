/* Reglas Lexicográficas Auxiliares */



%  /* Reglas Lexicográficas */

ignore separador [\t ];
ignore separador_de_tokens {separador}+;
ignore salto_de_linea \n;
punto \.;
dos_puntos \:;
punto_y_coma \;;
coma \,;
operador_asignacion \:\=;
operador_suma \+;
operador_resta \-;
operador_multiplicacion \*;
operador_division \/;
parentesis_abierto \(;
parentesis_cerrado \);
operador_relacional \=|\<\>|\<|\>|\<\=|\>\=;
literal_entera 0|[1-9][0-9]*;
literal_caracter \'[A-Za-z]\';
identificador ([A-Za-z]|\_)(([A-Za-z]|\_)|[0-9])*;
literal_booleana (true)|(false);
literal_cadena \"([A-Za-z]|\ )*\";
tipo (integer)|(bool)|(string)|(char);

 

pr_program program;
pr_begin begin;
pr_input input;
pr_output output;
pr_end end;
pr_if if;
pr_then then;
pr_else \else;
pr_var var;
pr_for for;
pr_to to;
pr_do do;
instruccion_read Read;
instruccion_write Write;

%%  /* Reglas Sintácticas */

begin S->encabezamiento declaracion_de_variables pr_begin cuerpo pr_end punto;
encabezamiento->pr_program identificador especificacion_del_programa punto_y_coma;
declaracion_de_variables->pr_var lista_declaracion_de_tipos|;
cuerpo->lista_de_instrucciones|;
especificacion_del_programa->parentesis_abierto tipo_de_programa parentesis_cerrado|;
lista_declaracion_de_tipos->declaracion_de_tipo lista_declaracion_de_tipos|declaracion_de_tipo;
lista_de_instrucciones->lista_de_instrucciones instruccion|instruccion;
tipo_de_programa->pr_input|pr_output|pr_input coma pr_output;
declaracion_de_tipo->lista_de_identificadores dos_puntos tipo punto_y_coma;
instruccion->instruccion_asignacion|instruccion_condicional|instruccion_ciclo|instruccion_entrada|instruccion_salida|expresion_aritmetica punto_y_coma;
lista_de_identificadores->identificador coma lista_de_identificadores|identificador;
instruccion_asignacion->identificador operador_asignacion parte_derecha punto_y_coma;
instruccion_condicional->instruccion_condicional_simple|instruccion_condicional_simple instruccion_condicional_else;
instruccion_ciclo->pr_for identificador operador_asignacion fin_de_ciclo pr_to fin_de_ciclo pr_do pr_begin cuerpo pr_end punto_y_coma;
instruccion_entrada->instruccion_read parentesis_abierto parametros_instruccion_entrada parentesis_cerrado punto_y_coma;
instruccion_salida->instruccion_write parentesis_abierto literales_de_cadena_o_identificadores parentesis_cerrado punto_y_coma;
expresion_aritmetica->termino operador_suma expresion_aritmetica|termino operador_resta expresion_aritmetica|termino;
parte_derecha->expresion_aritmetica;
instruccion_condicional_simple->pr_if condicion pr_then cuerpo pr_end punto_y_coma;
instruccion_condicional_else->pr_else cuerpo pr_end punto_y_coma;
fin_de_ciclo->identificador|literal_entera;
parametros_instruccion_entrada->texto_informativo_de_entrada coma lista_de_identificadores|lista_de_identificadores;
literales_de_cadena_o_identificadores->literal_cadena coma literales_de_cadena_o_identificadores|identificador coma literales_de_cadena_o_identificadores|identificador|literal_cadena;
termino->factor operador_multiplicacion termino|factor operador_division termino|factor;
condicion->identificador operador_relacional parte_derecha; 
texto_informativo_de_entrada->literal_cadena|;
factor->identificador|literal_entera|literal_booleana|literal_cadena|literal_caracter|parentesis_abierto expresion_aritmetica parentesis_cerrado;


%%  /* Reglas Semánticas */



%%  /* Operadores de Código Intermedio */



%%