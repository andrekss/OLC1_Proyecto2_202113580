document.getElementById('Ejecutar').addEventListener('click', () => {
    const texto = document.getElementById('Entrada').value;
    const Salida = document.getElementById('Salida');

    fetch('http://localhost:3000/Execute', { // peticion post
        method: 'POST',
        headers: {
            'Content-Type': 'text/plain' //texto plano
        },
        body: texto // solicitud
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        }
        throw new Error('Error en la solicitud');
    })
    .then(data => {
        Salida.value = data; // salida en consola
    })
    .catch(error => {
        console.error('Error:', error);
    });
});