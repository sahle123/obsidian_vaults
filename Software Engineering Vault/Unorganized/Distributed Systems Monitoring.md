
[Google's SRE guide to monitoring distributed systems](https://sre.google/sre-book/monitoring-distributed-systems/)

## Site Reliability Engineer's 4 Golden Rules
#google
* Latency - Slow requests.
* Traffic - Throughput; how many requests in a timeframe.
* Saturation - Capacity; how over/under-used a resource is.
* Errors - Bad requests; the rate of requests that fail.
## Monitoring tools
* [New Relic](https://newrelic.com)
	* Suite of distributed monitoring tools: APM, log monitoring, infra monitoring, real-user monitoring, alerts, etc...
	* Generally considered easier to use compared to other, similar tools.
	* SAAS
* [Prometheus](https://prometheus.io/)
	* Time-series-based distributed monitoring.
	* FOSS
* [Data Dog](https://www.datadoghq.com/)
	* Similar to New Relic, but has more granular control and has Cloud SIEM.
	* Generally agreed to be more difficult to use compared to New Relic.
	* SAAS
