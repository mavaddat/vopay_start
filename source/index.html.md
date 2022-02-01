---
title: Getting Started

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

When you sign up for an account, VoPay sends you two pieces of information. The first is a **shared secret**; the second is the **API key**. To authenticate, we will be joining or _concatenating_ these two pieces of information (_strings_) together with the current date.

Here is a concatenation with a shared secret and an API key:

![Three example values concatenated together](/images/secret.svg "This is the operation to concat our three example values ")

We join the API key <strong><code style="color: #1111fe !important;">"3da54…b27661c"</code></strong> with the shared secret <strong><code style="color: #55fd55 !important;">"OTEy…INDk="</code></strong> and the date in <strong><code style="color: #9e0dfe !important;">yyyy-MM-dd</code></strong> format to make the concatenated string:

![The resulting string after concatenation](/images/concat.svg "Colour-coded concatenated string")

Find the **sandbox key** and **shared secret** assigned to you by VoPay.

<aside class="notice">
The sandbox is pre-populated with data to query. If you haven't already, <a href="https://vopay.com/api-sandbox/" target="_blank">request sandbox API credentials</a> with VoPay; then, substitute those credentials into the code snippets.
</aside>

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

We will now perform a "cryptographic hash" (or just "hash") on this string. Specifically, the SHA1 hash.

> A SHA1 hash can be calculated in any shell.

```powershell
# We convert the concatenated string into a binary representation.
$myVoPayAuthChars = $myVoPayAuthStr.ToCharArray()
$myVoPayAuthBytes = $myVoPayAuthChars | ForEach-Object { [System.Convert]::ToByte($_) }
$myVoPayAuthStream = [IO.MemoryStream]::new($myVoPayAuthBytes)  # Note: Reading changes the stream position
# Then, we pass that to a hashing function.
$myVoPayHash = Get-FileHash -InputStream $myVoPayAuthStream -Algorithm SHA1
$myVoPaySig = $myVoPayHash.Hash.ToLowerInvariant()
```

```shell
my_vopay_sig=$(echo -n $my_vopay_auth_str | sha1sum | awk '{print $1}')
```

```python
my_vopay_sig = hashlib.sha1(my_vopay_auth_str.encode('utf-8')).hexdigest()
```

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

> The result

```json
{
  "Success": true,
  "ErrorMessage": "",
  "AccountBalance": "3000.00",
  "PendingFunds": "700.00",
  "SecurityDeposit": "1000.00",
  "AvailableImmediately": "0.00",
  "AvailableFunds": "1300.00",
  "Currency": "CAD"
}

To send out, we cannot exceed the available funds. Imagine we want to make a $2,000 transaction.
```

<aside class="success">We queried the VoPay <a href="https://docs.vopay.com/v2/vopay-api-reference/ref#accountbalanceget" target="_blank"><code>GET</code> account/balance endpoint</a> to retrieve the current account balance for our sandbox account.</aside>

This endpoint retrieves our account balance.

### HTTPS Request

`GET https://earthnode-dev.vopay.com/api/v2/account/balance`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
account_id | None | The email address or identifier of the sandbox account (provided by you when signing up).
api_key | None | Unique identifier represented as 40-character hexadecimal string used to access the endpoints (provided by VoPay).
signature | None | A SHA1 hash of your string-concatenated `api_key`, `shared_secret`, and `formatted_date`.
currency | None | [ISO 4217 currency code](https://www.iso.org/iso-4217-currency-codes.html) for your desired country.

## How VoPay works

Let's take a step back to look at how VoPay works.

### Virtual wallet

VoPay provides programmatic endpoints to perform any financial transaction: withdraw and deposit from your savings or chequing accounts; request payments; transfer or send money; make bulk payouts; and more. This allows your funds to exist securely in a digital space with all the confidence you place in your own bank.

In effect, a VoPay account acts like a virtual wallet.

### Sending money

Before making outbound transactions, we need to make funds available digitally. To send money, we first **fund** our wallet.

![Digital wallet](/images/wallet.svg)

This means that we need to **deposit** funds into our wallet. We can do this by making a `POST` request to the `/api/v2/account/deposit` endpoint. We will use the `POST` method because we are depositing funds into our wallet. We will also use the `Content-Type` header to specify that we are sending JSON data.

## Checking your balance

As we have already seen, we can query the `/api/v2/account/balance` endpoint to retrieve the current balance of our account. This endpoint is also used to retrieve the balance of a specific currency.

<aside class="information">
VoPay does not do any currency conversions. The balance returned is the balance of the account in the currency specified in the `currency` query parameter.
</aside>

## Funding your account

To fund our account, we will need to **deposit** funds into our wallet. This is like receiving a check to cash. We can do this by making a `POST` request to the `/api/v2/eft/fund` endpoint. We will use the `POST` method because we are depositing funds into our wallet. These requests can take up to three (3) business days to clear. Name, address, amount, bank account. The amount funded will appear in the pending until the check is cleared. Available funds will not change immediately, but `AccountBalance` will reflect the new balance.

Alternatively, we can fund our wallet by making an Interac payment request. Again, we will use the `POST` method to make the request, but this time we query the `/api/v2/interac/money-request` endpoint. With Interac transfer, the `AvailableFunds` again immediately reflect the pending, but funds clear as soon as money request is accepted.

Preview feature: Fund-my-account. Same as EFT fund, except it uses your personal bank account instead of asking for the account.

## EFT Withdrawl

Sending to another person's bank account. Like sending a check.

## E-Transfer

Sending Interac money to another person by email or SMS. No bank details needed.

---

## Transaction lifecycle

How a transaction goes from submitted to completed for various types of transactions.

### Transaction status

- GET account/transactions
  - Pass in the transaction ID
### Webhooks

Rather than requesting from us, we will tell you when a transaction status changes.
## Scheduling transactions

Just EFT transactions.

- One-time
- Recurring

## Intelligent EFT (iQ11)

- Generating iframe
- Different settings
- Connect bank account online as opposed to entering info manually
- Embedding iframe into website.

## Paylink

Get a link to iframe in an email. See https://docs.vopay.com/v2/docs/paylink and https://docs.vopay.com/v2/vopay-api-reference/ref#eftpaylinkpost

## What can go wrong

### Flag (duplicate)

### NSF (fail)

### Invalid account information

## How to refund, cancel, remove flags

---

## Client accounts

### Network among clients

### Different transaction flows between clients
