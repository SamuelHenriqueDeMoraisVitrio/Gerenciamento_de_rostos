


async function dell_user_root(){

    const email = document.getElementById("email").value;

    let props = {};
    props.headers = {};
    props.headers.email = email;

    const response = await faz_requisicao_autenticada_for_text("/api/deleta/usuario", props);

    if(response){
        alert(`Response: ${response}`);
    }
}




