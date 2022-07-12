## Manually generating a token

You can generate an iQ11 token manually by providing your customers' ITA information to the `tokenize` endpoint.

<!-- • /iq11/tokenize -->
`POST` `/iq11/tokenize`

The following iQ11 parameters are required for Canadian banks:

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `AccountHolderName`          | `string` | Account holder's full name.                 |
| `AccountNumber`              | `string` | Customer's bank account number for funds to be debited from. |
| `FinancialInstitutionNumber` | `string` | Three digit institution number for a Canadian bank.          |
| `BranchTransitNumber`        | `string` | Transit number for the customer's account.                   |

<!-- • users can now pass in this token instead of ITA info to our EFT endpoints -->
The generated token can now be used instead of ITA in all the EFT transaction endpoints discussed earlier. For example, with `POST` `eft/fund`, you can now provide a single `Token` parameter instead of `AccountHolderName`, `AccountNumber`, `FinancialInstitutionNumber`, and `BranchTransitNumber`. Here is the new query string:

<!-- CODE SNIPPET HERE EFT FUND WITH TOKEN IN LIEU OF ITA -->

<!--   - intelligent-eft-iq11.md -->
<!--   - what-is-iq11.md -->

<!--   - generating-a-manual-token.md -->

<!--   - connecting-your-bank-account-online.md -->
<!--   - paylink.md -->
<!--   - requesting-banking-info-via-paylink.md -->
