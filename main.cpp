#include <bits/stdc++.h>
#include "lex.yy.c"

using namespace std;

/*!
    yyin => archivo de codigo fuente para analisis lexicografico
    yylex() => funcion para adquirir token
    yytext => texto del token
    yyleng => tamaño del token
*/



int main()
{
    map <int, string> m;
    m[LT]="LT";
    m[LE]="LE";
    m[EQ]="EQ";
    m[NE]="NE";
    m[GT]="GT";
    m[GE]="GE";
    m[IF]="IF";
    m[THEN]="THEN";
    m[ELSE]="ELSE";
    m[ID]="ID";
    m[RES]="RES";
    m[NUMBER]="NUMBER";
    m[RELOP]="RELOP";
    m[COMA] = "COMA";
    m[PUNTO] = "PUNTO";
    m[DOSPUNTOS]
    m[PUNTOYCOMA]="PUNTOYCOMA";
    m[PESO]="PESO";

    yyin = fopen("test_program.pas", "r" );

    int token;
    do {
        token = yylex();

        if (token == RELOP) {
          cout << "$$$<" << m[yylval] << ">$$$\n";
        }
        else {
            cout << "&&&<" << yytext << " " << m[token] << ">&&&\n";
        }

    } while (token != PESO);

    return 0;
}
