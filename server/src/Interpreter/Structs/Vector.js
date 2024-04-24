const Instruccion = require("../instruccion.js");

class Vectores extends Instruccion {
    constructor(tipo,valor){
        super();
        this.tipo = tipo;
        this.valor= valor;
    }

    interpretar(entorno){ //retornos
        return this.valor
    }
}

module.exports = Vectores;