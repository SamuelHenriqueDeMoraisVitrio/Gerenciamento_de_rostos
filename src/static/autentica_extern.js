 

window.onload = function (){

    let token1 = getCookie("token");
    let token = sessionStorage.getItem("token");

    console.log(token1);

    if(token){
        //window.location.href = "/home"
    }
}

async function efetua_log(){
    let email = document.getElementById("email").value;
    let senha = document.getElementById("senha").value;

    if(!email || email == ""){
        alert("E-mail não informado.");
        return;
    }

    if(!senha || senha == ""){
        alert("senha não informado.");
        return;
    }

    let resultado = await fetch("/api/adicione/token", {headers: {
        email: email,
        senha: senha
    }});

    if(!resultado.ok){
        let response = await resultado.text();
        alert(response);
        return;
    }

    let json = await resultado.json();

    sessionStorage.setItem("token", json.token_criado);
    addCookie("token", json.token_criado, null, 31);
    //window.location.href = "/home";
}