const Instruccion = require("../instruccion.js");

class Vectores extends Instruccion {
    constructor(tipo,valor){
        super();
        this.tipo = tipo;
        this.valor= valor;
    }

    interpretar(entorno){ //retornos

    }
}

module.exports = Vectores;