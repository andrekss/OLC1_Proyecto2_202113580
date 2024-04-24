const Aritmetica = require("./Aritmetica.JS");

class Negativo extends Aritmetica{
    
    constructor(expresion, fila, columna){
        super();
        this.expresion = expresion;
        this.fila = fila;
        this.columna= columna;
    }

    interpretar(entorno){

        if(this.expresion.tipo === "INT"){
            this.tipo = "INT";
            this.valor = -1 * this.expresion.valor;
            return this;
        }

        console.log("Error Semántico: Error en la operacion negativo.")
        return this;
    }

}

module.exports = Negativo;