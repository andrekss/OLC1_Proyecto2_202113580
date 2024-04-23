const Instruccion = require("../instruccion.js");

class Estructuras extends Instruccion {
    constructor(){
        super();
        this.Variables = {};
        this.Vectores= [];
    }

    pushVariable(ID, object, tipo) {
        //console.log(this.Variables);
        if (tipo == "std::string".toLowerCase()){
            tipo = "string";
        }
        try {
         if (this.Variables.hasOwnProperty(ID)) {
             //throw new Error(`Error semántico: La variable"${ID}" ya existe.`);
             console.log("Error semántico: La variable "+ID+" ya existe.");
         } 
         
         else if(this.Variables[ID].tipo.toLowerCase() != tipo.toLowerCase()){
             console.log("Error semántico: El dato asignado no coincide con el tipo de dato de la variable.");
         }
         else {
             this.Variables[ID] = object;
         }
        } catch{
            this.Variables[ID] = object;
        }
    } 

    Incremento_Decremento(Id,Indicar){
       
        if(Indicar=="+" && this.Variables[Id].tipo.toUpperCase() =="INT"){
            this.Variables[Id].valor+=1;
        }else if($2=="-" && this.Variables[Id].tipo.toUpperCase() =="INT"){
            this.Variables[Id].valor-=1;
        } else {
            console.log("Error semántico: la variable no es de tipo int")
        }
    }


    interpretar(entorno){ // Retorno objeto
        return this.Variables[entorno.Id];
    }
}

module.exports = Estructuras;