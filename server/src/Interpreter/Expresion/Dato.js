const Instruccion = require("../instruccion.js");

class Dato extends Instruccion{ // No terminal
    constructor(valor, tipo, Linea, Columna){
        super();
        this.tipo = tipo;
        this.valor = valor;
        this.Linea = Linea;
        this.Columna = Columna;
    }

    EliminarComillas(cadena, eliminar){
        if (typeof cadena== "string"){
         const cadenaArreglada = cadena.replace(new RegExp(eliminar, 'g'), '');
         return cadenaArreglada;
        }else{
            return cadena;
        }
    }

    interpretar(entorno){ // retorno del dato
        switch(this.tipo){ // acomodamos los datos
            case 'INT': 
             this.valor =Number(this.valor);
            //console.log(this)
             return this;
            case 'DOUBLE':
             this.valor =Number(this.valor);
             return this;
            case 'BOOL': 
             this.valor= Boolean(this.valor);
             return this; 
            case 'CHAR': 
             this.valor= this.EliminarComillas(this.valor,"'");
             return this;
            case 'STRING': 
             this.valor= this.EliminarComillas(this.valor,'"');
             return this;
            default: return null;
        }
    }

}

module.exports = Dato;