### Requesting banking info via Paylink

There are three steps to using Paylink to request your customers provide their ITA banking info, aliased as iQ11 tokens.

First, query `POST` at `/iq11/generate-embed-url` to set the options for the graphical web interface in which your customer will provide their ITA. You already learned this in the [Embed Options section](#embed-options). The response contains an `IframeKey` you will deploy in the next step &mdash; when you trigger sending the email.
  
<!-- CODE SNIPPET HERE -->

`POST` `/eft/pay-link/beneficiary`

Then, send `POST` to the `/eft/pay-link/beneficiary` endpoint to actually send the email to the customer. This email will contain a link to the VoPay graphical user interface you provisioned above.

<!-- CODE SNIPPET HERE -->

A representative response:

```json
{
    "Success": true,
    "ErrorMessage": "",
    "PaylinkRequestID": "4786",
    "FirstName": "Susan",
    "LastName": "Smith",
    "Link": "https://request.vopay.com/f515eec8739155552ea4a56f80e5edc0cdb13303",
    "Status": "pending",
    "ReceiverEmailAddress": "susan.smith@elpmaxe.moc",
    "SenderEmailAddress": "alice.algonquin@example.com",
    "Note": "SDD",
    "SenderName": "Alice Algonquin",
    "ClientReferenceNumber": "012345"
}
```

`GET` `/eft/pay-link`

Lastly, at any point after the customer provides their banking info as ITA or **vetted** banking login, you will either collect the iQ11 token by reading the `Token` query param on the URL; or else, poll the `/eft/pay-link` endpoint to get the iQ11 token.

<!-- CODE SNIPPET HERE -->

A representative response:

```json
{
    "Success": true,
    "ErrorMessage": "",
    "PaylinkRequests": {
        "0": {
            "PaylinkRequestID": "4786",
            "FirstName": "Susan",
            "LastName": "Smith",
            "ReceiverEmailAddress": "susan.smith@elpmaxe.moc",
            "SenderName": "Alice Algonquin",
            "SenderEmailAddress": "alice.algonquin@example.com",
            "Status": "completed",
            "RequestDate": "2022-02-24 21:53:40",
            "Link": "https://request.vopay.com/f515eec8739155552ea4a56f80e5edc0cdb13303",
            "Token": "gssoog04oo4kcwo0w8sk0wwwsckcks0og4gwwggkwccwcwcs88sow4ocowc4gwck",
            "Note": "SDD",
            "ClientReferenceNumber": "012345",
            "Amount": "",
            "Currency": "",
            "TransactionID": "",
            "ScheduledPaymentsID": "",
            "TransactionType": "",
            "PaylinkRequestType": "Beneficiary",
            "Institution": "VOPAY TESTING BANK",
            "FinancialInstitutionNumber": "999",
            "BranchTransitNumber": "99999",
            "AccountNumber": "*****9999"
        }
    }
}
```

Then you can use the token for all future EFT transactions for that customer.

<!-- CODE SNIPPET HERE -->

<!--   - intelligent-eft-iq11.md -->
<!--   - what-is-iq11.md -->
<!--   - generating-a-manual-token.md -->
<!--   - connecting-your-bank-account-online.md -->
<!--   - paylink.md -->

<!--   - requesting-banking-info-via-paylink.md -->
