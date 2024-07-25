

function filtragem(){

    const email = document.getElementById("email").value;
    const name = document.getElementById("nome").value;
    let saldo_min = document.getElementById("balance-min").value;
    let saldo_max = document.getElementById("balance-max").value;
    let frec_min = document.getElementById("frequenc-min").value;
    let frec_max = document.getElementById("frequenc-max").value;
    let img_min = document.getElementById("img-min").value;
    let img_max = document.getElementById("img-max").value;
    let root = document.getElementById("root").checked;

    const object_results = {"email": email,
        "nome": name,
        "saldo_min": saldo_min,
        "saldo_max": saldo_max,
        "frequencia_min": frec_min,
        "frequencia_max": frec_max,
        "img_min": img_min,
        "img_max": img_max,
        "root": root
    };

    let props = {};
    props.method = "GET";
    props.headers = {};

    for(let key in object_results){

        if(key == "root"){
            if(object_results[key]){
                props.headers[`${key}`] = "true";
            }else{
                props.headers[`${key}`] = "false";
            }
            continue;
        }

        if(object_results[key] === null || object_results[key] == ""){
            continue;
        }

        props.headers[`${key}`] = object_results[key];
    }

    return props;

}

async function refresh_list(){

    const props = filtragem();

    const table_down = document.getElementById("body_table_saldo");

    const response = await faz_requisicao_autenticada("/api/lista/usuario", props);

    if(!response){
        alert("Problema ao encontrar usuario");
        window.location.href = "/";
        return;
    }
    
    table_down.innerHTML = "";
    
    for (let i = 0; i < response.length; i++) {
        const new_element = document.createElement("tr");

        new_element.innerHTML = `
            <td>${response[i].email}</td>
            <td>${response[i].nome}</td>
            <td>${response[i].saldo}</td>
            <td>${response[i].frequencia}</td>
            <td>${response[i].imagens}</td>
            <td>${response[i].root}</td>
        `;

        table_down.appendChild(new_element);
    }
}

document.addEventListener("DOMContentLoaded", async () => {

        await refresh_list();
    }
);


