# Failure

Below is a complete list of return and reversal bank codes when a transaction fails.

<aside class="warning">It may take up to 5 business days for a `901` `NSF` (Non-Sufficient Funds) return code to be returned from the bank.</aside>

| **Code** | **Returned Item Reason** | **Description** |
| ---- | ---- | ---- |
| `900` | Edit Reject | Bank account information cannot be validated. |
| `901` | NSF | Bank account does not have enough funds to complete the transaction. |
| `902` | Cannot Trace | The account cannot be located. |
| `903` | Payment Stopped/Recalled | The account holder has asked the bank to stop/recall the payment. |
| `904` | Post/Stale Dated | Considered stale-dated after six months. A stale-dated payment means that the item is old, and not necessarily invalid. Financial institutions may still honour these items, but there is no obligation to do so. |
| `905` | Account Closed | This account is closed and cannot be debited/credited. |
| `907` | No Debit Allowed | This account does not allow debit transactions. |
| `908` | Funds Not Cleared | The payer/payee has made a credit payment to their account that has not cleared. The payee did not have enough clear funds in the account to cover the debit amount. |
| `909` | Currency/Account Mismatch | The currency of the transaction does not match the currency of the account. |
| `910` | Payer/Payee Deceased | The account may be closed or frozen due to a death. |
| `911` | Account Frozen | This account is not allowing any transactions. |
| `912` | Invalid/Incorrect Account No. | The account number is not correct or its invalid format. |
| `914` | Incorrect Payer/Payee Name | The account payer/payee name does not match the transaction details. |
| `915` | PAD No Agreement Existed &ndash; Business/Personal | Account holder has asked the financial institution to withhold payment. |
| `916` | PAD Not In Accordance with Agreement - Personal | The payer has requested the debit to be returned as the debit has not been issued in accordance with the PAD agreement the customer signed. |
| `917` | PAD Agreement Revoked - Personal | The payer has requested the debit to be returned as they have cancelled the PAD agreement authorizing the debit. |
| `918` | PAD No Pre-Notification &ndash; Personal | Bank requires a pre-notification agreement and cannot allow payment. |
| `919` | PAD Not In Accordance with Agreement &ndash; Business | The payer has requested the debit to be returned as the debit has not been issued in accordance with the PAD agreement the customer signed. |
| `920` | PAD Agreement Revoked &ndash; Business | The payer has requested the debit to be returned as they have cancelled the PAD agreement authorizing the debit. |
| `921` | PAD No Pre-Notification &ndash; Personal | The payer has requested the debit to be returned as they have did not receive pre-notification of a change to the PAD date or amount, or they did not receive written confirmation of a PAD Agreement executed by electronic means. |
| `989` | Information not provided by the bank | Specified processor's response code is not recognized by the system. The respective request of a received code clarification needs to be addressed to the processor. |
| `990` | Institution in Default | The bank has declared insolvency |

## Example responses

Below are examples of failure responses due to a returned transaction or error when calling an endpoint.

```json
{
    "Success": false,
    "ErrorMessage": "901 - iQ11 - Insufficient Funds"
}
```

```json
{
    "Success": false,
    "ErrorMessage": "909 - Currency/Account Mismatch"
}
```
