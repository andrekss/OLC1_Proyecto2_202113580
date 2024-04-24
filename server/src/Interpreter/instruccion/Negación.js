const Condicion = require("./Condiciones");


class Negacion extends Condicion {
    constructor(expresion,fila,columna){
        super();
        this.expresion = expresion;
        this.fila = fila;
        this.columna= columna;
    }

    interpretar(entorno){
        if(this.expresion==false){
            return true;
        }else{
            return false
        }
    }
}


module.exports = Negacion;