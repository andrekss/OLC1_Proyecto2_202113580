
const Ejecutar = require("../Language/Parser.js");

const Entrada =`
// variables
char as=true;
int arnica1=1,a="2 as",ds=true,fs=121.2,argentina ='a';

std::string cadena,a = "hola";
char var4 = 'a';
bool flag =(std::string) true;
double a, b, c = 5.5;
a=(double)1 ;
pedo;

// Ejemplos casteos
int edad = (int) 18.6; // toma el valor entero de 18
char letra = (char) 70; // toma el valor 'F' ya que el 70 en ascii es F
double numero = (double) 16; // toma el valor de 16.0

// Incremento y decremento

int edad = 18;
edad++; // tiene el valor de 19
edad--; // tiene el valor de 18

// vectores
int vector1[]=new int[4];
char vector2[][]=new char[4][4];
std::string vector3[]=["Hola","Mundo"];
int vector4[][]=[ [1,2], [3,4] ];

// Acceso a vectores

std::string vector3[]=["Hola","Mundo"];
std::string valor3=vector3[0]; //Almacenaelvalor"hola"
int vector4[][]=[ [1,2], [3,4] ];
int valor4=vector4[0][0]; //Almacenaelvalor1

//modificador de vectores

std::string vector3[]=["Hola","Mundo"];
vector3[0]="OLC1";
vector3[1]="1erSemestre";


// Sentencias de control
// if
if(x<50){
    //sentencias
    vector3[1]="1erSemestre";
}
   
if(x<50){
    vector3[1]="1erSemestre";
}else{
        vector3[1]="1erSemestre";
}

if(x>50){
    vector3[1]="1erSemestre";
}else if(x<50 && x>0){
        vector3[1]="1erSemestre";
}
else if(x<50 && x>0){
    vector3[1]="1erSemestre";
}
else{
        vector3[1]="1erSemestre";
}

// switch
switch(edad){
    Case 10:
    vector3[1]="1erSemestre";
    Break;
    Case 18:
    vector3[1]="1erSemestre";
    Break;
    Case 25:
    vector3[1]="1erSemestre";
    Break;
    Default:
    vector3[1]="1erSemestre";
    Break;
}

// Sentencias cíclicas

while (x<100) {
    vector3[1]="1erSemestre";
}

for(int i=0; i<3; i++){
    vector3[1]="1erSemestre";
}

do{
    vector3[1]="1erSemestre";
    }while(x<100)


for(int i=0; i<3; i++){
    if(i==2){
            break; 
     }
}

for(int i=0; i<5; i++){
    if(i==2){
    continue; //mesalte'massentencias'eni=2
    }
    //massentencias
}

for(int i=0; i<5; i++){
    if(i==2){
    return;
    }
}

for(int i=0; i<5; i++){
    if(i==2){
    returni;
    }
}

int conversion (double size, std::string tipo){
    if(tipo=="metro"){
    return size/3*3.281;
    } else{
    return -1;
    }
    }

    void hola_mundo (){
        return size/3*3.281; //ESTO NO SE PUEDEEEE
        }

void hola_mundo (){
    return size/3*3.281; //ESTO NO SE PUEDEEEE
    }
    hola_mundo();
    int conversion (double size, std::string tipo){
    if(tipo=="metro"){
    return size/3*3.281;
    } else{
    return-1;
    }
    }
    int resultado = conversion(58.5, "metro");

    // impresiones
    cout<<"hola mundo!";
    cout<<"sale compi1\n";
    cout<<"primer semestre"<<endl;
    cout<<2024;
    
    /*Salida esperada:
    hola mundo!sale compi1
    primer semestre
    2024
    */

    // Funciones
    std::string cadena1= tolower("HOLaMundO") ;
    std::string cadena1=toupper("HOLaMundO");

    double valor = round(15.51); //almacena 16
    double valor2 = round(9.40); //almacena 9

    std::string vector[] = ["Hola", "Mundo"];
    std::string cadena = "compi1";
    int sizeVector = vector.length(); //Almacena 2
    int sizeCadena = cadena.length(); //Almacena 6

    std::string vector[]=["Hola","Mundo"];
    std::string cadena="compi1";
    cout<<typeof(cadena)<<endl;
    cout<<typeof(vector)<<endl;

    std::string var=std::toString(1+20+30); //almacena51
    std::string var2=std::toString(true); //almacenatrue

    std::string var1="compi1";
    char caracteres[] =var.c_str();




void funcion1(){
        cout<<"HolaMundo"<<endl;
        cout<<funcion2(10)<<endl;
}
    
int funcion2(int numero){
        return numero;
}
        execute funcion1();
       
        /*Resultado
        HolaMundo
        10
        */

`
const Entrada2 =`
EXECUTE main();

int var1 = 0;

int arreglo1[] = new int[5];
int arreglo2[] = [0,0,1,2,0,0,5,1,0,0,8,0,0];

void main(){
    cout << "Archivo de prueba\n";
    cout << "Si sale compi1" << endl;

    int var1 = 10;

    if(var1 == 0){
        cout << "Manejo de ambitos erroneo :'(" << endl;
    }else{
        cout << "Manejo de ambitos correcto" << endl;
    }

   // tabla de multiplicar
   tablaMultiplicar(5);

   // recursividad
   recursividadBasica();

   // arreglos
    AnalizarArreglo(arreglo1);

    cout << "Fin de la prueba" << endl;

}


void tablaMultiplicar(int valor){
    std::string cadenaSalida = "Final de la tabla de multiplicar";
    for(int i=1; i<=11; i++){
        cout << valor + " x " + i+pow(i,s) + " = " + valor*i << endl;
        if(i==11){
            cout << cadenaSalida << endl;
            break;
        }
    }
}

// probando una funcion recursiva
int mcd(int a, int b){
    if(b==0){
        return pow(a,7);
    }else{
        return mdc(b, a%b);
    }
}

void recursividadBasica(){
    int resultado = mcd(48, 18);

   if(resultado == 6){
        cout << "Funcion recursiva correcta" << endl;
        return;
   }
   cout << "Funcion recursiva incorrecta" << endl;
}

// viendo arreglos
void AnalizarArreglo(int arreglo){
    int temporal, suma, ceros;
    for(int i=0; i<arreglo.length(); i++){
        temporal = arreglo[i];
        if(temporal == 0){
            ceros = ceros + 1;
            continue;
        }
        suma = suma + temporal;
    }
    cout << "La suma de los elementos del arreglo es: " + suma << endl;
    cout << "La cantidad de ceros en el arreglo es: " + ceros << endl;
}

// Salida de archivo de prueba
/*
Archivo de prueba
Si sale compi1
Manejo de ambitos correcto
5 x 1 = 5
5 x 2 = 10
5 x 3 = 15
5 x 4 = 20
5 x 5 = 25
5 x 6 = 30
5 x 7 = 35
5 x 8 = 40
5 x 9 = 45
5 x 10 = 50
Final de la tabla de multiplicar
Funcion recursiva correcta
La suma de los elementos del arreglo es: 17
La cantidad de ceros en el arreglo es: 8
Fin de la prueba
*/
`

//Ejecutar.parse(Entrada2);

const mensaje = "Mensaje sin salto de línea";
console.log(mensaje, "");
console.log("que","")
