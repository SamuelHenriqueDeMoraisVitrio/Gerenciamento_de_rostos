

async function html_required(){

    let html = await fetch("/li");

    let html_code = await html.text();

    console.log(html_code);

    return html_code;
}


document.getElementById("list_html_code").addEventListener("DOMContentLoaded", async function(){
    
    let html_code = await html_required();

    document.getElementById("list_html_code").innerHTML = html_code;


});