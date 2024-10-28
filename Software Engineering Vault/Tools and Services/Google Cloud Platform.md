#gcp #cloud #csp

# GCP Certification
Most of the content in this section comes from [here](https://www.youtube.com/watch?v=UGRDM86MBIQ)
All credit for media goes to FreeCodeCamp and ExamPro unless otherwise stated.
## ORPHANS
* **Managed Instance Groups (MIGs)** - Service that one to allows automatically increase or decrease compute instances in response to demand or a defined schedule.
* You can use a Cloud DNS service to detect a failing primary system and have it fail-over to a stand-by secondary system.
* **FedRAMP** (Federal Risk and Authorization Management Program) is a US government-wide program that provides a standardized approach to security assessment, authorization, and continuous monitoring for cloud products and services.

Virtualization using containers
![[virtualization_containers.png]]
Virtualization using FaaS
![[virtualization_functions.png]]
<p style="text-align: center"><i>Credit: freeCodeCamp.org</i></p>

## Summary
### Certificates
* Foundational
	* Cloud Digital Leader
* Associate
	* Cloud Engineer
* Professional
	* Cloud Architect
	* Cloud Database Engineer
	* Cloud Developer
	* Cloud DevOps Engineer
	* Cloud Security Engineer
	* Cloud Network Engineer
	* Google Workspace Administrator
	* ML Engineer
### Resources
* The Cloud Girl (YouTube and website)
* [ExamPro](https://www.exampro.co/gcp-cdl)
## Cloud Concepts
* A _Cloud Service Provider_ (CSP) is a company which provides multiple Cloud Services, and those Cloud Services can be chained together to create cloud architectures.
* **Google Workspace** is a bundled offering of SaaS products for team communication, collaboration for an organization. Formerly called _G-suite_.
* _SaaS_ is for customers.
* _PaaS_ is for developers. (e.g. Elastic Beanstalk, Heroku, GCP App Engine).
* _IaaS_ is for admins/DevOps (the basic building blocks of cloud IT). Cloud service providers (e.g. AWS, Azure, GCP, Ali Baba Cloud, OCI, etc...) fall into this category.
### Benefits of Cloud Computing
_Cost-effective_
> You pay for what you consume; no up-front cost. On-demand pricing or pay-as-you-go (PAYG) with thousands of customers sharing the cost of the resources.

_Global_
> Launch workloads anywhere in the world--just choose a region.

_Secure_
> Cloud provider takes care of physical security. Cloud services can be secure by default or you have the ability to configure access down to a granular level.

_Reliable_
> Data backup, disaster recovery (DR), data replication, and fault tolerance.

_Scalable_
> Increase or decrease resources and services based on demand.

_Elastic_
> **Automate scaling** during spikes an drop on demand.
### Shared Responsibility
 
![[shared_responsibility_model.png]]
![[shared_responsibility_model_across_levels.png]]
![[shared_responsibility_model_across_levels2.png]]
<p style="text-align: center"><i>Credit: freeCodeCamp.org</i></p>

### Cloud Computing Deployment Models
* **Public Cloud**
> Everything is built on the cloud service provider; also called _Cloud-Native_.
> Sectors: Startups, SaaS offerings, New projects and companies.

* **Private Cloud**
> Everything is built on the company's datacenter; also called _On-Premise_. 
> This can be achieved using tools like OpenStack from Rackspace.
> Sectors: Governments, hospitals, health insurance, large enterprises with heavy regulations.

* **Hybrid**
> A mix of both private and public cloud.
> Sectors: Banks, FinTech, investment firms, legacy on-premise.
> * **Cloud Interconnect** is a GCP service that gives a direct physical connection between on-premise and GCP. There are _dedicated_ (10 to 200 Gbps) and _partner_ (50 Mbps to 10 Gbps). 
> * A partner offering goes through one of Google's trusted third-parties.
> * A dedicated offering goes through a co-location (also called carrier-hotel) facility (i.e. a datacenter where equipment, space, and bandwidth are available for rental to retail customers.)

* **Cross-Cloud**
> Not to be confused with Hybrid. This approach uses multiple cloud service providers in tandem. Sometimes it is also called multi-cloud or hybrid-cloud. Within GCP, using a service like **Anthos** allows ones to use compute services across multiple CSPs and on-premise environments.


## Global Infrastructure
The most up-to-date list of GCP's global locations can be found [here](https://cloud.google.com/about/locations/)

As of 2024, GCP's global infrastructure is as follows:
* 40 regions
* 121 zones
* 187 network edge locations
* 200+ countries

Inter-regional latency is approximately 500ms. Inter-zonal latency is approximately 10ms.

A **Folder** in GCP allows one to logically group multiple projects that share common IAM permissions. This is generally used to separate out departments in a business to keep permissions consistent and easily managed. It can also be used to separate out different environments (e.g. prod, staging, dev).

A **Project** in GCP is a logical grouping of resources (i.e. a namespace). A cloud resource must belong to a project. In order for a project to access another project's resources, it must be shared over a virtual private cloud (VPC) or with VPC network peering. Below are some notes regarding projects in GCP:
* Each project in GCP is given a: name, number, and ID.
* Each project ID in GCP is unique across Google Cloud. Note that when you delete a project, that project ID can never be reused.
* A project is made up of: settings, permissions, and other metadata.
* When billing is enabled, each project is associated with one billing account.
* Multiple projects can have their resource usage billed to the same account.

![[gcp_resource_hierarchy.png]]

### Definitions
**Regions**
> An independent geographic area that consists of _zones_.
> In general, a region has 3 zones.

**Zones**
> A physical location made up of one or more datacenters.
> A **datacenter** is a secured building that contains hundreds of thousands of computers.

**Network edge locations**
> **Points of Presence (PoP)** - an intermediate location between a GCP _region_ and the end-user. N.B. this location could be a third-party datacenter or collection of hardware.
> **Edge PoP** - a location where a user can quickly enter (ingress) the GCP network for accelerated access to cloud resources.
> **CDN PoP** - a location to serve (egress) cached websites, files, assets, so that they load fast for the end-user.
> **Cloud Media PoP** - a location specialized for delivery of media such as video content.

* 1 Region = 3 Zones
* 1 Zone = 1+ datacenters
* 1 datacenter = 1000+ computers
#### Resource Scoping
**Zonal resource**
> Resource resides in 1 zone in 1 region.

**Regional resource**
> Resource resides in 2+ zones in 1 region.

**Multi-regional resource**
> Resource resides in 2+ zones in 2+ regions.

**Global service**
> Resources reside globally and regions and zones are abstracted away.

**Internal services**
> Foundational services used by many other services. You do not interact with these services directly, they are managed by Google. e.g. Spanner, Colossus, Borg, Chubby.

### Data Residency
These are physical or geographical locations of where an organization or cloud resources reside. This is generally important for compliance and regulation reasons. Especially in countries like KSA.

**Assured Workloads**
> A feature in GCP that allows one to apply various security controls to an environment. Some features include:
> * Data residency --> You need an organizational policy called "Resource Location Restriction" and choose the allowed regions.
> * Personnel data access controls based on attributes.
> * Personnel support case ownership controls based on attributes.
> * Encryption.

## Digital Transformation
Digital transformation is defined as the adoption of digital technology to transform services or businesses through:
* Replacing non-digital or manual processes with digital processes (going paperless)
* Replacing older digital technology with new digital technology (adopting cloud technology)

At Google, they have 7 "solution pillars" for achieving digital transformation:
*  Infrastructure modernization
>Replacing legacy hardware and software systems with cloud solutions. This allows an organization to adopt hybrid architectures and have more infrastructure mobility choosing a mix of best cloud service provider offerings for their organization's use-case.
>**Anthos** allows management of on-premise and public cloud in a single unified interface.

* Business application platform portfolio
> The backbone of CSPs are built on-top of robust, well-documented APIs standardized across all offered cloud services. Organizations can focus on the configuration and interconnections of various systems instead of having to build their own systems.
> e.g. Cloud SDK, Cloud API, Cloud CLI, Google Cloud documentation

* Application modernization
> Building web-applications on-top of cloud services allows organizations to globally deliver and rapidly iterate faster than ever before. CSPs offer automated deployment pipelines, AI-powered code-reviews, easy staging, testing of new features, the ability to test in-production, and rollback changes. Apps are more durable and can remain available even when facing catastrophic regional failure.
> e.g. App Engine.

* Database and storage solutions
> Most companies can tolerate losing application code, you can always rewrite. Losing data is not something you can recover. CSPs have guaranteed SLAs of data durability, as well as the ability to easily migrate and secure your data.
> e.g. Cloud Storage. 99.5% availability SLA.

* Smart analytics
> When you store data on CSPs, you can tap into BigData and BI cloud offerings assisted by AI to help you analyze your data.
> e.g. Looker.

* AI
> AI, deep learning, ML are specialized domains that traditionally required scarce and expensive subject matter experts. Cloud is commoditizing, simplifying AI knowledge while driving costs lower for adoption.
> e.g. Vertex AI, TensorFlow.

* Security
> CSPs by default have strong mechanisms built in for security, governance, and compliance. CSPs are continually developing new and innovative security offerings not just as the service-per-service, but to analyze, recommend, and remediate at the project and organization level. You can easily and quickly audit and apply security controls to become compliant in a fraction of the time than an on-premise solution.
> e.g. IAM, BeyondCorp, Security Command Center.

**Innovation Waves (Kondratiev Waves)** are hypothesized cycle-like phenomena in the global world economy. This phenomenon is closely connect with technology life cycles.
![[kondratiev_waves.png]]
<p style="text-align: center"><i>Credit: freeCodeCamp.org</i></p>

**Burning Platform** is a term used when a company abandons old technology for new technology with the uncertainty of success and can be motivated by fear that the organization's future survival hinges on its digital transformation.

Types of computing power in GCP:
* General Computing - offered through Compute Engine. These are typical CPUs in some physical machine.
* Tensor Computing - offered through Cloud TPU. Specialized CPUs that work with TensorFlow and offer much, much higher throughput than using traditional CPUs.
* Quantum Computing - offered through Google Quantum AI. This field is still green and is constantly improving. Has the potential to be 100 million times more powerful than traditional CPUs.

## Google Cloud Adoption Framework
The "Google Cloud Adoption Framework" (GCAP) is a whitepaper that determines:
* an organizations readiness to adopt GCP
* the steps to fill in the knowledge gaps
* how to develop new competencies

The GCAP is composed of:
* 4 themes - Learn, Lead, Scale, Secure
* 3 _maturity_ phases - Tactical, Strategic, Transformational
* Cloud Maturity Scale - Matrix of themes and phases
* Epics - Workstreams to scope and structure cloud adoption
## Core Services
## More Services
## Migration Services
## AI/ML
## Security
## Identity
## Support
## Billing
## Pricing
## Resource Hierarchy
# Miscellaneous
### GSP281
#gcp #qwiklabs
* BigQuery is a fully-managed, petabyte-scale data warehouse that runs on GCP.
* Cloud SQL is for local hosting of DB engines like PostgreSQL , SQL Server, and MySQL.
### GSP921
#gcp #qwiklabs 
* SQLcommenter library.
### Google Cloud Armor bot management
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

