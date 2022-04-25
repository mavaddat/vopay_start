import { annotate } from "https://unpkg.com/rough-notation?module";
const KEY_SPAN = document.querySelector("#key");
const SECRET_SPAN = document.querySelector("#secret");
const DATE_SPAN = document.querySelector("#date");

async function digestMessage(message) {
    const msgUint8 = new TextEncoder().encode(message); // encode as (utf-8) Uint8Array
    const hashBuffer = await crypto.subtle.digest("SHA-1", msgUint8); // hash the message
    const hashArray = Array.from(new Uint8Array(hashBuffer)); // convert buffer to byte array
    const hashHex = hashArray
        .map((b) => b.toString(16).padStart(2, "0"))
        .join(""); // convert bytes to hex string
    return hashHex;
}

const KEY_STR = KEY_SPAN.innerHTML;
const SECRET_STR = SECRET_SPAN.innerHTML;
const DATE_STR = new Date().toISOString().slice(0, 10);

DATE_SPAN.innerHTML = DATE_STR;

const preSig = KEY_STR + SECRET_STR + DATE_STR;
const sig = document.querySelector("#signature");

digestMessage(preSig).then((digestHex) => (sig.innerHTML = digestHex));

const KEY_ANNO = annotate(KEY_SPAN, {
    type: "underline",
    color: "#ab228b",
    padding: 5
});
const SECRET_ANNO = annotate(SECRET_SPAN, {
    type: "circle",
    color: "red",
    padding: 5
});
const DATE_ANNO = annotate(DATE_SPAN, {
    type: "box",
    color: "orange",
    padding: 7
});

KEY_ANNO.show();
SECRET_ANNO.show();
DATE_ANNO.show();
function updateGrid() {
    const keyWidth = KEY_SPAN.getBoundingClientRect().width;
    const secretWidth = SECRET_SPAN.getBoundingClientRect().width;
    const dateWidth = DATE_SPAN.getBoundingClientRect().width;
    const widths = {
        key: keyWidth,
        secret: secretWidth,
        date: dateWidth
    };
    const classes = ["above", "below"];
    const styles = ["width", "maxWidth"];
    for(let i in classes){
        let j = 0;
        let spans = document.querySelectorAll(`.${classes[i]} > span`); //3 spans
        for(let id in widths){
            for(let k in styles){
                spans[j].style[styles[k]] = widths[id] + "px";
            }
            j++;
        }
    }
}
// wait for the spans to be rendered then call updateGrid
window.addEventListener("load", updateGrid);
// update the grid when the window is resized
window.addEventListener("resize", updateGrid);
