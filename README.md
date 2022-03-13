<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="punto_y_coma.ico" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">reconocedorPascal</h3>

  <p align="center">
    Reconocedor de lenguajes definidos en Vitral para la asignatura Compilación.
    <br />
    <br />
    <a href="mailto: carlosarl1999@gmail.com">
      <img style="border-radius:50%;" src="https://avatars.githubusercontent.com/u/88565467?s=96&v=4" alt="Logo" width="40" height="40"> Carlos Alberto Rodríguez Losada
    </a>
    <br />
    <br />
    <a href="mailto: william.rodriguez@estudiantes.uo.edu.cu">
      <img src="https://avatars.githubusercontent.com/u/75134609?v=4" alt="Logo" width="40" height="40"> William Rodríguez Burrel
    </a>
    <br />
    <br />
    <a href="mailto: yasmany2308@nauta.cu">
      <img src="https://scontent-mia3-1.xx.fbcdn.net/v/t1.6435-9/107290920_641151096475795_3169308100550859256_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=8OecGNm9CuoAX-cai1q&_nc_ht=scontent-mia3-1.xx&oh=00_AT8OMQ0aDTyHOb2H6l3W0QzvZiZEP3LUsdRoE10F9Lj7WA&oe=625348DB" alt="Logo" width="40" height="40">   Yasmani Peña Benítez
    </a>
  </p>
</div>

<!-- GETTING STARTED -->
## Ejemplo de Uso

_A continuación se muestra un ejemplo de como usar el programa_

1. Clone el repo
   ```sh
   git clone https://github.com/carlosRdguez/tf-compilacion.init
   ```
2. Para reconocer un programa fuente debe abrir una consola en /bin/Release/ y ejecutar el programa pasándole como parámetros la ruta del programa fuente,
la ruta del archivo de tabla ACCION generado por Vitral 1.0 y el archivo de especificación de lenguaje creado en Vitral 1.0

   ```sh
   reconocedorPascal.exe "../../test_program.pas" "../../Vitral/tabla.txt" "../../Vitral/especificacion_lenguaje.elv"
   ```
4. Si desea visulizar la tokenizacion del programa fuente puede usar el siguiente código
   ```sh
   reconocedorPascal.exe "../../test_program.pas"
   ```
