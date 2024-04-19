// Funciones Aritméticas

function Suma(expIzq, expDer, tipo, valor, valorIzq, valorDer){
    if(expIzq.tipo == "INT" && expDer.tipo == "INT" || expIzq.tipo == "INT" && expDer.tipo == "BOOL" || expIzq.tipo == "BOOL" && expDer.tipo == "INT" || expIzq.tipo == "INT" && expDer.tipo == "CHAR" || expIzq.tipo == "CHAR" && expDer.tipo == "INT"){
        tipo = 'INT';
        valor = valorIzq + valorDer;
        return Number(valor);
    }else if(expIzq.tipo == "INT" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "INT" || expIzq.tipo == "DOUBLE" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "BOOL" || expIzq.tipo == "BOOL" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "CHAR" || expIzq.tipo == "CHAR" && expDer.tipo == "DOUBLE"){
        tipo = 'DOUBLE';
        valor = valorIzq + valorDer;
        return Number(valor);
    }else if(expIzq.tipo == "CHAR" && expDer.tipo == "CHAR" || expIzq.tipo == "STRING" && expDer.tipo == "STRING" || expIzq.tipo == "INT" && expDer.tipo == "STRING" || expIzq.tipo == "STRING" && expDer.tipo == "INT" || expIzq.tipo == "DOUBLE" && expDer.tipo == "STRING" || expIzq.tipo == "STRING" && expDer.tipo == "DOUBLE" || expIzq.tipo == "BOOL" && expDer.tipo == "STRING" || expIzq.tipo == "STRING" && expDer.tipo == "BOOL" || expIzq.tipo == "CHAR" && expDer.tipo == "STRING" || expIzq.tipo == "STRING" && expDer.tipo == "CHAR"){
        tipo = 'STRING';
        valor = valorIzq + valorDer;
        return valor;
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return this.valor;
    }

}

function Resta(expIzq, expDer, tipo, valor, valorIzq, valorDer){
    if(expIzq.tipo == "INT" && expDer.tipo == "INT" || expIzq.tipo == "INT" && expDer.tipo == "BOOL" || expIzq.tipo == "BOOL" && expDer.tipo == "INT" || expIzq.tipo == "INT" && expDer.tipo == "CHAR" || expIzq.tipo == "CHAR" && expDer.tipo == "INT"){
        tipo = 'INT';
        valor = valorIzq - valorDer;
        return Number(valor);
    }else if (expIzq.tipo == "DOUBLE" && expDer.tipo == "DOUBLE" || expIzq.tipo == "INT" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "INT" || expIzq.tipo == "BOOL" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "BOOL" || expIzq.tipo == "CHAR" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "CHAR" ){
        tipo = 'DOUBLE';
        valor = valorIzq - valorDer;
        return Number(valor);        
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return this.valor;
    }

}

function Multiplicación(expIzq, expDer, tipo, valor, valorIzq, valorDer){
    if(expIzq.tipo == "INT" && expDer.tipo == "INT" || expIzq.tipo == "INT" && expDer.tipo == "CHAR" || expIzq.tipo == "CHAR" && expDer.tipo == "INT" ){
        tipo = 'INT';
        valor = valorIzq * valorDer;
        return Number(valor);
    }else if (expIzq.tipo == "DOUBLE" && expDer.tipo == "DOUBLE" || expIzq.tipo == "INT" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "INT" || expIzq.tipo == "CHAR" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "CHAR"  ){
        tipo = 'DOUBLE';
        valor = valorIzq * valorDer;
        return Number(valor);        
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return this.valor;
    }

}

function Division(expIzq, expDer, tipo, valor, valorIzq, valorDer){
    if(expIzq.tipo == "INT" && expDer.tipo == "INT" || expIzq.tipo == "INT" && expDer.tipo == "CHAR" || expIzq.tipo == "CHAR" && expDer.tipo == "INT" || expIzq.tipo == "DOUBLE" && expDer.tipo == "DOUBLE" || expIzq.tipo == "INT" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "INT" || expIzq.tipo == "CHAR" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "CHAR"){
        tipo = 'DOUBLE';
        valor = valorIzq / valorDer;
        return Number(valor);
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return this.valor;
    }

}

function Potencia(expIzq, expDer, tipo, valor, valorIzq, valorDer){
    if (expIzq.tipo == "INT" && expDer.tipo == "INT"){
        tipo = 'INT';
        valor = valorIzq ** valorDer;
        return Number(valor);
    }else if(expIzq.tipo == "DOUBLE" && expDer.tipo == "DOUBLE" || expIzq.tipo == "INT" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "INT" ){
        tipo = 'DOUBLE';
        valor = valorIzq ** valorDer;
        return Number(valor);
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return this.valor;
    }
}

function Modulo(expIzq, expDer, tipo, valor, valorIzq, valorDer){
    if(expIzq.tipo == "INT" && expDer.tipo == "INT" || expIzq.tipo == "DOUBLE" && expDer.tipo == "DOUBLE" || expIzq.tipo == "INT" && expDer.tipo == "DOUBLE" || expIzq.tipo == "DOUBLE" && expDer.tipo == "INT" ){
        tipo = 'DOUBLE';
        valor = valorIzq % valorDer;
        return Number(valor);
    }else{
        tipo = "ERROR";
        console.log("Error Semántico: Error de tipo de dato");
        return this.valor;
    }
}