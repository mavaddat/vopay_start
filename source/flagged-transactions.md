### Flagged transactions

<!-- transaction can be flagged as a duplicate -->
To guard against unintended or suspicious transfers, we notify customers when we receive certain transactions requests. These transactions are flagged pending review by the customer. Choosing to clear the flag permits the transaction.
<!-- EFTs -->
#### Duplicate EFT Transactions

We will flag an EFT transaction as a potential duplicate EFT having these conditions:

<!-- two (or more) transactions with the same name, bank info, amount, and currency within 3 hours -->
- Within 3 hours of the original fund/withdraw transaction, another fund/withdraw having the same
  - Name
  - Bank account
  - Amount
  - Currency

<!-- Interac -->

#### Duplicate Interac Transfer

<!-- two (or more) transactions with the same amount, email address, and currency within 3 hours -->

Interac transfer will be flagged as potentially duplicate `payout`/`money-request` when:

- Within 3 hours of the original transaction, another having the same
  - Email address
  - Amount
  - Currency

#### Clearing the flag

As you learned in [the section on status polling](#polling-for-transaction-statuses), you may find flagged EFT/Interac transactions by providing `StartDateTime` and `EndDateTime` (both in `YYYY-MM-DD HH:MM:SS` or `YYYY-MM-DD` format) in a `GET` on `account/transactions`. The `TransactionFlag` field will show the flag reason (e.g., `duplicate`) followed by a list correspondingly flagged transaction IDs (where applicable).

<!-- CODE SNIPPET -->

Here is a representative response:

```json
{
    "Success": true,
    "ErrorMessage": "",
    "NumberOfRecords": 3,
    "Transactions": {
        "0": {
            "TransactionID": "460166",
            "TransactionDateTime": "2022-02-25 00:21:33",
            "TransactionType": "EFT Funding",
            "TransactionStatus": "pending",
            /* […] */
            "TransactionFlag": {
                "0": "duplicate - 460154,460160,460165,460166"
            },
            "PaylinkRequestID": "",
            "IsRefunded": false,
            "FullName": "John Doe"
        },
        "1": {
            "TransactionID": "460165",
            "TransactionDateTime": "2022-02-25 00:21:28",
            "TransactionType": "EFT Funding",
            "TransactionStatus": "pending",
            /* […] */
            "TransactionFlag": {
                "0": "duplicate - 460154,460160,460165,460166"
            },
            "PaylinkRequestID": "",
            "IsRefunded": false,
            "FullName": "John Doe"
        },
        "2": {
            "TransactionID": "460160",
            "TransactionDateTime": "2022-02-25 00:18:39",
            "TransactionType": "EFT Funding",
            "TransactionStatus": "pending",
            /* […] */
            "TransactionFlag": {
                "0": "duplicate - 460154,460160,460165,460166"
            },
            "PaylinkRequestID": "",
            "IsRefunded": false,
            "FullName": "John Doe"
        }
    }
}
```

`POST` `/account/transaction/confirm`

Call `POST` on `/account/transaction/confirm` with the `TransactionID` (`integer`) to clear a flagged transaction, thereby allowing it to be processed.

<!-- CODE SNIPPET -->

<!--   - troubleshooting.md -->
<!--   - when-do-transactions-fail.md -->
<!--   - common-errors.md -->

<!--   - flagged-transactions.md -->

<!--   - nsfs.md -->
<!--   - nsf-checks.md -->
<!--   - invalid-account-info.md -->
<!--   - other-errors.md -->
<!--   - other-transaction-requests.md -->
<!--   - cancel.md -->
<!--   - refund.md -->
<!--   - removing-flags.md -->
