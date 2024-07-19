


async function concat_html_by_path(url, id){
    try {
        const response = await fetch(url);

        if (!response.ok) {
            throw new Error('Erro ao carregar o arquivo: ' + response.statusText);
        }

        const data = await response.text();
        document.getElementById(id).innerHTML = data;

    } catch (error){
        console.error('Erro ao carregar o HTML:', error);
    }
}


concat_html_by_path("/static/dependencies_main/menu.html", "inner_html_menu_completo")

