

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
        window.location.href = "/index";

        sessionStorage.removeItem("token")

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

    window.location.href = "/";

    sessionStorage.removeItem("token")
}

