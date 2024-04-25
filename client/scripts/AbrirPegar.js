const ArchivoIn = document.getElementById('ArchivoIn');  // archivo
const AbrirArchivo = document.getElementById('AbrirArchivo'); // boton abrir archivo
const entradaTextarea = document.getElementById('Entrada'); // Texto entrada

AbrirArchivo.addEventListener('click', () => {
    ArchivoIn.click();
});

ArchivoIn.addEventListener('change', (event) => {
    const ArchivoSeleccionado = event.target.files[0];
    if (ArchivoSeleccionado) {
        const reader = new FileReader();
        
        reader.onload = function(e) {
            const Contenido = e.target.result; // el contenido en string
            entradaTextarea.value = Contenido;
        };
        reader.readAsText(ArchivoSeleccionado);
    }
});