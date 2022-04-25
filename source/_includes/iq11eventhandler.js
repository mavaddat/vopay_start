/* eslint-disable strict */

/* Assumptions:
    1. You have jQuery loaded
    2. You have a user.php endpoint to handle POST
*/

const username = "A01234567";
window.addEventListener('message', function (event) {
    if (event.origin === 'https://embed.vopay.com' && event.data.Token) {
        // handle iQ11 token
        const iq11token = event.data.Token;
        // do something with iQ11 token
        $.ajax({ // jquery ajax call
                method: "POST",
                url: "user.php",
                data: {
                    user: username,
                    iq11token: iq11token
                }
            })
            .done(function (msg) {
                console.debug("iQ11 Saved: " + msg);
            });
    }
    if (event.data.url) {
        // redirect to url
        window.location.href = event.data.url;
    }
});
