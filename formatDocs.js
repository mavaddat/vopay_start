/* eslint-disable strict */
document.querySelector("body > div.page-wrapper").style.backgroundColor = "white";
document.querySelectorAll('code').forEach((el) => {
    el.style.fontFamily = "'Consolas', monospace";
    el.style.fontSize = "10.5pt";
});

(new Set(document.querySelectorAll('p'), document.querySelectorAll('table'), document.querySelectorAll('li'), document.querySelectorAll('aside'))).forEach((el) => {
    el.style.fontFamily = "'Ubuntu', sans-serif";
    el.style.fontSize = "10.5pt";
});
//collect all the h1-h6 tags into a set
const headers = new Set(document.querySelectorAll('h1, h2, h3, h4, h5, h6'));

headers.forEach((el) => {
    for (let attr of ["marginTop", "marginBottom", "borderTop", "borderBottom", "paddingTop", "paddingBottom", "backgroundImage","backgroundColor"]) {
        el.style[attr] = "unset";
    }
    el.style.fontFamily = "'Ubuntu', sans-serif";
});
// Get HTML head element
var head = document.getElementsByTagName('HEAD')[0];

// Create new link Element
var linkgapi = document.createElement('link');
var linkgstat = document.createElement('link');
var linkgcss = document.createElement('link');

// set the attributes for link element
linkgapi.rel = 'preconnect';

linkgapi.href = 'https://fonts.googleapis.com';
linkgstat.href = 'https://fonts.gstatic.com';
linkgcss.href = "https://fonts.googleapis.com/css2?family=Inconsolata&family=Ubuntu:wght@300&display=swap";
linkgstat.setAttribute("crossorigin", 'anonymous');
linkgcss.rel = "stylesheet";

// Append link element to HTML head
head.appendChild(linkgapi);
head.appendChild(linkgstat);
head.appendChild(linkgcss);
