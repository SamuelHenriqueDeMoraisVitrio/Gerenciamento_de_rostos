


async function commit_user_add(){

    const email = document.getElementById("email-add").value;
    let saldo = document.getElementById("add-balance").value;
    
    if((!email)){
        alert("Preencha o formulário corretamente.");
        return;
    }

    if(!saldo || saldo < 0){
        saldo = 0;
    }

    let props = {};
    props.headers = {};
    props.headers.email = email;
    props.headers.valor = saldo;

    const response = await faz_requisicao_autenticada("http://localhost:3000/api/incrementa/saldo/usuario", props);

    console.log(response);

}

async function commit_user_tira(){

    const email = document.getElementById("email-tira").value;
    let saldo = document.getElementById("tira-balance").value;

    if((!email)){
        alert("Preencha o formulário corretamente.");
        return;
    }

    if(!saldo || saldo < 0 || typeof saldo === "number"){
        saldo = 0;
    }

    let props = {};
    props.headers = {};
    props.headers.email = email;
    props.headers.valor = saldo;


    const response = await faz_requisicao_autenticada("http://localhost:3000/api/decrementa/saldo/usuario", props);

    console.log(response);

}

