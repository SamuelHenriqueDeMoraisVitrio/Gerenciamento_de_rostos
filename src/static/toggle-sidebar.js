



document.addEventListener('DOMContentLoaded', () => {
    const sidebar = document.querySelector('.sidebar');
    const content = document.querySelector('.content');
    const root = document.getElementById("button_root_main");
    const toggleButton = document.getElementById('sidebar-toggle');

    toggleButton.addEventListener('click', () => {
        sidebar.classList.toggle('hidden');
        content.classList.toggle('shift');
    });
/*
    // Fechar a sidebar quando o conteúdo é clicado
    content.addEventListener('click', () => {
        if (!sidebar.classList.contains('hidden')) {
            sidebar.classList.add('hidden');
            content.classList.remove('shift');
        }
    });
*/
});




