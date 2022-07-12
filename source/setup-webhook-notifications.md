## Webhook notifications

Alternatively, you can receive a push notification when a transaction changes status by setting up a webhook. VoPay will send a `POST` request to the endpoint you specify containing details of a transaction's status change.

`POST` `/account/webhook-url`

<!-- • client needs to provide us with their webhook url (/account/webhook-url) -->
To set up a webhook, you will need to provide the URL of the webhook.

| Parameter                 | Type      | Description |
|---------------------------|-----------|-------------|
| `WebHookUrl` | `string` | Endpoint where you want notifications sent. Must be a valid URL. |
  
<!-- • when transaction status changes, we send a notification to the webhook url -->
When a transaction changes status, you will receive the status change details as JSON in a `POST` request to the URL you provided.

<!-- • show what's in the webhook payload -->
The payload will match the following structure:

```json
{
  "Success": true,
  "TransactionType": "Interac Bulk Payout",
  "TransactionID": 46166,
  "TransactionAmount": "17887.00",
  "Status": "failed",
  "UpdatedAt": "2022-02-16 09:45:19",
  "ValidationKey": "ab18ccf2e3cebd5add2c3789f3cf8cb50679f70a",
  "FailureReason": "901 - NSF"
}
```

![](slate/img/HMACDiagram.jpg)

<!-- • explain validation key -->
The `ValidationKey` refers to the SHA1 hash of your API shared secret and the `TransactionID` in the payload. This serves a dual purpose of establishing the authenticity of the message (origin trust) and verifying the data integrity of the payload (content fidelity).

<!-- • show how they can test (/account/webhook-url-test) -->
To check if your webhook receiver is operational, send a `GET` request to `/account/webhook-url-test`. The `Success` field will be `true` (and `ErrorMessage` empty) if the data has been sent to your receiver.
