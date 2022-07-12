### Invalid Account info

<!-- if ITA info is passed into to an EFT endpoint and that info is incorrect (ie. invalid inst number, transit number or acct number), the bank will fail the transaction -->
If you make a valid API call with invalid account info, the bank will fail the transaction. This can happen when you provide incorrect or erroneous ITA that the endpoint does not reject. The bank will return an [error message](#failure) in its eventual response to VoPay.

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
