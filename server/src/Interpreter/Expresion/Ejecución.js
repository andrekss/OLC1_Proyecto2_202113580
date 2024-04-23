const Aritmetica = require("./Aritmetica");

function Ejecutar(DatosDef, Signos){

    while(true) {
     let Jerarquía = true; 
       for (let i = 0; i < Signos.length; i++) {
        try{
         if(Signos[i]=="*" || Signos[i]=="/" ||Signos[i]=="%"){
            Jerarquía = false;
            
            let Entorno = {
                Dato1: DatosDef[i], 
                Dato2: DatosDef[i+1],       
               };
               let Dato = new Aritmetica(Entorno.Dato1.valor,Signos[i],Entorno.Dato2.valor); 
            DatosDef.splice(i,1)
            Signos.splice(i,1)
            DatosDef[i] = Dato.interpretar(Entorno);
            break;
         }
        }catch{
            break;
        }   
       }
       if (Jerarquía){
        break; //fin de la jerarquía
       }
    }

    // ultima jerarquía
    while(true){
        try{
         let Dato = new Aritmetica(DatosDef[0].valor,Signos[0],DatosDef[1].valor);
         let Entorno = {
             Dato1: DatosDef[0], 
             Dato2: DatosDef[1],       
            };
         DatosDef.splice(0,1)
         Signos.splice(0,1)
         DatosDef[0] = Dato.interpretar(Entorno);
         if (Signos.length ==0){
             break;
         }
        }catch{
            break;
        }
    }

    let resultado = DatosDef[0];
    return resultado;
}


module.exports = {Ejecutar}; 
