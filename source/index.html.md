---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - powershell
  - shell
  - python

toc_footers:
  - <a href='https://vopay.com/api-sandbox/'>Sign Up for a Developer Key</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Getting Started with VoPay API's
---

## Getting Started

This guide will describe first steps to execute financial transactions using our API endpoints. To get a comfortable, we'll use our system shell (Windows PowerShell, macOS/linux shell, or Python 3) to make a few basic queries and send some test data.

First, though, we need to understand how each request is authenticated.

<p id="crop"><img id="handshake" src="images/handshake.gif" alt="Handshake to authenticate" title="Authentication is like a secret handshake &mdash; to receive JSON"></p>

## Authentication

When you sign up for an account, VoPay sends you two pieces of information. The first is a **shared secret**; the second is the **API key**. To authenticate, we will be joining or _concatenating _these two pieces of information (_strings_) together with the current date.

Here is a concatenation with a shared secret and an API key:

![Three example values concatenated together](/images/secret.svg)

We join the API key <strong><code>"3da54…b27661c"</code></strong> with the shared secret <strong> <code>"OTEy…INDk="</code></strong> and the date in <strong><code>yyyy-MM-dd</code></strong> format to make the concatenated string:

![](/images/concat.svg)

Now let's use the **sandbox key** and **shared secret** assigned to you by VoPay.

If you haven't already, [request sandbox API credentials with VoPay](https://vopay.com/api-sandbox/); then, substitute into the code snippets the credentials provided in your welcome email instead of the example values here. The sandbox account comes pre-populated with sample data to make testing more fun.

> Concatenation of the key, shared secret, and formatted date:

```powershell
$myVoPayKey = "3da541559918a808c2402bba5012f6c60b27661c"
$myVoPaySecret = "OTEyZWM4MDNiMmNINDk="
$formattedDate = Get-Date -Format "yyyy-MM-dd"
$myVoPayAuthStr = $myVoPayKey + $myVoPaySecret + $formattedDate
```

```shell
my_vopay_key="3da541559918a808c2402bba5012f6c60b27661c"
my_vopay_secret="OTEyZWM4MDNiMmNINDk="
formatted_date=$(date +%Y-%m-%d)
my_vopay_auth_str=$my_vopay_key$my_vopay_secret$formatted_date
```

```python
my_vopay_key = "3da541559918a808c2402bba5012f6c60b27661c"
my_vopay_secret = "OTEyZWM4MDNiMmNINDk="
formatted_date = datetime.datetime.now().strftime("%Y-%m-%d")
my_vopay_auth_str = my_vopay_key + my_vopay_secret + formatted_date

```

> Replace the example values with your API key and shared secret.

We will now perform a "cryptographic hash" (or just "hash") on this string. Specifically, the SHA1 hash. In Windows, we convert the above concatenated string into a binary representation. Then, we pass that to a hashing function.

See the code snippets to perform a SHA1 hash in your preferred language.

```powershell
$myVoPayAuthChars = $myVoPayAuthStr.ToCharArray()
$myVoPayAuthBytes = $myVoPayAuthChars | ForEach-Object { [System.Convert]::ToByte($_) }
$myVoPayAuthStream = [IO.MemoryStream]::new($myVoPayAuthBytes)  # Note: Reading changes the stream position
$myVoPayHash = Get-FileHash -InputStream $myVoPayAuthStream -Algorithm SHA1
$myVoPaySig = $myVoPayHash.Hash.ToLowerInvariant()
```

```shell
my_vopay_sig=$(echo -n $my_vopay_auth_str | sha1sum | awk '{print $1}')
```

```python
my_vopay_sig = hashlib.sha1(my_vopay_auth_str.encode('utf-8')).hexdigest()
```

<aside class="notice">
To get these code snippets working with your credentials, put your
<ul>
<li>API key instead of <code>3da541559918a808c2402bba5012f6c60b27661c</code></li>
<li>API shared secret <code>OTEyZWM4MDNiMmNINDk=</code></li>
<li>username instead of <code>daniella.nkechi@example.com</code> </li>
</ul>
</aside>

We will call the result our "signature". Let's see if we can use the signature to receive some information from the sandbox. For this, we also need your sandbox username. We will use the sandbox username as the `AccountID` in all our API testing.

```powershell
$myVoPayAccountID = "daniella.nkechi@example.com"
Invoke-RestMethod -Method Get -Uri "https://earthnode-dev.vopay.com/api/v2/account/balance?AccountID=$myVoPayAccountID&Key=$myVoPayKey&Signature=$myVoPaySig&Currency=CAD"
```

```shell
my_vopay_account_id="daniella.nkechi@example.com"
curl -s -X GET "https://earthnode-dev.vopay.com/api/v2/account/balance?AccountID=$my_vopay_account_id&Key=$my_vopay_key&Signature=$my_vopay_sig&Currency=CAD"
```

```python
my_vopay_account_id="daniella.nkechi@example.com"
r = requests.get("https://earthnode-dev.vopay.com/api/v2/account/balance?AccountID=%s&Key=%s&Signature=%s&Currency=CAD" % (my_vopay_account_id, my_vopay_key, my_vopay_sig))
```

The result:

```json
{
  "Success": true,
  "ErrorMessage": "",
  "AccountBalance": "45286.00",
  "PendingFunds": "0.00",
  "SecurityDeposit": "5000.00",
  "AvailableImmediately": "0.00",
  "AvailableFunds": "40286.00",
  "Currency": "CAD"
}
```

<aside class="success">We queried the VoPay <a href="https://docs.vopay.com/v2/vopay-api-reference/ref#accountbalanceget" target="_blank"><code>GET</code> account/balance endpoint</a> to retrieve the current account balance for our sandbox account.</aside>

## Kittens

## Get All Kittens

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.get()
```

```shell
curl "http://example.com/api/kittens" \
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let kittens = api.kittens.get();
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1,
    "name": "Fluffums",
    "breed": "calico",
    "fluffiness": 6,
    "cuteness": 7
  },
  {
    "id": 2,
    "name": "Max",
    "breed": "unknown",
    "fluffiness": 5,
    "cuteness": 10
  }
]
```

This endpoint retrieves all kittens.

### HTTP Request

`GET http://example.com/api/kittens`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
include_cats | false | If set to true, the result will also include cats.
available | true | If set to false, the result will include kittens that have already been adopted.

<aside class="success">
Remember — a happy kitten is an authenticated kitten!
</aside>

## Get a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.get(2)
```

```shell
curl "http://example.com/api/kittens/2" \
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let max = api.kittens.get(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Max",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific kitten.

<aside class="warning">Inside HTML code blocks like this one, you can't use Markdown, so use <code>&lt;code&gt;</code> blocks to denote code.</aside>

### HTTP Request

`GET http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to retrieve

## Delete a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.delete(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.delete(2)
```

```shell
curl "http://example.com/api/kittens/2" \
  -X DELETE \
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let max = api.kittens.delete(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "deleted" : ":("
}
```

This endpoint deletes a specific kitten.

### HTTP Request

`DELETE http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to delete
