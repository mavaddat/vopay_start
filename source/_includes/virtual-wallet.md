## Virtual wallet

Each currency has its own distinct wallet, hence transactions of differing currencies will fund the wallet of that currency. Your funds are available for transactions when they are transferred from a bank account into your VoPay wallet.

| Currency | Wallet | Balance |
| --- | --- | --- |
| USD | ![A visual representation of the wallet for U.S. dollars](slate/img/usd_wallet.svg) | $700.00 |
| CAD | ![A visual representation of the wallet for Canadian dollars](slate/img/cad_wallet.svg) | $1300.00 |
| EUR | ![A visual representation of the wallet for Euros](slate/img/eur_wallet.svg) | €0.00 |
| GBP | ![A visual representation of the wallet for British pound sterling](slate/img/gbp_wallet.svg) | £0.00 |

<aside class="caution">
Balances always refer to specific funds for a distinct currency.
</aside>

<script defer type="text/javascript">
    document.querySelector("div.content > table:nth-child(6) > tbody > tr:nth-child(3) > td:nth-child(3)").innerText = `€${Math.floor( Math.random()*1000)}.00`;
    document.querySelector("div.content > table:nth-child(6) > tbody > tr:nth-child(4) > td:nth-child(3)").innerText = `£${Math.floor( Math.random()*1000)}.00`;
</script>
