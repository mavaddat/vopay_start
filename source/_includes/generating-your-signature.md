### Generating your signature

You will need to compute a signature from your VoPay credentials to authenticate every request you make.

<aside class="notice">
Because producing the signature requires digesting the date, you need to re-calculate it each day. This <strong>daily signature</strong> will be a <em>method output</em> rather than a <em>static constant</em> in your solution.
</aside>

By example, here is a shared secret and an API key with a current date:

<div class="example-container">
    <code class="example-container above">
        <span>
            <img src="https://cdn.glitch.global/576f7a6a-1333-4479-915b-925c8ad0247a/apikey.svg?v=1644377138320" />
        </span>
        <span></span>
        <span>
            <img src="https://cdn.glitch.global/576f7a6a-1333-4479-915b-925c8ad0247a/formatteddate.svg?v=1644378064628" />
        </span>
    </code>
    <code class="strexample">
        <span id="key">3da541559918a808c2402bba5012f6c60b27661c</span>
        <span id="secret">OTEyZWM4MDNiMmNINDk=</span>
        <span id="date">2022-02-08</span>
    </code>
    <code class="example-container below">
        <span></span>
        <span>
            <img src="https://cdn.glitch.global/576f7a6a-1333-4479-915b-925c8ad0247a/sharedsecret.svg?v=164437805863" />
        </span>
        <span></span>
    </code>
</div>

Hashing the above string will produce the following signature:

| Algorithm | Hash                                       |
|-----------|--------------------------------------------|
| SHA1      | <code id="signature">f69fe6fbd81b9008fbcc0ebdac5fc7a47e3beacf</code> |

<aside class="test">
See if you are able to reproduce the signature above using the code sample in your preferred language.
</aside>

> SHA1 hash of the key, shared secret, formatted date ⇾ signature

```powershell
# $KEY = "3da541559918a808c2402bba5012f6c60b27661c"
# $SECRET = "OTEyZWM4MDNiMmNINDk="
$AccountID = "alice.smith"
# Securely read the credentials from the user
$Credentials = @{};
foreach($cred in @("Key","Shared Secret")){
    $Credentials.Add( $cred, (Get-Credential -Message $cred -Title "VoPay Credentials" -UserName $AccountId) )
}
$FormattedDate = Get-Date -Format "yyyy-MM-dd"
# $PreSig = $KEY + $SECRET + $FormattedDate
$PreSig = ($Credentials.Key.Password | ConvertFrom-SecureString -AsPlainText) + ($Credentials.'Shared Secret'.Password | ConvertFrom-SecureString -AsPlainText) + $FormattedDate
<# Now perform a SHA1 cryptographic hash #>
# First convert the concatenated string into a binary representation.
$PreSigChars = $PreSig.ToCharArray()
$PreSigBytes = $PreSigChars | ForEach-Object { [System.Convert]::ToByte($_) }
$PreSigStream = [IO.MemoryStream]::new($PreSigBytes)
# Then, you pass that to a hashing function.
$Hash = Get-FileHash -InputStream $PreSigStream -Algorithm SHA1
$Signature = $Hash.Hash.ToLowerInvariant()
```

```shell
# readonly KEY="3da541559918a808c2402bba5012f6c60b27661c"
# readonly SECRET="OTEyZWM4MDNiMmNINDk="
readonly ACCOUNT_ID="alice.smith"
# Securely read the credentials from the user
readonly KEY=$(pass "$ACCOUNT_ID:key")
readonly SECRET=$(pass "$ACCOUNT_ID:secret")
# Format the date
formatted_date=$(date +%Y-%m-%d)
signature=$(echo -n $KEY$SECRET$formatted_date | sha1sum | awk '{print $1}')
```

```python
# KEY = "3da541559918a808c2402bba5012f6c60b27661c"
# SECRET = "OTEyZWM4MDNiMmNINDk="
ACCOUNT_ID = "alice.smith"
# Securely read the credentials from the user
KEY = getpass("Enter your VoPay API key: ")
SECRET = getpass("Enter your VoPay shared secret: ")
formatted_date = datetime.datetime.now().strftime("%Y-%m-%d")
pre_sig = KEY + SECRET + formatted_date
signature = hashlib.sha1(pre_sig.encode('utf-8')).hexdigest() # import hashlib
```

```javascript
const KEY = "3da541559918a808c2402bba5012f6c60b27661c"
const SECRET = "OTEyZWM4MDNiMmNINDk="
const ACCOUNT_ID = "alice.smith"
var formattedDate = new Date().toISOString().slice(0,10)
var preSig = KEY + SECRET + formattedDate
var signature = crypto.createHash('sha1').update(preSig).digest('hex')
```

```ruby
KEY = "3da541559918a808c2402bba5012f6c60b27661c"
SECRET = "OTEyZWM4MDNiMmNINDk="
ACCOUNT_ID = "alice.smith"
formatted_date = Date.today.strftime("%Y-%m-%d")
pre_sig = KEY + SECRET + formatted_date
signature = Digest::SHA1.hexdigest(pre_sig)
```

```php
$KEY = "3da541559918a808c2402bba5012f6c60b27661c"
$SECRET = "OTEyZWM4MDNiMmNINDk="
$ACCOUNT_ID = "alice.smith"
$formattedDate = date("Y-m-d")
$preSig = $KEY + $SECRET + $formattedDate
signature = hash('sha1', preSig)
```

```csharp
// Using statements, class setup, main function omitted for brevity
const KEY = "3da541559918a808c2402bba5012f6c60b27661c"
const SECRET = "OTEyZWM4MDNiMmNINDk="
const ACCOUNT_ID = "alice.smith"
// See note on secure strings: https://github.com/dotnet/platform-compat/blob/master/docs/DE0001.md
var formatted_date = DateTime.Now.ToString("yyyy-MM-dd")
var preSig = KEY + SECRET + formatted_date
var signature = SHA1.Create().ComputeHash(Encoding.UTF8.GetBytes(preSig)).ToHexString();
```

```java
// Import statements, class setup, main function omitted for brevity
static final String KEY = "3da541559918a808c2402bba5012f6c60b27661c";
static final String SECRET = "OTEyZWM4MDNiMmNINDk=";
String formattedDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());  // import java.text.SimpleDateFormat
String preSig = KEY + SECRET + formattedDate;
String signature = MessageDigest.getInstance("SHA-1").digest(preSig.getBytes("UTF-8")).toHexString();  // import java.security.MessageDigest;
```

```go
// Import statements and main function omitted for brevity
const KEY = "3da541559918a808c2402bba5012f6c60b27661c"
const SECRET = "OTEyZWM4MDNiMmNINDk="
var formatted_date = time.Now().Format("2006-01-02")
var pre_sig = KEY + SECRET + formatted_date
var signature = fmt.Sprintf("%x", sha1.Sum([]byte(pre_sig)))  // import "crypto/sha1"
```

[Later](#Checking-your-VoPay-balance){.decoratenone}, you will use the signature to receive sandbox data from VoPay.
