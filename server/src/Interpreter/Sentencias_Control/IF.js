const  Instruccion = require("../Instruccion");


class If extends Instruccion{
    constructor(condicion, Codigo, fila, columna){
        super();
        this.condicion = condicion;
        this.Codigo = Codigo;
        this.fila=fila;
        this.columna=columna;
    }

    interpretar(entorno){

        if(this.condicion != true || this.condicion !=false){
            console.log("Error Semántico: la condicion del if debe ser tipo boolean");
            return this;
        }

        if(this.condicion === true){
            for (let i = 0; i < this.Codigo.length; i++) {
                let instruccion = this.Codigo[i];
                instruccion.interpretar();
                if(instruccion.toLowerCase() == "break"){
                    break;
                }

                if(instruccion.toLowerCase() == "return"){
                    break;
                }
            }
        }
        else{
            // Ejecución del else If o else
        }
        // Guardar entorno
        return this;
    }

}

module.exports = If