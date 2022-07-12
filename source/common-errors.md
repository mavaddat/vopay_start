## Common errors

The following is a list of errors that can occur when submitting a transaction request.

| Error Message | Description | Solutions |
| ---------- | ----------- | -------- |
| `This Account is invalid or inactive. Please try again` | The account is not yet activated, is in a pending status, or the `AccountID` field was left empty | [Activate your account](https://vopay.com/api-sandbox/accounts/activate) |
| `Unauthorized IP(s). Please contact VoPay business team at business@vopay.com` | Attempt to make a request on a production endpoint from an unrecognized device | [Contact VoPay business team](https://vopay.com/api-sandbox/contact) |
| `Invalid Login. Please provide the required parameters` | The `AccountID`, `Key` or `Signature` fields were incorrect or left empty | See [authentication](#authentication) |
| `Available fund is insufficient` | The wallet does not have funds available sufficient to complete the transaction | [Contact VoPay business team](https://vopay.com/api-sandbox/contact) |
| `This operation is not currently enabled for your account. Please contact VoPay business team at business@vopay.com` | The account does not have permission to perform the requested action (e.g., exceeded quota/rate limits) | [Contact VoPay business team](https://vopay.com/api-sandbox/contact) |

The above errors indicate a problem immediately provided in the response &mdash; deferred errors can occur [when the bank must notify you](#invalid-account-info) of the problem. The latter (deferred) errors will show in your [webhook notifications](#setup-webhook-notifications) or when you [check the status of your transaction](#polling-for-transaction-statuses).

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
