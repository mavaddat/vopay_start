## EFT Withdraw

`POST`{.httpmethod} `/eft/withdraw`{.endpoint}

<!-- need name, address, amount, ITA info -->

Sending money by EFT is like writing someone a cheque. As with `eft/fund`, to send by electronic funds transfer, you will need a recipient's name, recipient's address, amount, and the recipient's ITA information.

```powershell
$Endpoint="eft/withdraw"
$Body = @{
    Amount=5000.00;
    FirstName="Adam";
    LastName="Smith";
    AccountNumber=123456;
    FinancialInstitutionNumber="000";
    BranchTransitNumber=12345;
    Address1="123 Main St.";
    City="Vancouver";
    Province="BC";
    Country="CA";
    PostalCode="V1A 1A1";
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
 
 

A typical response:

```json
{
  "Success": True,
  "ErrorMessage": ,
  "TransactionID": 437087,
  "Iq11": 0,
}
```
<!-- show how it impacts balance (money is withdrawn immediately) -->

If you check the balance now, you will see`AccountBalance` and `AvailableFunds` decrease by the amount withdrawn.

```json
{
  "Success": true,
  "ErrorMessage": "",
  "AccountBalance": PreviousAccountBalance - WithdrawnAmount,
  "PendingFunds": "0.00",
  "SecurityDeposit": "5000.00",
  "AvailableFunds": PreviousAccountBalance - WithdrawnAmount,
  "Currency": "CAD"
}
```

<!-- transaction is marked as successful at midnight EST on the day the withdraw was submitted (i.e., if withdraw was done at 2pm on Monday, transaction will be marked as successful at 11:59pm EST on Monday) -->

The withdrawal will be marked as successful at midnight EST on the day the withdrawal was submitted. For example, a withdrawal performed at 2 PM on Monday will be marked as successful at 11:59 PM EST on Monday.

![Diagram showing settlement period for withdrawal](slate/img/withdrawal.svg)
