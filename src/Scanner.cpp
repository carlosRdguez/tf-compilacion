#include "Scanner.h"
#include "../lex.yy.c"
#include <iostream>

Scanner::Scanner(char* ruta_archivo_codigo_fuente) {
    // abrir archivo de codigo fuente
    yyin = fopen(ruta_archivo_codigo_fuente, "r" );
}

string Scanner::getNextToken() {
    int token = yylex();
    char* texto_del_token = yytext;
    switch (token) {
        case PALABRA_RESERVADA : return yyreservada;
        case IDENTIFICADOR : return "IDENTIFICADOR";
        case LITERAL_ENTERA : return "LITERAL_ENTERA";
        case LITERAL_BOOLEANA : return "LITERAL_BOOLEANA";
        case LITERAL_CADENA : return "LITERAL_CADENA";
        case OPERACION_ARITMETICA : return texto_del_token;
        case OPERACION_RELACIONAL : return texto_del_token;
        case INSTRUCCION_READ : return "READ";
        case INSTRUCCION_WRITE : return "WRITE";
        case PUNTO : return texto_del_token;
        case DOS_PUNTOS : return texto_del_token;
        case COMA : return texto_del_token;
        case PUNTO_Y_COMA : return texto_del_token;
        case PARENTESIS : return texto_del_token;
        case SALTO_DE_LINEA : return "\n";
        case PESO : return "$";
        default : return "###TOKEN DESCONOCIDO###";
    }
}

int Scanner::getCurrentLine() {
    return yylinea;
}

Scanner::~Scanner() {
    //dtor
}
