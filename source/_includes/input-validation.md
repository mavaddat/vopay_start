## Response Readiness

Your application needs to be able to send well-formed calls and process successful, flagged, and failed responses.

- *Successful* only means the transaction was sent to the bank for processing ([poll](#polling-for-transaction-statuses) or [webhook](#setup-webhook-notifications) to know if it clears).
- *Flagged* means the transaction is temporarily held for your review (see [clearing flags](#flagged-transactions)\).
- *Failed* means the transaction reached an unrecoverable conclusion (see [failure reasons](#failure)\).

### Input validation

VoPay performs format checks to ensure the data you provided is valid and can be processed. Calls that are not well-formed will return an error.

### Example valid input

The Postman collection provides examples of valid input for each field.

### API Responses

 Correspondingly, your solution should anticipate and process responses to **both successful and unsuccessful** API calls and transaction requests.

![Response diagram](https://raw.githubusercontent.com/gist/mavaddat/c238fcebca80e66a327cb47be271e4ae/raw/ce2434292580a514b39300f1d3ebd2b1cc966b71/response.svg)

Successful calls to the API *may not necessarily* produce successful transactions (see [When do transactions fail?](#when-do-transactions-fail)\). Successful calls can be identified by `"true"` in the `Success` field (and `""` in `ErrorMessage`); conversely, a `Success` response of `"false"`indicates that [there will be important information](#common-errors) in the `ErrorMessage`. Unsuccessful transactions will show `"failed"` in the `TransactionStatus` field.

See the [API specification](https://docs.vopay.com/v2/vopay-api-reference/ref) for a complete enumeration of responses for each call.
