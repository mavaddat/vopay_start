## Token via Customer Login

`POST` `/iq11/generate-embed-url`

<!-- generate an iFrame (/iq11/generate-embed-url) -->
This endpoint generates a distributable user interface you can deploy to collect your customers' ITA information. To use it, note the `EmbedURL` field in the response payload when you query `/iq11/generate-embed-url`.

This URL, uniquely associated to connect with your wallet, will look like `https://earthnode-dev.vopay.com/iq11/embed/<UNIQUE_IDENTIFIER>` with a 40-char `<UNIQUE_IDENTIFIER>`. You can embed the UI in your own solution using an `iframe` or `object`, as in this example (adapt dimensions to your needs):

```html
<iframe src="https://earthnode.vopay.com/iq11/embed/a3c6bb45f2fc02478cb900bf9d3e11264b356105" width="100%" height="500px" frameborder="0" scrolling="no"></iframe>
```

### Embed Options

<!-- can provide account selection methods (manual or online or both) -->
The embedded `iframe` or `object` can allow your customers to authorize with their bank through the bank's interface (vetted login using their online banking credentials); or, identify their bank and then provide an account number.

When you call the `/iq11/generate-embed-url` endpoint, you can specify the following options:

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `Language` | `string` | `en` (English) or `fr` (French). Default: `en` |
| `AccountSelectionMethod` | `string` | This parameter accepts `any`, `online` and `manual`. Default: `any`. |
| `RedirectMethod` | `string` | This parameter accepts `InnerRedirect`, `OuterRedirect`, and `JavascriptMessage` as parameter values. |
| `RedirectURL` | `string` | URL to redirect to after the customer logs in to their online banking account. The bank account token will be passed as a URL query param, as in the example [https://example.com/page?Token=<IQ11TOKEN>](#) |
| `Version` | `string` | The newer `v2` allows account selection, whereas `v1` uses `online` only. |

Below, a closer look at the last five parameters.

#### `AccountSelectionMethod`

By varying `AccountSelectionMethod`, your solution can either restrict customers to one of the above account-access provision methods (`online` or `manual`) or allow them the freedom to choose (`any`). Here is an elaboration:

| `AccountSelectionMethod` choice | How a customer provides access to their account |
|---|---|
| `online` | Directly authorizes using their bank's login. |
| `manual` | Chooses a bank (which pulls up institution and transit info), then manually inputs account number. |
| `any` | Allows the customer to select an account from any bank. |

#### `RedirectMethod` and `RedirectURL`

How do you want your solution to process access authorization?

| `RedirectMethod` choice | After account access submission |
|---|---|
| `InnerRedirect` | The embedded context alone redirects to `RedirectURL`|
| `OuterRedirect` | The parent context redirects to `RedirectURL`|
| `JavascriptMessage` | The `iframe` posts a message received by the parent's callback function by `addEventListener`. |

If you want to redirect, then you must provide a URL to redirect to. The iQ11 token will be encoded in a query parameter `Token=<IQ11TOKEN>` of the URL, for example:`https://example.com?Token=8wcscwkwc4wo4wsgcgss4kswcg0s48cc4ow4wgg8cw0og48csswko4ww0088g4c4`

To use `JavascriptMessage`, in your solution, you implement a callback function for the [`MessageEvent`](https://developer.mozilla.org/en-US/docs/Web/API/MessageEvent) your embed produces.

A simple callback looks like this:

```javascript
window.addEventListener('message', function (event) {
    if (event.origin === 'https://embed.vopay.com' && event.data.Token) {
        // handle iQ11 token
        const iq11token = event.data.Token;
        // do something with iQ11 token
});
```

See `iq11eventhandler.js` for a more complete example.

The [`MessageEvent.data`](https://developer.mozilla.org/en-US/docs/Web/API/MessageEvent/data) your embed produces will look like this:

```json
{
    "Step": "LINK",
    "Token": "8wcscwkwc4wo4wsgcgss4kswcg0s48cc4ow4wgg8cw0og48csswko4ww0088g4c4",
    "Url": "https://example.com?Token=8wcscwkwc4wo4wsgcgss4kswcg0s48cc4ow4wgg8cw0og48csswko4ww0088g4c4",
}
```

Here, the `Token` represents the iQ11 token you can use in place of ITA to query the EFT endpoints. The `Url` is the URL you provided as `RedirectURL` with the `Token` as a query param.

#### `Version`

Choose `v2` as the version. We are moving legacy customers away from the `v1` parameter set &mdash; it will be removed in the future.

<!-- can provide payment methods (bank or credit card or both) — we'll just focus on bank account here -->
---
<!-- we return a URL which the user can embed in their app -->
The response to your query will look like this:

```json
{
    "Success": true,
    "ErrorMessage": "",
    "EmbedURL": "https://embed-dev.vopay.com/f3240f2c26939f263a5e19381106229f148a830a",
    "IframeKey": "f3240f2c26939f263a5e19381106229f148a830a"
}
```
<!-- The URL provides UI that takes the end-user through a journey to connect their bank account online -->
The user interface your customers will use to permit access to their accounts is provisioned for  you at the `EmbedURL`.

<aside class="caution"> To avoid security vulnerabilities (<a href="https://web.dev/what-is-mixed-content/" target="_blank" title="Google web.dev article on mixed content">Chrome</a>, <a href="https://developer.mozilla.org/en-US/docs/Web/Security/Mixed_content" target="_blank" title="Mozilla docs on mixed content">Firefox</a>), make sure to implement an <strong>HTTPS context</strong> for the embed. </aside>
<!-- when this is done, we return a token, which can then be used in our EFT endpoints -->

<!--   - intelligent-eft-iq11.md -->
<!--   - what-is-iq11.md -->
<!--   - generating-a-manual-token.md -->

<!--   - connecting-your-bank-account-online.md -->

<!--   - paylink.md -->
<!--   - requesting-banking-info-via-paylink.md -->
