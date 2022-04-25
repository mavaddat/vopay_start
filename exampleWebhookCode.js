/* eslint-disable strict */
const request = require('postman-request'); //`request` module used inside Postman Runtime
const chai = require('chai'); // test driven dev assertion library
const cryptojs = require('crypto-js'); // library for encrypting and decrypting strings

// make sure to have SHAREDSECRET in the system environment variables


function test(msg, func) {
    console.log(msg);
    func();
}

const getWebhookToken = {
    method: 'POST',
    url: 'https://webhook.site/token', // Provisions a webhook receiver
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }
};

const postWebhookUrl = {
    method: 'POST',
    url: '', // Will store the provisioned webhook URL
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }
};

let uuid; // will store UUID of the webhook.site receiver

request(getWebhookToken, (err, res) => {
    // Get a webhook receiver from webhook.site
    if (err) {
        console.error(err);
    } else {
        const buffer = Buffer.from(res.stream, 'utf8');
        const body = buffer.toString();
        const json = JSON.parse(body);
        uuid = json.uuid;
        postWebhookUrl.url = `https://webhook.site/${uuid}`;
    }
})

// Declare the webhook receiver at `account/webhook-url`

/**
 * Code omitted for brevity
 */

// Call `account/webhook-url/test` to send test data to the webhook receiver

/**
 * Code omitted for brevity
 */

// Check if the test data was received by the webhook receiver

const getLatestContent = {
    method: 'GET',
    url: `https://webhook.site/token/${uuid}/request/latest`
};
request(getLatestContent, (err, res) => {
    const buffer = Buffer.from(res.stream, 'utf8');
    const body = buffer.toString();
    const json = JSON.parse(body); // response from webhook.site API (contains our payload as a field)
    test("Got latest response from webhook", () => {
        chai.expect(json).to.have.property('content');
    });
    const latest = json.content; // `content` is our payload (set by VoPay in webhook-test POST)
    const found = JSON.parse(latest); // the parsed payload
    test("Check that the webhook-test was able to post JSON to receiver", function () {
        chai.expect(found).to.have.property('Success');
        chai.expect(found.Success).is.to.equal(true);
    });
    test("Expected payload validation fields present", function () {
        chai.expect(found).to.have.property('TransactionID');
        chai.expect(found).to.have.property('ValidationKey');
    });
    // check the ValidationKey
    // ValidationKey is a combination of API shared secret key and the transaction ID codified by HMAC SHA1
    const hmacSig = cryptojs.SHA1(`${process.env.SHAREDSECRET}${found.TransactionID}`).toString();

    test("Locally computed SHA1 HMAC matches remote ValidationKey", function () {
        chai.expect(hmacSig).is.to.equal(found.ValidationKey);
    });
});
