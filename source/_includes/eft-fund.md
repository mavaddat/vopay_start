## Electronic Funds Transfer (EFT) Fund

`POST`{.httpmethod} `/eft/fund`{.endpoint}

To fund your VoPay account by EFT, you will **deposit** funds into your wallet &mdash; like depositing a cheque. Minimally, this requires providing the *deposit amount*, *payee name*, *payee's address*, and *payee's bank info*: institution, transit, account number (**ITA**).

| Parameter | Type | Description |
|----------|----------|-------------------------------------------------------|
| `Amount` | `number` | The amount to debit from the customer's bank account. |
| `FirstName` | `string` | The first name of the payee.                       |
| `LastName` | `string` | The last name of the payee.                        |
| `Address1` | `string` | The street address of the payee.                    |
| `City` | `string` | The city of the payee.                                 |
| `Province`| `string` | Two-character abbreviated province of the payee (e.g., ON, BC, AB). |
| `PostalCode` | `string` | The postal code of the payee.                     |
| `Country` | `string` | Full or ISO 3166-1 two-character abbreviated country of the payee (e.g., CA, US). |
| `FinancialInstitutionNumber` | `integer` | The institution number of the payee's bank.             |
| `BranchTransitNumber` | `integer` | The transit number of the payee's bank.             |
| `AccountNumber` | `integer` | The payee's bank account number.             |

For example, to deposit $200 into your VoPay wallet, you would `POST` to `/eft/fund` with the following parameters:

> Query Parameters

```json
{
  "Amount": 200.00,
  "LastName": "Smith",
  "FirstName": "Alice",
  "FinancialInstitutionNumber": "000",
  "BranchTransitNumber": 12345,
  "AccountNumber": 123456,
  "Address1": "123 Main St.",
  "City": "Vancouver",
  "Province": "BC",
  "PostalCode": "V1A 1A1",
  "Country": "CA"
}
```

<aside class="test">
See if you are able to post an EFT transaction to the sandbox using the code sample in your preferred language.
</aside>

> Post $2,000 to your VoPay wallet using EFT

&lt;!-- CODE SNIPPET HERE -->

> The following is a typical response:

```json
{
  "Success": true,
  "ErrorMessage": "",
  "TransactionID": "436749",
  "Iq11": "0"
}
```

In your solution, be sure to record the `TransactionID` you receive. You will need it to make future API calls on the transaction (e.g., getting status, cancelling, unflagging, etc.).

> Check your balance to verify the transaction.

```powershell
Invoke-RestMethod -Method Get -Uri "https://earthnode-dev.vopay.com/api/v2/account/balance?AccountID=$AccountID&Key=$($Credentials.Key.Password | ConvertFrom-SecureString -AsPlainText)&Signature=$($Signature.Hash.ToLowerInvariant())&Currency=CAD"
```

The change:

| Before | After |
| ------ | ----- |
| ![Account balance before EFT](slate/img/before_eft.svg) | ![Account balance after EFT](slate/img/after_eft.svg)  |

The account balance has increased by $200.00. The same amount can be seen in the pending balance. This will be the case until the transaction **settles**.

<aside class="notice">
The EFT adds to <em>pending</em> and <em>account</em> balances, but the funds are not available until the transaction settles (typically, 3 business days).
</aside>

![](slate/img/settlement.svg)

Funding transactions settle at midnight after 3 business days. A transaction submitted on Monday at 2 PM, for example, will settle at 11:59 PM EST on Thursday.
