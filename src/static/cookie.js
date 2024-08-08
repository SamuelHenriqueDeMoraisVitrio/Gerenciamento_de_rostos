
function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}


function addCookie(key, value, path, minutes){
    if(!path){
        path = "/";
    }
    let time = "";
    if(minutes){
        const date = new Date();
        date.setTime(date.getTime() + (minutes * 60 * 1000));
        time = "expires=" + date.toUTCString() + "; ";
    }

    document.cookie = `${key}=${value}; ${time}path=${path}`;
}

function deleteCookie(name) {
    document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
}
