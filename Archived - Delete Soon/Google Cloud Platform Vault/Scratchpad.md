#temp #experiment #unorganized

[In honor of trying out this](https://fev.al/posts/work-journal/) 
[Further discussion can be found here](https://news.ycombinator.com/item?id=40950584)

# Idea and Motivation
* An area to write down current thoughts or process for some complex problem that is being worked on.
* This should be considered _cache_ and is entirely disposable unless I feel it is worthy of keeping as a record. e.g. steps on how to fix Pg 4 Admin's missing backup utility that seems to mysteriously disappear after an update.

# GSP281
#gcp #qwiklabs

* BigQuery is a fully-managed, petabyte-scale data warehouse that runs on GCP.
* Cloud SQL is for local hosting of DB engines like PostgreSQL , SQL Server, and MySQL.

# GSP921
#gcp #qwiklabs 

* SQLcommenter library.

# Google Cloud Armor bot management
#gcp #cybersecurity #cloud
* Based on [this](https://cloud.google.com/armor/docs/bot-management)article.
* Includes manual challenge (reCAPTCHA challenge page).
* Enforce reCAPTCHA frictionless assessment.
* Creating a reCAPTCHA WAF site key and associating it with your security policy allows you to see reCAPTCHA metrics. Otherwise, a Google-managed site key will be created, but you will not be able to view any metrics. More info found [here](https://cloud.google.com/recaptcha/docs/implement-waf-ca#redirect)
* Knowing when to choose between _action-tokens_ and _sessions-tokens_ is important. More reading found [here](https://cloud.google.com/recaptcha/docs/waf-features).
* Use cases to distinguish between legit users and automated clients:
	* _Manual challenge_.
	* Using Google Cloud armor to enforce and evaluate reCAPTCHA tokens so your backends are not involved in deciphering the token.
	* Redirect (302 responses).
	* Decorate requests with custom headers (static, user-defined values) before proxying to your backend application(s).
		* Good for honey-potting, additional analysis, monitoring.

