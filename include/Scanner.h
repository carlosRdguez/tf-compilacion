#ifndef SCANNER_H
#define SCANNER_H

#include <map>
#include <vector>
#include <stack>
#include <string>
#include <algorithm>
#include <assert.h>

#include <iostream>

using namespace std;

typedef enum{
    shift_t, reduce_A_B, accept, _goto,
} TipoDeAccion;

class Regla{
public:
    Regla(string _cabecera, string _cuerpo):cabecera(_cabecera), cuerpo(_cuerpo){}
    Regla(string _cabecera_y_cuerpo=""){
        if(_cabecera_y_cuerpo != "") {
            cabecera = _cabecera_y_cuerpo.substr(0, 1);
            cuerpo = _cabecera_y_cuerpo.substr(3);
        }

    }
    int longitudDelCuerpo() {
        int cantidad_de_espacios = count(cuerpo.begin(), cuerpo.end(), ' ');
        if(cantidad_de_espacios == 0) {
            return cuerpo.size() == 0 ? 0 : 1;
        }
        return cantidad_de_espacios-1;
    }
    string cabecera, cuerpo;
};

class Accion {
public:
    Accion() {}
    // accion de tipo reduce
    Accion(TipoDeAccion _tipo, string _terminal_o_regla):tipo(_tipo), regla(new Regla(_terminal_o_regla)){
        assert(_tipo == reduce_A_B);
    }
    // accion de tipo goto o shif
    Accion(TipoDeAccion _tipo, int _estado) :tipo(_tipo), estado(_estado){
        assert(_tipo == _goto || _tipo == shift_t);
    }
    // accion de tipo accepta
    Accion(TipoDeAccion _tipo) {
        assert(_tipo == accept);
        tipo = _tipo;
    }
    friend ostream& operator<<(ostream& output, Accion& obj) {
        switch(obj.tipo) {
            case shift_t:{
                cout << "Shift " << obj.estado;
                break;
            }
            case reduce_A_B:{
                cout << "Reduce " << obj.regla->cabecera << "->" << obj.regla->cuerpo;
                break;
            }
            case _goto:{
                cout << "Goto " << obj.estado;
                break;
            }
            case accept: {
                cout << "accepta";
                break;
            }
        }
        return output;
    }
    TipoDeAccion tipo;
    string terminal;
    Regla* regla;
    int estado;
};

class Scanner
{
public:
    Scanner(char* ruta_archivo_tabla, char* ruta_especificacion_del_lenguaje);
    string getNextToken();
    bool recognizeSourceCode(char* ruta_archivo_codigo_fuente);
    void obtenerReglas(char* ruta_especificacion_del_lenguaje);
    void createTable(char* ruta_archivo_de_tabla);
    int getCurrentLine();
    virtual ~Scanner();
private:
    // mapa[estado, terminal] -> (shift, terminal), (reduce, regla), (accepta, null), (goto, estado)
    map<pair<int, string>, Accion> ACCION;
    vector<string> reglasSintacticas;
    stack<int> sintacticStack;
};

#endif // SCANNER_H
