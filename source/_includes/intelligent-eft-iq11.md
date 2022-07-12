# Aliasing Sensitive Data

Instead of supplying ITA details every time you issue EFTs, you can request a persistent token that authorizes current/future transactions. This simplifies your auth flow and minimizes the number of sensitive data in the requests.

If the customer authorizes using the bank's web login (**vetted**), an iQ11 token also allows you to avoid **non-sufficient funds** failures for that customer. Instead, VoPay will gracefully fail any transaction lacking sufficient funds before it reaches the bank. See the section on [NSF's](#nsfs) for more details.

<!--   - intelligent-eft-iq11.md -->

<!--   - what-is-iq11.md -->
<!--   - generating-a-manual-token.md -->
<!--   - connecting-your-bank-account-online.md -->
<!--   - paylink.md -->
<!--   - requesting-banking-info-via-paylink.md -->
