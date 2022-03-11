#include <iostream>
#include "Scanner.h"
using namespace std;

int main()
{
    Scanner scanner("test_program.pas");
    string nextToken = scanner.getNextToken();
    cout << scanner.getCurrentLine() << " ";
    do {
        if(nextToken != "\n") {
            cout << nextToken << " ";
        }
        else {
            cout << "\n" << scanner.getCurrentLine() << " ";
        }
        nextToken = scanner.getNextToken();
    }while(nextToken != "$");


    return 0;
}
