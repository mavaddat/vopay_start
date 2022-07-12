## Interac money request

`POST`{.httpmethod} `/interac/money-request`{.endpoint}

To fund by Interac money request, you need only a recipient name, email address, and amount.

For example, to request $300.00 from `John Doe`:

```json
{
  "RecipientName": "John Doe",
  "Email": "john.doe@hotmail.com",
  "Amount": 3000.00
}
```

```powershell
$Endpoint = "interac/money-request"
$InteracMoneyRequest = @{
        Amount=3000.00;
        Email="john.doe@hotmail.com";
        RecipientName="John Doe"
    }
Invoke-RestMethod -Method Post -Uri "https://earthnode-dev.vopay.com/api/v2/$Endpoint?AccountID=$AccountID&Key=$($Credentials.Key.Password | ConvertFrom-SecureString -AsPlainText)&Signature=$($Signature.Hash.ToLowerInvariant())&Currency=CAD" -Body $InteracMoneyRequest | ConvertTo-Json
```

```shell
declare -A InteracMoneyRequest=(
    [Amount]=3000.00
    [Email]="john.doe@gmail.com"
    [RecipientName]="John Doe"
)
curl -X POST -H "Content-Type: application/json" -d "$(jq -n "$InteracMoneyRequest")" "https://earthnode-dev.vopay.com/api/v2/interac/money-request?AccountID=$account_id&Key=$KEY&Signature=$signature&Currency=CAD"
```

```ruby
InteracMoneyRequest = {
    Amount: 3000.00,
    Email: "john.doe@gmail.com"
    RecipientName: "John Doe"
}
r = requests.post("https://earthnode-dev.vopay.com/api/v2/interac/money-request?AccountID=%s&Key=%s&Signature=%s&Currency=CAD" % [account_id, KEY, signature], json: InteracMoneyRequest)
```

```python
InteracMoneyRequest = {
    "Amount": 3000.00,
    "Email": "john.doe@gmail.com",
    "RecipientName": "John Doe"
}
r = requests.post("https://earthnode-dev.vopay.com/api/v2/interac/money-request?AccountID=%s&Key=%s&Signature=%s&Currency=CAD" % [account_id, KEY, signature], json: InteracMoneyRequest)
```

```php
$InteracMoneyRequest = array(
    "Amount" => 3000.00,
    "Email" => "john.doe@gmail.com",
    "RecipientName" => "John Doe"
)
r = requests.post("https://earthnode-dev.vopay.com/api/v2/interac/money-request?AccountID=%s&Key=%s&Signature=%s&Currency=CAD" % [account_id, KEY, signature], json: $InteracMoneyRequest)
```

```csharp
var InteracMoneyRequest = new Dictionary<string, object>
{
    ["Amount"] = 3000.00,
    ["Email"] = "john.doe@gmail.com",
    ["RecipientName"] = "John Doe"
};
r = await client.PostAsync("https://earthnode-dev.vopay.com/api/v2/interac/money-request?AccountID=%s&Key=%s&Signature=%s&Currency=CAD" % [account_id, KEY, signature], new StringContent(JsonConvert.SerializeObject(InteracMoneyRequest), Encoding.UTF8, "application/json"));
```

```javascript

```


```java

```


```go

```



<!--show how it impacts balance -->

The result:

```json
{
  "Success": true,
  "ErrorMessage": "",
  "TransactionID": "437073",
  "TransactionStatus": "requested",
  "Flagged": null
}
```

Here, you see the account balance and pending funds increased by the amount you requested ($300 in the example):

| Before | After |
| ------ | ----- |
| ![](slate/img/before_imr.svg) | ![](slate/img/after_imr.svg)  |

Interac transactions are processed nearly in real-time, meaning the request email is sent out to recipients right away.

Once the request is accepted by the recipient, the funds are made available in your account.
