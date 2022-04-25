## The response explained

A closer look at the response from the API:

| Field | Data Type | Description |
|----------------------|---------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Success`              | `boolean` | `true` when request successful, `false` when failed                                                                                                                                           |
| `ErrorMessage`         | `string`  | Contains a description of the error if the request failed                                                                                                                                        |
| `AccountBalance`       | `number`  | Indicates the total current account balance, including pending funds.                                                                                                                            |
| `PendingFunds`         | `number`  | Indicates the portion of the account balance which is pending due to *in-progress* EFT transactions.                                                                                               |
| `SecurityDeposit`      | `number`  | Indicates the portion of the account balance which is being held as a security deposit against returned or fraudulent transactions.                                                              |
| `AvailableFunds`       | `number`  | Indicates the portion of the account balance which is currently available for use. This is calculated `AccountBalance`&nbsp;-&nbsp;(`PendingFunds`&nbsp;+&nbsp;`SecurityDeposit`). |
| `Currency`             | `string`  | 3 character currency code for the balance being returned.                                                                                                                                        |

<aside class="success">You queried the VoPay <a href="https://docs.vopay.com/v2/vopay-api-reference/ref#accountbalanceget" target="_blank"><code>GET</code> account/balance endpoint</a> to retrieve the current account balance for your sandbox account.</aside>

The first step to getting a positive balance is to *fund your wallet*.
