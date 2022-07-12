## Scheduling recurring payments

<!-- • /eft/fund/schedule or /eft/withdraw/schedule -->
`POST` `/eft/fund/schedule`
`POST` `/eft/withdraw/schedule`

The same endpoints may be used to schedule recurring inbound or outbound transactions.

<!-- • essentially the same as /eft/fund and /eft/withdraw, except we also need frequency and number of payments (or end date) -->
Again, these have the same effect as `/eft/fund` and `/eft/withdraw` respectively, but with recurrence specifications. To achieve this, the following parameters are required:

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `Frequency`           | `string`  | How often the transaction is re-posted: `single` or `recurring`.                                                           |
| `NameOfFrequency`     | `string`  | The recurrence periodicity: `weekly`, `biweekly`, `semi-monthly`, `monthly`, `bimonthly`, `3 months`, `6 months`, `yearly` |
| `ScheduleStartDate`   | `string`  | Date on which the transactions will be started.                                                                            |
| `ScheduleEndDate`     | `string`  | Date on which the transactions will be ended (only if `EndingAfterPayments` is not specified).                             |
| `EndingAfterPayments` | `integer` | Number of payments after which the transactions will be ended (only `ScheduleEndDate` is not specified).                   |
