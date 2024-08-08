
function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}


function addCookie(key, value, path){
    document.cookie = `${key}=${value}; path=${path}`
}