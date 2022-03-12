#include <iostream>
#include "Scanner.h"
using namespace std;

int main(){
    Scanner scanner("Vitral\\tabla.txt", "Vitral\\especificacion_lenguaje.elv");
    if(scanner.recognizeSourceCode("test_program.pas")) {
        cout << "Programa fuente reconocido" << endl;
    }
    else {
        cerr << "!!!Programa fuente no reconocido" << endl;
    }

    //scanner.imprimirCodigoFuenteTokenizado("test_program.pas");
    return 0;
}
