

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

    console.log("token: ", token);

    let props = {};
    props.headers = {};
    props.headers.token = token;

    if(dados_do_user.root){
        
        let menu = document.getElementsByClassName('sidebar-menu')[0];
        let listItem = document.createElement('li');
        let button = document.createElement('button');
        button.setAttribute('id', "button_root_main");
        button.innerHTML = '<i class="fas fa-terminal"></i> Modo Root';
        
        listItem.appendChild(button);
    
        menu.appendChild(listItem);

        let div_modal = document.getElementById("open_modal");
        const sidebar = document.querySelector('.sidebar');
        const content = document.querySelector('.content');
        let button_root_main = document.getElementById("button_root_main");
        
        let create_new_div_modal_in_sub_div = document.createElement("div");
        create_new_div_modal_in_sub_div.setAttribute("id", "modal");
        create_new_div_modal_in_sub_div.setAttribute("class", "modal");
        create_new_div_modal_in_sub_div.innerHTML = '<div class="modal-content"><span id="closeModalBtn" class="close-btn">&times;</span><button class="modal-button">Botão 1</button><button class="modal-button">Botão 2</button><button class="modal-button">Botão 3</button><button class="modal-button">Botão 4</button><button class="modal-button">Botão 5</button></div>';
        
        div_modal.appendChild(create_new_div_modal_in_sub_div);
        
        button_root_main.addEventListener("click", function(){
            document.getElementById('modal').style.display = 'flex';
            sidebar.classList.toggle('hidden');
            content.classList.toggle('shift');
        });

        document.getElementById('closeModalBtn').addEventListener('click', function() {
            document.getElementById('modal').style.display = 'none';
            sidebar.classList.toggle('hidden');
            content.classList.toggle('shift');
        });

        window.addEventListener('click', function(event) {
            if (event.target === document.getElementById('modal')) {
                document.getElementById('modal').style.display = 'none';
                sidebar.classList.toggle('hidden');
                content.classList.toggle('shift');
            }
        });
    }

    if(dados_do_user.perfil_bool){
        const route_preview_img_perfil = "/api/ver/foto/perfil/pessoal?token=" + token;
        let button_troca = document.getElementById("adicionar_trocar_perfil");
        let img_element = document.getElementById("profile-picture");
        
        if(button_troca){
            button_troca.innerHTML = "Trocar foto de perfil";
        }

        img_element.src = route_preview_img_perfil;
    }else{
        let button_delete_img_perfil = document.getElementById("deletar_img_perfil");
    
        if(button_delete_img_perfil){
            button_delete_img_perfil.style = "display: none;"
        }
    }

/*
console.log("Tem imagem de perfil: ", dados_do_user.perfil_bool);
if(dados_do_user.perfil_bool){
    let button_troca = document.getElementById("adicionar_trocar_perfil");
    
    if(button_troca){
        button_troca.innerHTML = "Trocar foto de perfil";
    }
    
    let request_img_profile = await fetch("/api/ver/foto/perfil/pessoal", props);
    
    if(request_img_profile.status === 403){
        sessionStorage.removeItem("token");
        
        window.location.href = "/";
        
        return;
    }
        
    if(!request_img_profile.ok){
        console.error(request_img_profile.text());
        return;
    }
    
    let blob = await request_img_profile.blob();
    
    const reader = new FileReader();
    
    reader.onload = function(event){
        const img_in_html = document.getElementById("profile-picture");
        img_in_html.src = event.target.result;
    }
    reader.readAsDataURL(blob);
    
    console.log("Escreveu: ", img_in_html.src);
    
}else{
    let button_delete_img_perfil = document.getElementById("deletar_img_perfil");

if(button_delete_img_perfil){
    button_delete_img_perfil.style = "display: none;"
}
}
*/

    let nome_preview_main = document.getElementById("nome_perfil");
    let email_preview_main = document.getElementById("email_perfil_show");
    let class_preview_main = document.getElementById("class_perfil_show");
    let saldo_do_cliente_show = document.getElementById("saldo_perfil_show");

    nome_preview_main.innerHTML = dados_do_user.nome;
    email_preview_main.innerHTML = "E-mail: " + dados_do_user.email;
    class_preview_main.innerHTML = "Class: " + dados_do_user.class;
    saldo_do_cliente_show.innerHTML = "Saldo: " + dados_do_user.saldo;
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


    // Obtém a URL atual
    const currentUrl = window.location.href;

    // Cria um objeto URL com a URL atual
    const url = new URL(currentUrl);
    
    // Cria um objeto URLSearchParams com os parâmetros da query
    const params = new URLSearchParams(url.search);
    
    // Pega um parâmetro específico (por exemplo, 'id')
    const id = params.get('id');
    
    // Exibe o valor do parâmetro no console
    console.log(id);
