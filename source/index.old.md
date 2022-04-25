### Sending money

Before making outbound transactions, wallets need to make funds available. To send money then, you will **fund** your wallet.

![Digital wallet](slate/img/wallet.svg)

You can do this by making a `POST` request to the `/api/v2/eft/fund` endpoint. This endpoint debits funds from a bank account that you specify in the request parameters.

```shell
curl --request POST \
 --url https://earthnode-dev.vopay.com/api/v2/eft/fund \
 --form "AccountID={AccountID}" \
 --form "Key={Key}" \
 --form "Signature={Signature}" \
 --form "ClientAccountID={ClientAccountID}" \
 --form "FirstName={FirstName}" \
 --form "LastName={LastName}" \
 --form "CompanyName={CompanyName}" \
 --form "DOB={DOB}" \
 --form "PhoneNumber={PhoneNumber}" \
 --form "Address1={Address1}" \
 --form "City={City}" \
 --form "Province={Province}" \
 --form "Country={Country}" \
 --form "PostalCode={PostalCode}" \
 --form "AccountNumber={AccountNumber}" \
 --form "FinancialInstitutionNumber={FinancialInstitutionNumber}" \
 --form "BranchTransitNumber={BranchTransitNumber}" \
 --form "Amount={Amount}" \
 --form "Currency={Currency}" \
 --form "Iq11VerificationLevelID={Iq11VerificationLevelID}" \
 --form "ClientReferenceNumber={ClientReferenceNumber}" \
 --form "KYCPerformed={KYCPerformed}" \
 --form "KYCReferenceNumber={KYCReferenceNumber}" \
 --form "EmailAddress={EmailAddress}" \
 --form "IPAddress={IPAddress}" \
 --form "FlinksAccountID={FlinksAccountID}" \
 --form "FlinksLoginID={FlinksLoginID}" \
 --form "Token={Token}" \
 --form "PlaidPublicToken={PlaidPublicToken}" \
 --form "PlaidAccessToken={PlaidAccessToken}" \
 --form "PlaidAccountID={PlaidAccountID}" \
 --form "PlaidProcessorToken={PlaidProcessorToken}" \
 --form "InveriteRequestGUID={InveriteRequestGUID}" \
 --form "TransactionLabel={TransactionLabel}" \
 --form "Notes={Notes}" \
 --form "DelayBankingInfo={DelayBankingInfo}" \
 --form "IdempotencyKey={IdempotencyKey}"
```

```powershell
Invoke-RestMethod -Method Post -Uri "https://earthnode-dev.vopay.com/api/v2/eft/fund" -Body '{"AccountID":"$AccountID","Key":"$KEY","Signature":"$Signature","ClientAccountID":"$ClientAccountID","FirstName":"$FirstName","LastName":"$LastName","CompanyName":"$CompanyName","DOB":"$DOB","PhoneNumber":"$PhoneNumber","Address1":"$Address1","City":"$City","Province":"$Province","Country":"$Country","PostalCode":"$PostalCode","AccountNumber":"$AccountNumber","FinancialInstitutionNumber":"$FinancialInstitutionNumber","BranchTransitNumber":"$BranchTransitNumber","Amount":"$Amount","Currency":"$Currency","Iq11VerificationLevelID":"$Iq11VerificationLevelID","ClientReferenceNumber":"$ClientReferenceNumber","KYCPerformed":"$KYCPerformed","KYCReferenceNumber":"$KYCReferenceNumber","EmailAddress":"$EmailAddress","IPAddress":"$IPAddress","FlinksAccountID":"$FlinksAccountID","FlinksLoginID":"$FlinksLoginID","Token":"$Token","PlaidPublicToken":"$PlaidPublicToken","PlaidAccessToken":"$PlaidAccessToken","PlaidAccountID":"$PlaidAccountID","PlaidProcessorToken":"$PlaidProcessorToken","InveriteRequestGUID":"$InveriteRequestGUID","TransactionLabel":"$TransactionLabel","Notes":"$Notes","DelayBankingInfo":"$DelayBankingInfo","IdempotencyKey":"$IdempotencyKey"}'
```

```python
import requests
r=requests.post('https://earthnode-dev.vopay.com/api/v2/eft/fund',
                data={
                    'AccountID': '$AccountID',
                    'Key': '$KEY',
                    'Signature': '$Signature',
                    'ClientAccountID': '$ClientAccountID',
                    'FirstName': '$FirstName',
                    'LastName': '$LastName',
                    'CompanyName': '$CompanyName',
                    'DOB': '$DOB',
                    'PhoneNumber': '$PhoneNumber',
                    'Address1': '$Address1',
                    'City': '$City',
                    'Province': '$Province',
                    'Country': '$Country',
                    'PostalCode': '$PostalCode',
                    'AccountNumber': '$AccountNumber',
                    'FinancialInstitutionNumber': '$FinancialInstitutionNumber',
                    'BranchTransitNumber': '$BranchTransitNumber',
                    'Amount': '$Amount',
                    'Currency': '$Currency',
                    'Iq11VerificationLevelID': '$Iq11VerificationLevelID',
                    'ClientReferenceNumber': '$ClientReferenceNumber',
                    'KYCPerformed': '$KYCPerformed',
                    'KYCReferenceNumber': '$KYCReferenceNumber',
                    'EmailAddress': '$EmailAddress',
                    'IPAddress': '$IPAddress',
                    'FlinksAccountID': '$FlinksAccountID',
                    'FlinksLoginID': '$FlinksLoginID',
                    'Token': '$Token',
                    'PlaidPublicToken': '$PlaidPublicToken',
                    'PlaidAccessToken': '$PlaidAccessToken',
                    'PlaidAccountID': '$PlaidAccountID',
                    'PlaidProcessorToken': '$PlaidProcessorToken',
                    'InveriteRequestGUID': '$InveriteRequestGUID',
                    'TransactionLabel': '$TransactionLabel',
                    'Notes': '$Notes',
                    'DelayBankingInfo': '$DelayBankingInfo',
                    'IdempotencyKey': '$IdempotencyKey'
                })
```

```javascript
var options = {
 "method": "POST",
 "url": "https://earthnode-dev.vopay.com/api/v2/eft/fund",
 "formData": {
  "AccountID": "{AccountID}",
  "Key": "{Key}",
  "Signature": "{Signature}",
  "ClientAccountID": "{ClientAccountID}",
  "FirstName": "{FirstName}",
  "LastName": "{LastName}",
  "CompanyName": "{CompanyName}",
  "DOB": "{DOB}",
  "PhoneNumber": "{PhoneNumber}",
  "Address1": "{Address1}",
  "City": "{City}",
  "Province": "{Province}",
  "Country": "{Country}",
  "PostalCode": "{PostalCode}",
  "AccountNumber": "{AccountNumber}",
  "FinancialInstitutionNumber": "{FinancialInstitutionNumber}",
  "BranchTransitNumber": "{BranchTransitNumber}",
  "Amount": "{Amount}",
  "Currency": "{Currency}",
  "Iq11VerificationLevelID": "{Iq11VerificationLevelID}",
  "ClientReferenceNumber": "{ClientReferenceNumber}",
  "KYCPerformed": "{KYCPerformed}",
  "KYCReferenceNumber": "{KYCReferenceNumber}",
  "EmailAddress": "{EmailAddress}",
  "IPAddress": "{IPAddress}",
  "FlinksAccountID": "{FlinksAccountID}",
  "FlinksLoginID": "{FlinksLoginID}",
  "Token": "{Token}",
  "PlaidPublicToken": "{PlaidPublicToken}",
  "PlaidAccessToken": "{PlaidAccessToken}",
  "PlaidAccountID": "{PlaidAccountID}",
  "PlaidProcessorToken": "{PlaidProcessorToken}",
  "InveriteRequestGUID": "{InveriteRequestGUID}",
  "TransactionLabel": "{TransactionLabel}",
  "Notes": "{Notes}",
  "DelayBankingInfo": "{DelayBankingInfo}",
  "IdempotencyKey": "{IdempotencyKey}"
 }
};

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});
```

## Example: Getting Account Balance 

### HTTPS Request

`GET https://earthnode-dev.vopay.com/api/v2/account/balance`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
AccountId | None | The email address or identifier of the sandbox account (provided when granted sandbox access).
Key | None | Unique identifier represented as 40-character hexadecimal string used to access the endpoints (provided by VoPay).
Signature | None | A SHA1 hash of your string-concatenated `api_key`, `shared_secret`, and `formatted_date`.
Currency | None | [ISO 4217 currency code](https://www.iso.org/iso-4217-currency-codes.html) for your desired country.


## Funding your wallet

To fund your VoPay account, you will need to **deposit** funds into your wallet. This is like receiving a check to cash. You can do this by making a `POST` request to the `/api/v2/eft/fund` endpoint. These requests can take up to three (3) business days to clear. Name, address, amount, bank account. The amount funded will appear in the pending until the check is cleared. Available funds will not change immediately, but `AccountBalance` will reflect the new balance.

Alternatively, you can fund your wallet by making an Interac payment request. Again, this guide will use the `POST` method to make the request, but this time you query the `/api/v2/interac/money-request` endpoint. With Interac transfer, the `AvailableFunds` again immediately reflect the pending, but funds clear as soon as money request is accepted.

Preview feature: Fund-my-account. Same as EFT fund, except it uses your personal bank account instead of asking for the account.

## EFT Withdrawal

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

Rather than requesting from us, this guide will tell you when a transaction status changes.

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

Get a link to iframe in an email. See <https://docs.vopay.com/v2/docs/paylink> and <https://docs.vopay.com/v2/vopay-api-reference/ref#eftpaylinkpost>

## What can go wrong

### Flag (duplicate)

### NSF (fail)

### Invalid account information

## How to refund, cancel, remove flags

---

## Client accounts

### Network among clients

### Different transaction flows between clients
