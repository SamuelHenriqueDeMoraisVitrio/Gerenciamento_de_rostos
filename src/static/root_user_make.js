
document.addEventListener('DOMContentLoaded', () => {
    const classInput = document.getElementById('class-input');
    const addClassButton = document.getElementById('add-class');
    const classList = document.getElementById('class-list');

    addClassButton.addEventListener('click', () => {
        const newClass = classInput.value.trim();
        if (newClass) {
            addClass(newClass);
            classInput.value = '';
        }
    });

    classList.addEventListener('click', (event) => {
        if (event.target.classList.contains('class-item')) {
            removeClass(event.target);
        }
    });

    function addClass(className) {
        const classItem = document.createElement('div');
        classItem.className = 'class-item';
        classItem.textContent = className;
        classList.appendChild(classItem);
    }

    function removeClass(classItem) {
        classList.removeChild(classItem);
    }
});


async function commit_user(){

    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const senha = document.getElementById("password").value;
    let root = document.getElementById("root").checked;
    let saldo = document.getElementById("initial-balance").value;
    let classUser = document.getElementById("class-list").children;

    if(!name || !email || !senha){
        alert("Preencha o formulário corretamente.");
        return;
    }

    let array_classes = [];
    let text_class = "";
    
    if(classUser.length > 0){
        for(let i = 0; i < classUser.length; i++){
            array_classes.push(classUser[i].textContent);
            text_class = `${text_class}/${array_classes[i]}`;
        }
    }

    if(classUser.length == 0){
        array_classes = ["/"];
        text_class = "/";
    }
    if(!saldo || saldo < 0){
        saldo = 0;
    }

    let props = {};
    props.headers = {};
    props.headers.email = email;
    props.headers.senha = senha;
    props.headers.nome = name;
    props.headers.root = root;
    props.headers.saldo = saldo;
    props.headers.class = text_class;


    const response = await faz_requisicao_autenticada_for_text("/api/adicione/usuario", props);

    console.log(response);

}