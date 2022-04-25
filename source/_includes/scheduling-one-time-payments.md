## Scheduling one-time payments

<!-- • /eft/fund/schedule or /eft/withdraw/schedule -->
One-time future funding or funding can be scheduled using the `/eft/fund/schedule` or `/eft/withdraw/schedule` endpoints, respectively.

<!-- • essentially the same as an /eft/fund or /eft/withdraw endpoint, but with a scheduled date -->
These each have essentially the same function as the `/eft/fund` and `/eft/withdraw` endpoints, but the scheduler creates transactions on the specified dates.

`POST` `/eft/fund/schedule`

For scheduling one-time EFT fund transactions or one-time EFT withdrawals, the following are the minimally required parameters:

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `Amount`              | `number`  | The amount to be funded                                                               |
| `Frequency`           | `string`  | How often: `single` or `recurring`. For one-time funding, you will indicate `single`. |
| `ScheduleStartDate`   | `string`  | Date to post the transaction.                                                         |

`POST` `/eft/withdraw/schedule`
