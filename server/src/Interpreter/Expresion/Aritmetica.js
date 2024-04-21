const { Suma, Resta, Multiplicación, Division, Potencia, Modulo } = require('./Operaciones');
const Instruccion = require("../instruccion.js");

class Aritmetica extends Instruccion{  // Terminal
    constructor(expIzq, operador, expDer){
        super();
        this.expIzq = expIzq;
        this.operador = operador;
        this.expDer = expDer;
        this.tipo = 'ERROR'; // tipo de la respuesta
        this.valor = 'null'; //respuesta
    }

    interpretar(entorno){ // retornamos el resultado

        if(this.operador == "+"){
            return Suma(this.expIzq,this.expDer,this.tipo,this,entorno);  
        }else if(this.operador == "-"){
            return Resta(this.expIzq,this.expDer,this.tipo,this,entorno);  
        }else if(this.operador == "*"){
            return Multiplicación(this.expIzq,this.expDer,this.tipo,this,entorno);  
        }else if(this.operador=="/"){
            return Division(this.expIzq,this.expDer,this.tipo,this,entorno);  
        }else if (this.operador=="Pot"){
            return Potencia(this.expIzq,this.expDer,this.tipo,this,entorno);  
        }else if (this.operador=="%"){
            return Modulo(this.expIzq,this.expDer,this.tipo,this,entorno);  
        }


    }

}

module.exports = Aritmetica;
