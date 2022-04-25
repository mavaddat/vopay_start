# The Transaction lifecycle

From submission to settlement, each transaction is processed in a sequence of steps. The current state of any transaction is captured by the `TransactionStatus` attribute. Below you can find the typical status progression per transaction type.

<!-- EFTs -->
## EFTs

| Status | Meaning |
| :---: | :---: |
| Pending | The transaction starts in the `Pending` state when it is submitted. This is the initial state for every transaction. |
| In Progress | When the transaction is submitted to the bank, it is moved to the `In Progress` state. |
| Successful | When the transaction is settled and the funds have cleared, it is moved to the `Successful` state. |

<!-- Interac Money request -->
## Interac Money Request

| Status | Meaning |
| :---: | :---: |
| Pending | When submitted, the transaction starts in the `Pending` state. |
| Sent | When the transaction is submitted to the recipient (payee), it is moved to the `In Progress` state. |
| Successful | When the recipient accepts the money request, the transaction is moved to the `Successful` state. |

<!-- Interac e-transfer -->
## Interac e-Transfer

| Status | Meaning |
| :---: | :---: |
| Pending | When submitted, the transaction starts in the `Pending` state. |
| Requested | When an email has been sent to funds recipient, it is moved to the `In Progress` state. |
| Successful | When the recipient accepts the e-transfer, the transaction is moved to the `Successful` state. |
