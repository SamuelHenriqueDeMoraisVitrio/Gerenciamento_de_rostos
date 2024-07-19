

async function faz_requisicao_autenticada(rota, props){

    let token = sessionStorage.getItem("token");
    if(!token){
        window.location.href = "/";
        return;
    }

    if(!props){
        props = {};
    }

    if(!props.headers){
        props.headers = {};
    }

    props.headers.token = token;

    let response = await fetch(rota, props);

    if(response.status === 403){
        sessionStorage.removeItem("token");
        
        window.location.href = "/";

        return;
    }

    if(!response.ok){
        alert(await response.text());
        return;
    }

    let json = await response.json();

    return json;
}

window.onload = async function () {

    let dados_do_user = await faz_requisicao_autenticada("/api/usuario");
    
    let token = sessionStorage.getItem("token");

    if(!token){
        window.location.href = "/";
        return;
    }

    let props = {};
    props.headers = {};
    props.headers.token = token;

    if(dados_do_user.root){
        
        let menu = document.getElementsByClassName('sidebar-menu')[0];
        let listItem = document.createElement('li');
        let button = document.createElement('button');
        button.setAttribute('onclick', "");
        button.innerHTML = '<i class="fas fa-terminal"></i> Modo Root';
        
        listItem.appendChild(button);
    
        menu.appendChild(listItem);
    }

    if(dados_do_user.perfil_bool){
        let img_in_html = document.getElementById("profile-picture");

        let request_img_profile = await fetch("/api/ver/foto/perfil/pessoal", props);

        if(!request_img_profile.ok){
            console.error("Erro ao abrir imagem");
            return;
        }

        let file = await request_img_profile.blob();

        let url_file = URL.createObjectURL(file);

        img_in_html.src = url_file;
        
    }

    let nome_preview_main = document.getElementById("nome_perfil");
    let email_preview_main = document.getElementById("email_perfil_show");
    let class_preview_main = document.getElementById("class_perfil_show");

    nome_preview_main.innerHTML = dados_do_user.nome;
    email_preview_main.innerHTML = "E-mail: " + dados_do_user.email;
    class_preview_main.innerHTML = "Class: " + dados_do_user.class;
}


async function logout(){

    let token = sessionStorage.getItem("token");
    if(!token){
        window.location.href = "/";
        return;
    }

    let props = {};
    props.headers = {};
    props.headers.token = token;

    await fetch("/api/deleta/token", props);
    
    sessionStorage.removeItem("token");
    
    window.location.href = "/";
}

