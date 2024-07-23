

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



document.getElementById('adicionar_trocar_perfil').addEventListener('click', async () => {
    const imageInput = document.getElementById('file-input');
    if (imageInput.files.length === 0) {
        alert('Por favor, selecione uma imagem primeiro.');
        return;
    }

    let token = sessionStorage.getItem("token");

    if(!token){
        window.location.href = "/";
        return;
    }

    let props = {};
    props.method = 'POST';
    props.headers = {};
    props.headers.token = token;
    props.headers["content-type"] = imageInput.files[0].type;
    props.body = file;

    alert(props.headers["content-type"]);

    const response = await fetch("/api/adicione/foto/perfil/pessoal", props);

    if(response.status === 403){
        sessionStorage.removeItem("token");
        window.location.href = "/home";
        return;
    }

    if(!response.ok){
        console.log("Não ta ok!");
        console.error(response.text());
        return;
    }

    console.log(response.text());
    window.location.href = "/";
    return;
});



document.getElementById("deletar_img_perfil").addEventListener("click", async() => {

    const route_api = "/api/deleta/foto/perfil/pessoal";

    const token = sessionStorage.getItem("token");

    if(!token){
        window.location.href = "/";
        return;
    }

    let props = {};
    props.method = 'GET';
    props.headers = {};
    props.headers.token = token;

    const response = await fetch(route_api, props);

    if(response.status == 403){
        sessionStorage.removeItem("token");
        window.location.href = "/";
        return;
    }
    if(!response.ok){

        console.error(await response.text());
        return;
    }

    console.log(await response.text());
    window.location.href = "/home"; 
    return;
});