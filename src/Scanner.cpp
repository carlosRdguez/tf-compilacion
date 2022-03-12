#include "Scanner.h"
#include "../lex.yy.c"
#include <iostream>
#include <fstream>

#define indice(s, a) make_pair(s, a)

Scanner::Scanner(char* ruta_archivo_tabla, char* ruta_especificacion_del_lenguaje) {
    // obtener reglas especificadas por Vitral
    obtenerReglas(ruta_especificacion_del_lenguaje);
    //for(int i = 0; i < reglasSintacticas.size(); i++)
    //    cout << i << " " << reglasSintacticas[i] << endl;
    // crear tabla accion
    createTable(ruta_archivo_tabla);
    //for(map<pair<int, string>, Accion>::iterator it = ACCION.begin(); it != ACCION.end(); it++)
    //    cout << "(Q" << it->first.first << ", " << it->first.second << ") = " << it->second << endl;
    //for(int i = 0; i < reglasSintacticas.size(); i++)
    //    cout << i << " " << reglasSintacticas[i] << "\t==>>\t" << reglasSintacticas[i].longitudDelCuerpo() << endl;

}

string Scanner::getNextToken() {
    int token = yylex();
    char* texto_del_token = yytext;
    // ignorar saltos de linea
    if(string(LEX_nombreToken) == "\n") {
        return getNextToken();
    }
    return string(LEX_nombreToken);
}

bool Scanner::recognizeSourceCode(char* ruta_archivo_codigo_fuente) {
    yyin = fopen(ruta_archivo_codigo_fuente, "r" );
    vector<Regla> reglasReducidas;
    // primer token reconocido
    string a = getNextToken();
    int s = 0;
    sintacticStack.push(s);
    while(1) {
        /*
        stack<int> _copy = sintacticStack;
        vector<int> v;
        while(!_copy.empty()) {
            v.push_back(_copy.top());
            _copy.pop();
        }
        cout << "[ ";
        for(int i = v.size()-1; i >=0; i--) {
            cout << v[i] << " ";
        }
        cout << "]" << " " << a << endl;
        */
        //cout << ACCION[indice(0, "PROGRAM")] << endl;
        if(ACCION[indice(s, a)].tipo == shift_t) {
            // operaciones sobre la pila sintactica
            //cout << "S " << ACCION[indice(s, a)].estado << endl;
            sintacticStack.push(ACCION[indice(s, a)].estado);
            a = getNextToken();
            // operaciones sobre el parser
        }
        else if(ACCION[indice(s, a)].tipo == reduce_A_B) {
            // operaciones sobre la pila sintactica
            Regla* regla_reducida = ACCION[indice(s, a)].regla;
            // eliminar |B| simbolos de la pila
            for(int i = 0; i < regla_reducida->longitudDelCuerpo(); i++) {
                sintacticStack.pop();
            }
            int nuevo_tope = sintacticStack.top();
            // apilar estado correspondiente
            //cout << nuevo_tope << ", " << regla_reducida->cabecera << endl;
            //cout << ACCION[indice(nuevo_tope, regla_reducida->cabecera)] << endl;
            //cout << "R " << ACCION[indice(nuevo_tope, regla_reducida->cabecera)].estado << endl;
            reglasReducidas.push_back(*regla_reducida);
            sintacticStack.push(ACCION[indice(nuevo_tope, regla_reducida->cabecera)].estado);
            // operaciones sobre el parser
        }
        else if(ACCION[indice(s, a)].tipo == accept) {
             // imprimir reglas reducidas
             for(int i = 0; i < reglasReducidas.size(); i++)
                cout << i+1 << " " << reglasReducidas[i] << endl;
             return true;
            // operaciones sobre el parser
        }
        else {
            return false;
        }
        s = sintacticStack.top();
    }
    return true;
}

void Scanner::obtenerReglas(char* ruta_especificacion_del_lenguaje){
    ifstream archivo_especificacion_lenguaje(ruta_especificacion_del_lenguaje);
    string linea;
    bool seccion_reglas_sintacticas = false;
    while(getline(archivo_especificacion_lenguaje, linea)) {
        if(linea.size() != 0) {
            if(linea.find("%%") != string::npos && !seccion_reglas_sintacticas) {
                seccion_reglas_sintacticas = true;
                continue;
            }
            else if(linea.find("%%") != string::npos && seccion_reglas_sintacticas) {
                // fin de seccion de reglas sintacticas
                break;
            }
            else if(seccion_reglas_sintacticas && linea.size() != 0){
                // regla sintactica
                string cabecera = linea.substr(0, linea.find("->"));
                if(cabecera.find("begin") != string::npos) {
                    cabecera = cabecera.substr(6);
                }
                string regla = linea.substr(linea.find("->")+2, linea.find(";")-linea.find("->")+2);
                //cout << regla << endl;
                // separar regla por caracter '|'
                size_t index = 0;
                while(index != string::npos) {
                    if(regla.find("|", index+1) != string::npos) {
                        //cout << "\t" << regla.substr(index, regla.find("|", index)-index) << endl;
                        reglasSintacticas.push_back(Regla(cabecera, regla.substr(index, regla.find("|", index)-index)));
                    }
                    else {
                        //cout << "\t" << regla.substr(index, regla.size()-index-1) << endl;
                        reglasSintacticas.push_back(Regla(cabecera, regla.substr(index, regla.size()-index-1)));
                        break;
                    }
                    index = regla.find("|", index+1)+1;
                }
            }
        }
    }
    archivo_especificacion_lenguaje.close();
}

int Scanner::obtenerLineaActual() {
    return LEX_lineaActual;
}

void Scanner::createTable(char* ruta_archivo_de_tabla) {
    ifstream archivo_tabla(ruta_archivo_de_tabla);
    string linea;
    while(getline(archivo_tabla, linea)) {
        if(linea.size() != 0) {
            //cout << linea << endl;
            if(linea.find("action") != string::npos) {
                int estado_partida = atoi(linea.substr(8, linea.find(",")-8).c_str());
                string terminal = linea.substr(linea.find(",")+2, linea.find("]")-linea.find(",")-2);
                if(linea.substr(linea.find("="), 3) == "= S") {
                    int nuevo_estado = atoi(linea.substr(linea.find("=")+3).c_str());
                    //cout << estado_partida << ", " << terminal << ", S" << nuevo_estado << endl;
                    ACCION[indice(estado_partida, terminal)] = Accion(shift_t, nuevo_estado);
                }
                else if(linea.substr(linea.find("="), 3) == "= R") {
                    // obtener regla
                    int numero_de_regla = atoi(linea.substr(linea.find("R")+1).c_str());
                    //cout << estado_partida << ", " << terminal << ", R" << numero_de_regla << endl;
                    ACCION[indice(estado_partida, terminal)] = Accion(reduce_A_B, reglasSintacticas[numero_de_regla]);
                }
                else if(linea.find("= acc")+5 == linea.size()) {
                    //cout << estado_partida << ", " << terminal << ", accepta" << endl;
                    ACCION[indice(estado_partida, terminal)] = Accion(accept);
                }
            }
            else if(linea.find("goto") != string::npos) {
                int estado_partida = atoi(linea.substr(6, linea.find(",")-6).c_str());
                string terminal = linea.substr(linea.find(",")+2, linea.find("]")-linea.find(",")-2);
                int nuevo_estado = atoi(linea.substr(linea.find("=")+2).c_str());
                //cout << estado_partida << ", " << terminal << ", G" << nuevo_estado << endl;
                ACCION[indice(estado_partida, terminal)] = Accion(_goto, nuevo_estado);
            }
        }
    }
    archivo_tabla.close();
}

void Scanner::imprimirCodigoFuenteTokenizado(char* ruta_archivo_codigo_fuente){
    yyin = fopen(ruta_archivo_codigo_fuente, "r" );
    cout << "1 ";
    string token = getNextToken();
    transform(token.begin(), token.end(), token.begin(), ::toupper);
    while(token != "$") {
        if(token == "\n") {
            cout << token << obtenerLineaActual() << " ";
        }
        else {
            cout << token << " ";
        }
        token = getNextToken();
        transform(token.begin(), token.end(), token.begin(), ::toupper);
    }

}

Scanner::~Scanner() {
    //dtor
}
