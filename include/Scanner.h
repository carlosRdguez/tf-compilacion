#ifndef SCANNER_H
#define SCANNER_H

#include <map>
#include <string>

using namespace std;

class Scanner
{
public:
    Scanner(char* ruta_archivo_codigo_fuente);
    string getNextToken();
    int getCurrentLine();
    virtual ~Scanner();
};

#endif // SCANNER_H
