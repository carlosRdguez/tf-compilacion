#include <iostream>
#include "Scanner.h"
using namespace std;

int main(int argc, char** argv){
    system("title Reconocedor de un subconjunto de reglas de Pascal");
    switch (argc) {
        // se llamo al programa sin parametros
        case 1: {
            cout << "Debe especificar un programa fuente" << endl;
            system("pause");
            break;
        }
        // se llamo al programa para imprimir texto de programa fuente tokenizado
        case 2: {
            string ruta_programa_fuente = string(argv[1]);
            Scanner::imprimirCodigoFuenteTokenizado(ruta_programa_fuente);
            break;
        }
        // se llamo al programa para reconocer un programa fuente
        case 4: {
            // el primer parametro es la ruta del programa fuente
            string ruta_programa_fuente = string(argv[1]);
            // el segundo parametro es la ruta de la tabla ACCION
            string ruta_de_tabla_accion = string(argv[2]);
            // el tercer parametro es la ruta de la especificacion del lenguaje de Vitral
            string ruta_especificacion_lenguaje = string(argv[3]);
            // creando scanner
            Scanner scanner(ruta_de_tabla_accion.c_str(), ruta_especificacion_lenguaje.c_str());
            // mostrando salida del proceso de reconocimiento mediante la tecnica ascendente LR(1)
            cout << scanner.recognizeSourceCode(ruta_programa_fuente.c_str());
            break;
        }
        default: {
            cout << "Numero incorrecto de parametros";
        }
    }


    return 0;
}
