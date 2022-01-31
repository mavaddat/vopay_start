---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - powershell
  - python

toc_footers:
  - <a href='https://vopay.com/api-sandbox/'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Getting Started with VoPay API's
---

## Getting Started

This guide will describe first steps to execute financial transactions using our API endpoints. To get a comfortable, we'll use our system shell to make a few basic queries and send some test data.

First, though, we need to understand how each request is authenticated.

## Authentication

When you sign up for an account, VoPay sends you two pieces of information. The first is a **shared secret**; the second is the **API key**. To authenticate, we will be joining or _concatenating _these two pieces of information (_strings_) together with the current date.

Here is a concatenation with a shared secret and an API key:

![Three example values concatenated together](/images/secret.svg)

> Concatenation of the key, shared secret, and formatted date:

```powershell
$myVoPayKey = "3da541559918a808c2402bba5012f6c60b27661c"
$myVoPaySecret = "OTEyZWM4MDNiMmNINDk="
$formattedDate = Get-Date -Format "yyyy-MM-dd"
$myVoPayAuthStr = $myVoPayKey + $myVoPaySecret + $formattedDate
```

```python
my_vopay_key = "3da541559918a808c2402bba5012f6c60b27661c"
my_vopay_secret = "OTEyZWM4MDNiMmNINDk="
formatted_date = datetime.datetime.now().strftime("%Y-%m-%d")
my_vopay_auth_str = my_vopay_key + my_vopay_secret + formatted_date

```

```shell
my_vopay_key="3da541559918a808c2402bba5012f6c60b27661c"
my_vopay_secret="OTEyZWM4MDNiMmNINDk="
formatted_date=$(date +%Y-%m-%d)
my_vopay_auth_str=$my_vopay_key$my_vopay_secret$formatted_date
```

> Make sure to replace the example values with your API key and shared secret.

Use the **sandbox key** and **shared secret** assigned to you by VoPay.

If you haven't already, [request sandbox API credentials with VoPay](https://vopay.com/api-sandbox/); then, substitute into the code snippets the credentials provided in your welcome email instead of the example values here. The sandbox account comes pre-populated with sample data to make testing more fun.

We join the API key <strong><code>"3da54…b27661c"</code></strong> with the shared secret <strong> <code>"OTEy…INDk="</code></strong> and the date in <strong><code>yyyy-MM-dd</code></strong> format to make the concatenated string:

`Authorization: meowmeowmeow`

<aside class="notice">
You must replace <code>meowmeowmeow</code> with your personal API key.
</aside>

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
