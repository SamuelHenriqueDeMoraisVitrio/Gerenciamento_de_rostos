

let file = null
document.getElementById('file-input').addEventListener('change', function(event) {
    file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.getElementById('selected-image');
            img.src = e.target.result;
            img.style.display = 'block';
        };
        reader.readAsDataURL(file);
    }
});

 async function nome_do_button(){

    if(!file){
        alert("Nenhuma imagem foi selecionada.");
        return;
    }

    let new_format = new FormData();

    new_format.append('image', file);

    let token = sessionStorage.getItem("token");

    if(!token){
        window.location.href = "/";
        return;
    }

    let props = {};
    props.method = 'POST';
    props.headers = {};
    props.headers.token = token;
    props.body = new_format;

    let response = await fetch("/api/adicione/foto/perfil/pessoal", props);
    
    if(response.status === 403){
        sessionStorage.removeItem("token");
        
        window.location.href = "/";

        return;
    }
    
    if(!response.ok){
        console.error(response.text());
        return;
    }

    console.log(response.text())
    return;
}

