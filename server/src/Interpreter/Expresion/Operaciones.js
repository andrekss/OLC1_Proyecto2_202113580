// Funciones Aritméticas

function Suma(expIzq, expDer, object,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT"){
        object.tipo = 'INT'; 
        object.valor = Number(expIzq + expDer);

       // console.log("Valor "+object.valor)
       // console.log("Tipo "+object.tipo)
        
        return object;
    }else if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE"){
        object.tipo = 'DOUBLE';
        object.valor = Number(expIzq + expDer);
        return object;
    }else if(entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "CHAR"){
        object.tipo = 'STRING';
        object.valor = expIzq + expDer;
        return object;
    }else{
        object.tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return object;
    }

}

function Resta(expIzq, expDer, object,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT"){
        object.tipo = 'INT';
        object.valor = Number(expIzq-expDer);
        return object;
    }else if (entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR" ){
        object.tipo = 'DOUBLE';
        object.valor = Number(expIzq-expDer);
        return object;       
    }else{
        object.tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return object;
    }

}

function Multiplicación(expIzq, expDer, object,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT" ){
        object.tipo = 'INT';
        object.valor = Number(expIzq * expDer);
        return object;
    }else if (entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR"  ){
        object.tipo = 'DOUBLE';
        object.valor = Number(expIzq * expDer);
        return object;       
    }else{
        object.tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return object;
    }

}

function Division(expIzq, expDer, object,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR"){
        object.tipo = 'DOUBLE';
        object.valor = Number(expIzq / expDer);
        if (object.valor = Number("Infinity")){
            object.valor="ERROR";
            console.log("Error Semántico: No existe la división entre 0");
            return object;
        }
        return object;
    }else{
        object.tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return object;
    }

}

function Potencia(expIzq, expDer, object,entorno){
    
    if (entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT"){
        object.tipo = 'INT'; 
        object.valor = expIzq ** expDer; 
        return object;
    }else if(entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" ){
        object.tipo = 'DOUBLE';
        object.valor = expIzq ** expDer;
        return object;
    }else{ 
        object.tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return object;
    }
}

function Modulo(expIzq, expDer, object,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" ){
        object.tipo = 'DOUBLE';
        object.valor = Number(expIzq % expDer);
        return object;
    }else{
        object.tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return object;
    }
}
var DatosDef = [];
var Signos = [];


module.exports = { Suma, Resta, Multiplicación, Division, Potencia, Modulo, DatosDef, Signos}; 