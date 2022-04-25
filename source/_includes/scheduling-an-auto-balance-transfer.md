## Scheduling an auto-balance transfer

<!-- • /account/auto-balance-transfer -->
`POST` `/account/auto-balance-transfer`
<!-- • allows users to transfer entire balance from VoPay wallet to a bank account (i.e., it's basically a scheduled /eft/withdraw) -->
This endpoint allows you to schedule an auto-balance transfer (one-time or recurring) from your VoPay wallet to a bank account. This will regularly liquidate your entire balance so that your funds remain accessible to other services  attached to your bank account.
<!-- • users provide frequency and minimum amount to trigger a transfer (ex: only trigger a balance transfer if balance ❭ -->
<!-- $100) -->
To use this, you must indicate the frequency and the minimum amount available to check for a transfer. For example, you can choose to make a full balance transfer only when available funds exceed $100 in your wallet's currency.

The following are the minimally required parameters for this endpoint:

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `ScheduleStartDate`         | `string` | Date from which the transfer schedule will begin                                       |
| `AutoBalanceTransferAmount` | `number` | The minimum amount to have in your VoPay account to initiate a scheduled transfer.     |
| `TypeOfFrequency`           | `string` | Periodicity in which to receive the transfer: `daily`, `weekly`, `biweekly`, `monthly` |
