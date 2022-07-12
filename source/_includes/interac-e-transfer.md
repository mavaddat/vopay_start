## Interac e-transfer

<!-- /interac/bulk-payout -->

`POST`{.httpmethod} `/interac/bulk-payout`{.endpoint}

<!-- need recipient name, email address, amount, security question/answer -->

Sending an Interac e-transfer is the familiar process of sending money to another person by email or SMS. To send by Interac, you will need a recipient's name (or cellphone number), recipient's email address, amount to send, and the security question/answer you want the recipient to answer.

<!-- show example -->

```powershell
$Endpoint = "interac/bulk-payout"
$Body = @{
    Amount=1000.00;
    RecipientName="Samuel Adams";
    Question="Why?";
    Answer="Why not";
    EmailAddress="samuel.adams@yahoo.ca"
}
Invoke-RestMethod -Method Post -Uri "https://earthnode-dev.vopay.com/api/v2/${Endpoint}?AccountID=$AccountID&Key=$($Credentials.Key.Password | ConvertFrom-SecureString -AsPlainText)&Signature=$($Signature.Hash.ToLowerInvariant())&Currency=CAD" -Body $Body
```

```shell

```

```ruby

```

```python

```

```php

```

```csharp

```

```javascript

```

```java

```

```go

```

A successful Interac e-transfer will return the following response:

```json
{
  "Success": true,
  "ErrorMessage": "",
  "TransactionID": "437093",
  "TransactionConfirmed": true
}
```

<!-- show how it impacts balance -->
As in [EFT withdraw](#EFT-Withdraw), `AccountBalance` and `AvailableFunds` decrease by the amount sent if the balance is queried.

```json
{
  "Success": true,
  "ErrorMessage": "",
  "AccountBalance": PreviousAccountBalance - Amount,
  "PendingFunds": "0.00",
  "SecurityDeposit": "5000.00",
  "AvailableFunds": PreviousAvailableFunds - Amount,
  "Currency": "CAD"
}
```

<!-- transactions are executed in near real-time -->

Interac e-transfer transactions are executed in real-time, practically.

<!-- transaction is marked as complete once the recipient accepts e-transfer -->

A transaction will be marked as `successful` once the recipient accepts the e-transfer.
