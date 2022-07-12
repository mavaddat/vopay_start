## Polling for transaction statuses

One technique for tracking changes in transaction status is to *poll* (intermittently query) the transaction status endpoint.

`GET` `/account/transactions`

Minimally, this query requires the following parameters:

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `StartDateTime` | `string` | Return transactions that occurred on or after this date/time. Can be specified in either YYYY-MM-DD HH:MM:SS or YYYY-MM-DD format.  |
| `EndDateTime`   | `string` | Return transactions that occurred on or before this date/time. Can be specified in either `YYYY-MM-DD HH:MM:SS` or `YYYY-MM-DD` format. |

Additional filters may be specified by adding optional query parameters as follows:

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `Currency`               | `string`  | 3-character ISO 4217 currency code of transactions to return. Defaults to the wallet's local currency.                 |
| `TransactionType`        | `string`  | Specifies the type of transaction(s) to return. Accepted values are: '`EFT Funding`', '`EFT Withdrawal`', '`Interac Money Request`', '`Interac Bulk Payout`', '`Credit Card`', '`Fee`', '`Reversal`'. |
| `TransactionID`          | `integer` | Searches for a transaction with the specified ID, including any related child transactions which may exist.                                                              |
| `ClientReferenceNumber`  | `string`  | Returns transactions with the specified client reference number.                                                                                                                |
| `ScheduledTransactionID` | `string`  | Id of the scheduled transaction to find                                                                                                                                             |
| `IsFlagged`              | `boolean` | Only return transactions that have a flag status *unconfirmed* by the client.                                                      |
| `IsRefunded`             | `boolean` | Only return transactions that have been refunded.                                                                                                |

### Workflow

A typical polling workflow to track transaction status changes might utilize a cron service to iterate over the list of transaction IDs, making a `GET` request to `/account/transactions` for each ID.

<aside class="caution">You may incur additional fees for polling too frequently.</aside>

### Response Schema

The returned `Transactions` object is a zero-indexed hash-table of transactions with `NumberOfRecords` total number of records. Here is a sample response (truncated with `/*[…]*/` for legibility):

```json
{
  "Success": true,
  "ErrorMessage": "",
  "NumberOfRecords": 343,
  "Transactions": {
    "0": {
      "TransactionID": "442121",
      "TransactionDateTime": "2022-02-16 06:48:48",
      "TransactionType": "EFT Funding",
      "TransactionStatus": "pending",
      "Notes": "",
      "DebitAmount": "0.00",
      "CreditAmount": "10.00",
      "Currency": "CAD",
      "HoldAmount": "10.00",
      "LastModified": "2022-02-16 06:48:48",
      "ParentTransactionID": "",
      "ChildTransactionIDs": "",
      "ClientReferenceNumber": "",
      "ScheduledTransactionID": "",
      "ClientAccountID": "",
      "TransactionErrorCode": "",
      "TransactionFailureReason": "",
      "TransactionFlag": "@{0=duplicate - 442097,442119,442121}",
      "PaylinkRequestID": "",
      "IsRefunded": false,
      "FullName": "John Doe"
    },
    "1": {
      "TransactionID": "442119",
      /* […] */
      "TransactionFlag": "@{0=duplicate - 442097,442119,442121}",
      "PaylinkRequestID": "",
      "IsRefunded": false,
      "FullName": "John Doe"
    },
    "2": {
      "TransactionID": "442097",
      /* […] */
      "FullName": "John Doe"
    },
    "3": {
      "TransactionID": "436696",
      /* […] */
      "FullName": "John Doe"
    },
    /* […] */
    "340": {
      "TransactionID": "418677",
      /* […] */
      "FullName": "John Doe"
    },
    "341": {
      "TransactionID": "413330",
      /* […] */
      "FullName": "John Doe"
    },
    "342": {
      "TransactionID": "413322",
      /* […] */
      "FullName": "John Doe"
    }
  }
}
```
