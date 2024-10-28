### Consistent Hashing
#fill-in-later

### How to handle high traffic e-Commerce inventory check?
#fill-in-later 
* This is current a problem faced within DZRT 1.0.

### "CORS is stupid"
[This section was a summary of this article by Kevin Cox](https://kevincox.ca/2024/08/24/cors/?ref=dailydev)

* CORS and `same-origin` policy work in tandem with each other and should be considered a system together. You cannot use one without the other.
	* If a request comes from a different origin, CORS rules are applied.
* Any website that uses cookies MUST have CORS configured.
* CORS mitigates cross-site request forgeries (XSRF) attacks.
* Default CORS allows making of requests, but results cannot be read.
* One must stop all implicit creds on cross-origin request, then add all as needed one by one.
* `sec-fetch-*` headers can be used for checking security headers, even over TLS or HTTP auth. (Check this fact.)
* CORS is not about blocking access, but about preventing accidental reuse of implicit credentials.
* Further reading: Firefox (state partitioning), Google (CHIPS), and Safari (tracking prevention).