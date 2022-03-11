program prueba(input, output);
var cantidad_de_personas : integer;
var
    texto_informativo, nombre : string;
var edad : integer;
var casado : bool;
begin
    texto_informativo := "Ingrese la cantidad de personas : ";
    Write(texto_informativo, cantidad_de_personas);
    for i:=0 to cantidad_de_personas do
    begin
        Read("Ingrese un nombre: ", nombre);
        Read("Ingrese su edad", edad);
        Write(nombre, ", es usted casado(a)?");
        Read(casado);
        if(casado <> false) then
            if(edad < 18) then
                Write(nombre, " es menor de edad");
            if(edad >= 18) then
                Write(nombre, " es mayor de edad");
            Write(nombre, "tiene ", edad, "annos y esta casado");
        else
            Write(nombre, "tiene ", edad, "annos y no esta casado");
    end;
end.
