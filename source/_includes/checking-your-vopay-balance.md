# Checking your VoPay balance

`GET`{.httpmethod} `account/balance`{.endpoint}

Now you will use [your signature](#Generating-your-signature) to receive information from the sandbox. Routinely checking your balance before submitting any transaction is best practice, which this guide henceforth follows.

To do this, you need only your account ID, API key, and signature.

> Query Parameters

| Field | Data Type | Description | Necessity |
| ----------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| `AccountID` | `string` | Your account ID                                                                                                                                                      | required |
| `Key`       | `string` | API key for the account                                                                                                                                              | required |
| `Signature` | `string` | Hashed signature for the request                                                                                                                                     | required |
| `Currency`  | `string` | ISO 4217 3-character code for currency of transactions to fetch. Defaults to the wallet&rsquo;s local currency (`CAD`) | optional |

```powershell
Invoke-RestMethod -Method Get -Uri "https://earthnode-dev.vopay.com/api/v2/account/balance?AccountID=$AccountID&Key=$($Credentials.Key.Password | ConvertFrom-SecureString -AsPlainText)&Signature=$($Signature.Hash.ToLowerInvariant())&Currency=CAD"
```

```shell
account_id="alice.smith"
curl -s -X GET "https://earthnode-dev.vopay.com/api/v2/account/balance?AccountID=$account_id&Key=$KEY&Signature=$signature&Currency=CAD"
```

```python
account_id="alice.smith"
r = requests.get("https://earthnode-dev.vopay.com/api/v2/account/balance?AccountID=%s&Key=%s&Signature=%s&Currency=CAD" % (account_id, KEY, signature))
```

> The result

```json
{
  "Success": true,
  "ErrorMessage": "",
  "AccountBalance": "3000.00",
  "PendingFunds": "700.00",
  "SecurityDeposit": "1000.00",
  "AvailableFunds": "1300.00",
  "Currency": "CAD"
}
```

<aside class="caution">To send out funds, you must not exceed the available funds. To make a $2,000 transaction in CAD, for example, you must have &ge;$2,000 of Canadian currency in your wallet.</aside>
