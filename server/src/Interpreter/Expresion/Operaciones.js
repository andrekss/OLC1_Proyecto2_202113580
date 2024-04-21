// Funciones Aritméticas
function Suma(expIzq, expDer, tipo, valor,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT"){
        tipo = 'INT';
        valor = expIzq + expDer;
        return Number(valor);
    }else if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE"){
        tipo = 'DOUBLE';
        valor = expIzq + expDer;
        return Number(valor);
    }else if(entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "STRING" || entorno.Dato1.tipo == "STRING" && entorno.Dato2.tipo == "CHAR"){
        tipo = 'STRING';
        valor = expIzq + expDer;
        return valor;
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return valor;
    }

}

function Resta(expIzq, expDer, tipo, valor,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT"){
        tipo = 'INT';
        valor = expIzq-expDer;
        return Number(valor);
    }else if (entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "BOOL" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "BOOL" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR" ){
        tipo = 'DOUBLE';
        valor = expIzq-expDer;
        return Number(valor);        
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return valor;
    }

}

function Multiplicación(expIzq, expDer, tipo, valor,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT" ){
        tipo = 'INT';
        valor = expIzq * expDer;
        return Number(valor);
    }else if (entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR"  ){
        tipo = 'DOUBLE';
        valor = expIzq * expDer;
        return Number(valor);        
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return valor;
    }

}

function Division(expIzq, expDer, tipo, valor,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "CHAR" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "CHAR" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "CHAR"){
        tipo = 'DOUBLE';
        valor = expIzq / expDer;
        return Number(valor);
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return valor;
    }

}

function Potencia(expIzq, expDer, tipo, valor,entorno){
    
    if (entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT"){
        tipo = 'INT';
        valor = expIzq ** expDer;
        return Number(valor);
    }else if(entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" ){
        tipo = 'DOUBLE';
        valor = expIzq ** expDer;
        return Number(valor);
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return valor;
    }
}

function Modulo(expIzq, expDer, tipo, valor,entorno){
    if(entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "INT" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "INT" && entorno.Dato2.tipo == "DOUBLE" || entorno.Dato1.tipo == "DOUBLE" && entorno.Dato2.tipo == "INT" ){
        tipo = 'DOUBLE';
        valor = expIzq % expDer;
        return Number(valor);
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return valor;
    }
}


var DatosDef = [];
var Signos = [];	
module.exports = { Suma, Resta, Multiplicación, Division, Potencia, Modulo, DatosDef, Signos };