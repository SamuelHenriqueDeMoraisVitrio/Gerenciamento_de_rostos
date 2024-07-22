

document.addEventListener("DOMContentLoaded", async () => {

        const table_down = document.getElementById("body_table_saldo");

        const response = await faz_requisicao_autenticada("/api/lista/usuario/corrente/pessoal");

        if(!response){
            alert("Problema ao encontrar usuario");
            window.location.href = "/";
            return;
        }

        for (let i = 0; i < response.length; i++) {
            const new_element = document.createElement("tr");

            new_element.innerHTML = `
                <td>${response[i].saldo}</td>
                <td>${response[i].valor}</td>
                <td>${response[i].data}</td>
            `;

            table_down.appendChild(new_element);
        }
    }
);

