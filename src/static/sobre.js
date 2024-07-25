

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

        return null;
    }

    if(!response.ok){
        alert(await response.text());
        return null;
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
        create_new_div_modal_in_sub_div.innerHTML = '\
        <div class="modal-content">\
            <span id="closeModalBtn" class="close-btn">&times;</span>\
\
            <form action="/root_user_make" class="form_for_border">\
                <button class="modal-button">User_make</button>\
            </form>\
\
            <form action="/list_users_root" class="form_for_border">\
                <button class="modal-button">List_users</button>\
            </form>\
\
            <form action="/delete_user" class="form_for_border">\
                <button class="modal-button">dell_user</button>\
            </form>\
\
            <form action="/root_make_saldo" class="form_for_border">\
                <button class="modal-button">Saldo_make</button>\
            </form>\
\
            <form action="/root_saldo_lote" class="form_for_border">\
                <button class="modal-button">Saldo_lote</button>\
            </form>\
\
        </div>';
        
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
