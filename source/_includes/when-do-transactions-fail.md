## When do transactions fail?

Transactions can fail in VoPay or they can fail at the bank. As [discussed earlier](#response-readiness), transactions that VoPay sends to the bank will immediately produce a `TransactionID` for you in their response. If you fail to receive a `TransactionID` for a requested transaction, it means VoPay is unable to send that transaction to the bank and a failure reason will appear in the `ErrorMessage`.

### Invalid Account info

<!-- if ITA info is passed into to an EFT endpoint and that info is incorrect (ie. invalid inst number, transit number or acct number), the bank will fail the transaction -->
If you make a valid transaction request (you receive a `TransactionID`) with invalid account info (the provided ITA is incorrect or erroneous), the bank will fail the transaction. The bank will return an [error message](#failure) in its eventual response to VoPay. The turnaround for this invalid ITA ranges from twenty-minutes to a few hours.

To avoid this, you should either **use iQ11 tokens** in lieu of ITA or else **always check that you are supplying the correct institution number, transit number, and account number** for your intended transactions.

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
