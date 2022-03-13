program fibonacci(input, output);
var
	n : integer;
	recurrencia : integer;
	salida : integer;
begin
	Read("introduzca el termino de la sucesion de fibonacci que desea visualizar", n);
	recurrencia := 1;
	salida:=q;
	for i:=0 to n do
	begin
		recurrencia := salida;
		salida := salida + recurrencia;
	end;
	Write("El ", n, " esimo termino de la sucesion de fibonacci es ", salida);
end.
