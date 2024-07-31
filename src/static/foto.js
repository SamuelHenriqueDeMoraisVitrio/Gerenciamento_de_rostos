function removeElementRecursively(element) {
    if (!element) {
      return;
    }
  
    // Remove all child elements recursively
    while (element.firstChild) {
      removeElementRecursively(element.firstChild);
    }
  
    // Remove the current element
    element.parentNode.removeChild(element);
}

function removeChildElementsRecursively(element) {
    if (!element) {
      return;
    }
  
    // Remove all child elements recursively
    while (element.firstChild) {
      removeChildElementsRecursively(element.firstChild);
      element.removeChild(element.firstChild);
    }
  }


async function requisita_fotos(){

    let response_list_imgs = await faz_requisicao_autenticada("/api/lista/todas/foto/pessoal");

    const html_div_main = document.getElementById("container-box");

    removeElementRecursively(html_div_main);
    
    if(!response_list_imgs.length){
        return;
    }

    const div_main_main = document.getElementById("container-body");

    const div_main_in_main_main = document.createElement('div');
    div_main_in_main_main.className = 'container-box';
    div_main_in_main_main.id = 'container-box';

    div_main_main.appendChild(div_main_in_main_main);

    let token = sessionStorage.getItem("token");

    for(let i = 0; i < response_list_imgs.length; i++){
        const element = response_list_imgs[i];

        const div = document.createElement('div');
        div.className = 'box-img';

        const img = document.createElement('img');
        img.src = `/api/ver/foto/pessoal?token=${token}&id=${element.id_foto}&query=${element.data}`;
        img.alt = 'Foto de leitura';
        img.className = 'image-preview-list';

        const div_p = document.createElement('div');

        const p_id = document.createElement('p');
        p_id.textContent = `id: ${element.id_foto}`;

        const p_data = document.createElement('p');
        p_data.textContent = `data: ${element.data}`;

        div_p.appendChild(p_id);
        div_p.appendChild(p_data);

        div.appendChild(img);
        div.appendChild(div_p);

        div_main_in_main_main.appendChild(div);
    }
}

let file = null
document.getElementById('file-input').addEventListener('change', function(event) {
    file = event.target.files[0];
    
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.getElementById('selected-image');
            img.src = e.target.result;
            img.style.display = 'block';
        };

        reader.readAsDataURL(file);
    }
});

document.getElementById("button-add-img").addEventListener("click", async () => {
    const imageInput = document.getElementById('file-input');
    if (imageInput.files.length === 0) {
        alert('Por favor, selecione uma imagem primeiro.');
        return;
    }

    let props = {};
    props.method = 'POST';
    props.headers = {};
    props.headers["content-type"] = imageInput.files[0].type;
    props.body = file;

    let response = await faz_requisicao_autenticada_for_text("/api/adicione/foto/pessoal", props);

    if(response){
        alert(response);
        await requisita_fotos();
    }


    let container = document.querySelector(".container-box");
    container.scrollTop = container.scrollHeight;
});


document.getElementById("dell_imgs").addEventListener("click", async () => {
    if(window.confirm("Você deseja excluir todas imagens do seu banco de dados?")){
        let response = await faz_requisicao_autenticada_for_text("/api/deleta/todas/foto/pessoal");

        if(response){
            window.location.href = "/foto"
        }
    }
});

document.getElementById("dell_img_by_id").addEventListener("click", async () => {

    const dom_input_id = document.getElementById("input_id").value;

    if(!dom_input_id || dom_input_id < 0){
        alert("Você não informou um id correto.");
        return;
    }

    if(window.confirm("Tem certeza que deseja excluir essa foto?")){
        let props = {};
        props.headers = {};
        props.headers.id = dom_input_id;
    
        let response = await faz_requisicao_autenticada_for_text("/api/deleta/foto/pessoal", props);
    
        if(response){
            await requisita_fotos();
        }
    }
});
