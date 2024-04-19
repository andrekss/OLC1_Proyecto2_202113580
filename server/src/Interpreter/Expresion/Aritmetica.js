const Instruccion = require("../instruccion.js");

class Aritmetica extends Instruccion{  // Terminal
    constructor(expIzq, operador, expDer){
        super();
        this.expIzq = expIzq;
        this.operador = operador;
        this.expDer = expDer;
        this.tipo = 'ERROR';
        this.valor = 'null';
    }

    interpretar(entorno){

        let valorIzq = this.expIzq.interpretar(null);
        let valorDer = this.expDer.interpretar(null);

        if(this.operador == "+"){
            return Suma(this.expIzq,this.expDer,this.tipo,this.valor,valorIzq,valorDer);  
        }else if(this.operador == "-"){
            return Resta(this.expIzq,this.expDer,this.tipo,this.valor,valorIzq,valorDer);  
        }else if(this.operador == "*"){
            return Multiplicación(this.expIzq,this.expDer,this.tipo,this.valor,valorIzq,valorDer);  
        }else if(this.operador="/"){
            return Division(this.expIzq,this.expDer,this.tipo,this.valor,valorIzq,valorDer);  
        }else if (this.operador=="Potencia"){
            return Potencia(this.expIzq,this.expDer,this.tipo,this.valor,valorIzq,valorDer);  
        }else if (this.operador=="%"){
            return Modulo(this.expIzq,this.expDer,this.tipo,this.valor,valorIzq,valorDer);  
        }


    }

}

module.exports = Aritmetica;
