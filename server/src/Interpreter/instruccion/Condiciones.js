const Instruccion = require("../instruccion.js");
const {Operar} = require("./Funcs.js")

class Condicion extends Instruccion {
    constructor(expIzq, operador, expDer,Linea,Columna){ // todos tienen que ser valores netos y no objetos
        super();
        this.expIzq = expIzq;
        this.operador = operador;
        this.expDer = expDer;
        this.Linea = Linea;
        this.Columna = Columna;
    }

    interpretar(entorno){
        return Operar(this.expIzq,this.operador,this.expDer);
    }
}

module.exports = Condicion;