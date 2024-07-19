

async function faz_requisicao_autenticada(rota, props){

    let token = sessionStorage.getItem("token");
    if(!token){
        window.location.href = "/index";
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
        sessionStorage.removeItem("token")
        
        window.location.href = "/index";

        return;
    }

    if(!response.ok){
        alert(await response.text());
        return;
    }

    let json = await response.json()

    return json;
}

window.onload = async function () {

    let dados_do_user = await faz_requisicao_autenticada("/api/usuario")

    console.log(dados_do_user)

    if(dados_do_user.root){
        
        let menu = document.getElementsByClassName('sidebar-menu')[0];
        let listItem = document.createElement('li');
        let button = document.createElement('button');
        button.setAttribute('onclick', "navigateTo('modo-root')");
        button.innerHTML = '<i class="fas fa-terminal"></i> Modo Root';
        
        listItem.appendChild(button);
    
        menu.appendChild(listItem);
    }

    if(dados_do_user.perfil_bool){
        
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

    let props = {}
    props.headers = {}
    props.headers.token = token

    await fetch("/api/deleta/token", props)
    
    sessionStorage.removeItem("token")
    
    window.location.href = "/";
}

