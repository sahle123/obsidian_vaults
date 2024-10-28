#cdn

# Idea and Motivation
#temp
* An area to write down current thoughts or process for some complex problem that is being worked on.
* This should be considered _cache_ and is entirely disposable unless I feel it is worthy of keeping as a record. e.g. steps on how to fix Pg 4 Admin's missing backup utility that seems to mysteriously disappear after an update.
# Scratchpad
## Onboarding & Performance Essentials
* DNS decision: will you be using CF as an authoritative server or a proxy for individual subdomains only?
	* Authoritative server --> full setup required.
	* Otherwise --> partial CNAME setup.
* Static Content
	* Caching static assets
		* No query string
		* Ignore query string
		* Standard (default)
	* Auto-minifying and polish
		* Auto minifies HTML and CSS
		* Minifies JS (N.B. that JS lines MUST have semi-colons after every relevant line.)
* Purging cache options
	* By URL
	* By hostname (enterprise only)
	* By tag (enterprise only)
	* By prefix (enterprise only)
	* Everything
* Cache analytics are only available up to (21 days) in Enterprise.
* Tiered caching used to smartly cache content in Cloudflare servers closer to the user's geographic region.