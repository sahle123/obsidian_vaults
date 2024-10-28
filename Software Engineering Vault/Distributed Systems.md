#distributed-systems
# Disclaimer
All this work are study notes taken by Sahal A. Alturaigi and is derived from many sources. However, unless otherwise stated, all diagrams are credited to __Educative.io__ since the bulk of these notes uses their content as a primary resource/reference.
# Summary
* _n-tier applications_ are also called distributed systems.
* _Layers_ represent conceptual/logical organization of the code (e.g. UI layer, DAL, business logic, service layer).
* _Tiers_ represent the logical/physical separation of components (e.g. database, app, UI, messaging, caching).

# Distributed System Components

## Summary
Below are the common components in a distributed system and each has a vital job to do. These are **building blocks of any modern distributed system**.

1. __Domain Name System (DNS)__ - Needed for mapping names to systems in a network or the internet. This building block focuses on how to design hierarchical and distributed naming systems for computers connected to the internet via different protocols.

2. __Load Balancer__
	* Used to fairly distribute client traffic among a pool of servers. It can also be used to reduce loads or bypass failed servers.
	* Generally, clusters of load balancers are deployed to remove a single point of failure in the system architecture.
	* Load balancing can exist both globally (distribution among different regions) and locally (distribution within a data center).
	* Services offered by load balancers:
		1. Health checking via the heartbeat protocol.
		2. TLS/SSL termination (just like any other proxy).
		3. Predictive analytics by way of all the traffic passing through them.
		4. Reduced human intervention since LBs are automated.
		5. Service discovery. LB can forward clients' request to appropriate hosting servers by inquiring about the _service registry_ (i.e. the repo of services/microservices and instances available of each one).
		6. Improve security by mitigating attacks like DoS at different layers of the OSI model (layers 3, 4, and 7).
	* E.g. 3-tier load balancing: ![[media/3_tier_loadbalancing.PNG]]
			<p style="text-align: center"><i>Credit: Educative.io</i></p>
	* Load balancer tiers:
		1. Tier-0 and Tier-1 LBs
			* DNS can be considered the tier-0 LBs.
			* _Equal Cost Multipath (ECMP) routers_ are the tier-1 LBs. ECMP routers are vital in the horizontal scaling of higher-tier LBs.
		2. Tier-2 LBs
			* These are the OSI layer 4 LBs.
			* Tier-2 LBs make sure that for any connection, all incoming packets are forwarded to the same tier-3 LBs. To achieve this goal, techniques like _consistent hashing_ are used (until there is an infrastructure change).
			* Tier-2 LBs can be thought of as like the glue between tier-1 and tier-3.
		3. Tier-3 LBs
			* LBs that are in direct contact w/ the backend servers. They work in layer 7.
			* Tier-3 LBs perform health monitoring of servers at an HTTP level.
			* They also handle low-level details like TCP-congestion control protocols, the discovery of Path MTU, and the difference in application protocol between client and backend server. Any trivial task that can be off-loaded from the backend server will typically be put here in the tier-3 LBs.
			* Tier-3 LBs also maintain the state of the pool of application servers they are connected to.

3. __Databases__ - Where we keep persisted data or reading, writing, updating, etc...

4. __Key-Value Store__ - Non-relational databases that store data in the form of key-value pairs. _DEV-NOTE: This section needs to be expanded on more._ #fill-in-later

5. __Content Delivery Network (CDN)__ - Used to efficiently deliver content to end users by reducing latency and burdens on data centers. CDNs exist all over the world and content needs to be put on them and served to clients. Works somewhat like a huge, geographical distributed caching system. There are _pull_ and _push_ CDNs. The former fetches content as needed, the later is given by the origin server.

6. __Sequencer__
	* A unique ID generator with a major focus on maintaining causality. It also explains 3 different methods of generating unique IDs.
	* This is especially important for distributed database systems where every database my generate their own primary keys. Without sequencers, conflicts can manifest.
	* The three ways of generating unique IDs are: using a _UUID_, using a _database_, and using a _range handler_.
	* _Range handlers_ take the best of both _UUID_ and the _database_ approaches.
	* Typical requirements for unique identifiers are:
		* Deterministically unique.
		* Able to generate 10^9 IDs per days.
		* Extremely available. ID generation happens at the nanoseconds level.
		* 64 bit length for identifiers.
	* Some other types of sequencers include:
		* _Unix timestamp + server ID approach_.
		* _Twitter Snowflake_.
		* _Logical Clocks_ (i.e. Lamport clocks, vector clocks).
		* _Google Spanner TrueTime API_.
	* Approach breakdown: ![[media/sequencer_approaches.PNG]]
		<p style="text-align: center"><i>Credit: Educative.io</i></p>

7. __Service Monitoring__ - A monitoring system across the whole distributed system. Vital in order to tackle problems early or find them out in the vast, complicated mire of connected services and resources. Generally, there are two kinds of monitoring systems: server-side, client-side.

8. __Distributed Caching__ - A distributed caching system where multiple cache servers coordinate to store frequently accessed data. _DEV-NOTE: How does this compare to a CDN?_

9. __Distributed Messaging Queue__
	* Queuing servers which are between interacting entities: producers and consumers. It decouples producers and consumers which results in independent scalability.
	* Producers produce some message that needs to be processed. Consumers process those messages.
	* The goal here is to achieve async communication and decoupled services.
	* FIFO orderings used are
		* Best effort ordering (e.g. use for email)
		* Strict ordering (e.g. use for chat messaging like WhatsApp)
	* Use cases:
		* Sending out many emails
		* Data post-processing
		* Recommender systems
		* Anytime we have a DS where a message needs to be processed by just one consumer in FIFO ordering.
	* Considerations when designing one:
		1. Order of messages
			* Best-effort ordering
				* Queue pops out messages in the order that they arrive in the queue.
				* Easy to implement
				* Use case: Email
			* Strict ordering
				* Messages are assigned time stamps based on synced clocks.
				* Difficult to implement. An ordering mechanism is required.
				* Use case: Chat messaging (WhatsApp)
		2. The effect of the ordering of messages
		3. Management of concurrent access to the queue.

10. __Publish-Subscribe System (Pub-sub)__
	* Focuses on asynchronous service-to-service communication. Useful for serverless, microservice, and data processing architectures/systems.
	* N.B. that Pub/Sub systems are built on top of messaging queues.
	* Works similar to message queues, but multiple consumers can take the same message.
	* Publishers do not know which consumers read their messages. (DEV-NOTE: double check this fact.)
	* Compared to messaging queues, consumer latency does not affect the system.
	* Use cases:
		* Social media subscribe platforms
		* Email groups or mailing lists
	* Rudimentary architecture for Pub/Sub: ![[media/PubSub_Archi.PNG]]
		<p style="text-align: center"><i>Credit: Educative.io</i></p>
	* Modern architecture for Pub/Sub: ![[./media/PubSub_Modern_Archi.PNG]]
		<div style="text-align: center"><i>Credit: Educative.io</i></div>

11. __Rate Limiter__
	* A system that throttles incoming requests for a service based on the predefined limit. Generally a defensive layer to prevent DDoSes or random power-users.
	* Types of throttling:
		* _Hard throttling_ - Hard limit and no more.
		* _Soft throttling_ - Limit with a small buffer. e.g. 5% of limit buffer.
		* _Elastic throttling_ - If excess resources are available, the predefined limit can be exceeded.
	* Within the Linux OS, `cgroups` are used to separate out and limit resources used on processes.
	* Rate limiters can be placed either client-side (bad), server-side (good), or as middleware (good). Note that many API endpoints are good places to add rate limiters.
	* There are two models for implementing a rate limiter:
		1. Rate limiter w/ a centralized database. Using something like Redis or Cassandra, counters are stored in a centralized database. Easy to implement, however can start to fail when there is an enormous number of requests in a short period. Moreover, for highly concurrent requests, race conditions can occur (or associated lock contentions).
		2. Rate limiter w/ a distributed database. In this approach each node has to track the rate limit. The issue is that a client could exceed momentarily exceed the rate limit. To enforce this, sticky sessions in the load balancer must be set so consumers are sent to exactly one node. However, this approach lacks fault tolerance and poses scaling problems.
	* Rate limiter algorithms:
		* Token Bucket
		* Leaking Bucket
		* Fixed Window Counter
		* Sliding Window Log
		* Sliding Window Counter

12. __Blob Store (Distributed Storage)__ - Where unstructured data is persisted. Used primarily for multimedia files or binary executables. Blob = Binary Large OBject.

13. __Distributed Search__ - _DEV-NOTE: fill in later..._ #fill-in-later

14. __Distributed Logging/Monitoring__ - A logger that works on a distributed system for capturing all I/O intensive operations. In distributed monitoring, there is _client-side monitoring_, _server-side monitoring_ , and _distributed logging_.

15. __Distributed Task Scheduling__
	* A critical component of a DS for getting work done efficiently, reliably, and with an uninterrupted execution experience.
	* Common components used in a task scheduler are:
		* Rate limiters
		* Sequencers (for idempotence and keeping track of task IDs)
		* RDBS (for storing pending or routine tasks).
		* A distributed queue (for message passing tasks to resources)
		* Monitoring (for health checks and detecting failures/malicious tasks)
	* Tasks are generally put into 1 of 3 groups:
		* Urgent tasks
		* Can-be-delayed tasks
		* Periodic tasks
	* Task scheduling is needed in any distributed systems that needs to efficiently use its hardware to the maximum.
	* Task scheduler architecture: ![[media/task_scheduler_archi.PNG]]
		<p style="text-align: center"><i>Credit: Educative.io</i></p>

16. __Shared Counters__ 
	* Also called a distributed counter.
	* Useful in situations like social media where 1000s of concurrent likes are happening on a single or group of posts.
	* #fill-in-later

## Blob Storage
### Summary
A storage solution for unstructured data. Used to store all sorts of large binary objects like multimedia, photos, videos, binary executables, etc... This type of storage follows a flat data organization pattern where there are no hierarchies, that is, directories, sub-directories, and so on. This is mostly used in applications with a particular business requirement called _write once, read many (WORM)_. YouTube has much _WORM_ type data.
### Non-functional Requirements
* _Availability_
* _Durability_ - once the blob is uploaded, the data should not be lost unless explicitly deleted by the user.
* _Scalability_
* _Throughput_ - for transferring gigabytes of data, we should ensure a high data throughput.
* _Reliability_ - the design should detect and recover from failures promptly since this is a common event in distributed systems.
* _Consistency_
### Blob storage architecture
![[blobstore_architecture.png]]
<p style="text-align: center"><i>Credit: Educative.io</i></p>

## Content Delivery Networks (CDN)
### Summary
A CDN can be thought of as a group of geographically distributed proxy servers. The motivation behind a CDN is the following:
* Reduce latency between server and end-user by being geographically closer to the end-user.
* Reduce load on the origin server by serving common static (cached) and dynamic content to end-users.
* Serve as another security layer (especially against bot attacks or DDoS).

Popular CDNs include:
* Akamai
* Cloudflare
* StackPath
* Rackspace
* Amazon CloudFront
* Google Cloud CDN

CDNs typically use the following building distributed system building blocks: DNS servers and load balancers.
### CDN components
* _Clients_ - end-users like browsers, mobile phones, etc...
* _Routing System_ - a routing system that directs clients to the nearest CDN facility.
* _Scrubber Servers_ - servers that are used to separate out the good traffic from the malicious traffic and protected against well-known attacks. These are typically only used during an attack.
* _Proxy Servers_ - the proxy or edge proxy servers serve the content from RAM to the users. Hot data stored in RAM, cold data on disk/SSD.
* _Distribution System_ - this is responsible for distributing all content to all the edge proxy servers to different CDN facilities.
* _Origin Servers_ - the origin server serves any unavailable data at the CDN to clients. The CDN infrastructure facilitates users with data received from the origin server.
* _Management System_ - this handles business/managerial aspects of the CDN such as resource usage, CDN statistics, client usage and billing information, etc...

![[cdn_components.png]]
<p style="text-align: center"><i>Credit: Educative.io</i></p>

## Databases
#database #storage
### Database Types
* Databases are typically fall into either two categories: SQL vs. NoSQL.
* _SQL_ are relational (structured) whilst _NoSQL_ are semi- or un-structured.
* NoSQL databases fall into four subcategories: (along w/ their use case(s))
    * _Key-value store_ - efficient for session-oriented applications. e.g. web-app user sessions.
    * _Document_ - suitable for unstructured catalog data. e.g. blog posts, products with 1000s of attributes.
    * _Column-oriented/Columnar_ - efficient for data analytics are in applications that require large number of table aggregations.
    * _Graph_ - great for social applications where relationships between entities is vital.
### Data Replication
* Single-Master Replication (aka. primary-secondary replication)
* Multi-Master Replication
* Peer-to-peer Replication
* Quorums
### Data Partitioning (Sharding)
* _Vertical Sharding_
	* Database is broken up by its tables (or even columns within a table) into different, separate database instances.
	* Must be mindful of joins between multiple tables.
	* Used to increase speed of data retrieval from columns consisting of large text or binary large object (blob) data.
	* Vertical shard schemas cannot be done dynamically. (Not done dynamically easily?)

* _Horizontal Sharding_
	* Sharding where partitions are done row-wise instead of column-wise.
	* There are two types of horizontal sharding strategies: _Key-range based_ and _Hash-based_
	* For _hash-based sharding_ the topic of rebalancing partitions is an important consideration. Some approaches are as follows:
		* Fixed number of partitions
		* Dynamic partitioning
		* Partition proportionally to nodes
	* Secondary indexes in horizontal partitions is an important topic to improve read performance (especially for hash-based sharding). Some options are as follows:
		* Partition secondary indexes by document
		* Partition secondary indexes by term (term being the column we are partitioning by)
* Use cases:
	* When users exist in many different regions and are generally isolated from each other.
### Distribution Transparency
* Distribution Transparency is the property of distributed databases that helps the user recognize the database as a single logical entity. There are 3 levels of distribution transparency:
	1. _Location Transparency_ - User can query any table or shard as if they were stored locally on the user's site.
	2. _Partition Transparency_ - User can query any table as if it were unpartitioned.
	3. _Replication Transparency_ - User can query tables (especially during write ops) as if only a single copy of the table exists.  
### CAP Theorem
* Fundamental theorem in distributed systems and outlines the trade-offs in the design of distributed systems.
* There are 3 properties and only 2 of them can be enforced while the other is lost:
	* _Consistency_ - means that every successful read request receives the result of the most recent write request.
	* _Availability_ - means that every request receives a non-error response, without any guarantees on whether it reflects the most recent write request.
	* _Partition Tolerance_ - means the system can continue to operate despite an arbitrary number of messages being dropped by the network between nodes due to a network partition.
* Partition Tolerance is a property that cannot be compromised in distributed systems. Therefore, when a network partition failure occurs, we must decided whether we should aim for data consistency or data availability.
	* So truly, we have two choices in a DS: the DS will either be _consistent_ or _available_ in the event of a network partition.
	* When the network is not present, we have both availability an consistency.
### PACELC Theorem
* Builds on CAP theorem.
* Follows the same rules as CAP theorem within a partitioned network, but adds how the system operates normally in the absence of a network.
* Within CAP, we have AP (available/partition tolerant) and CP (consistent/partition tolerant).
* In PACELC, we also have EL (else latency) or EC (else consistency).
* Therefore, he are the following permutations:
	* AP/EL
	* AP/EC
	* CP/EL
	* CP/EC
* Most systems fall under AP/EL (when we need speed) or CP/EC (when we need consistency and integrity).
## Distributed Caching
#database #caching
### Summary
A distributed cache is a caching system where multiple cache servers coordinate to store frequently accessed data. Caches are generally small, frequently accessed, short-term storage with fast read time. This is due to the fact that data is typically stored on RAM which is orders of magnitude faster than disk, but is volatile (i.e., non-persistent) storage. Caches use _locality of reference_ principle. (i.e., spatial or temporal locality).

Considerations for distributed caching:
1. Writing Policies
	* Write-through cache (both RAM + disk)
	* Write-around cache (disk --> RAM)
	* Write-back cache (RAM --> disk)
2. Eviction Policies
3. Cache Invalidation
	* Active (daemon/thread) expiration TTL
	* Passive (time of access) expiration TTL
4. Storage Mechanisms
	* What data to store in which servers?
	* What data structure to use for storage?
5. Cache Client
### Memcached vs. Redis
* Memcached:
	* Made in 2003.
	* Key-value store that keeps values + keys as strings. This requires serializing/deserializing.
	* Client-server model.
	* Each server follows the _shared-nothing architecture_. i.e. servers are unaware of each other, no synchronization, data sharing, and communication between the servers.
	* Has almost deterministic O(1) query speeds due to its disconnected design.
	* User for simpler, read-heavy systems.
* Redis:
	* Made in 2009.
	* Client-server model.
		* Uses pipelining to reduce the number of RTT (round-trip-time) spans for multiple requests.
	* Supports multiple data structures, not just key-value pairs.
	* Can persist in-memory blocks on secondary storage.
	* Is asynchronous (message brokering) and therefore less consistent.
	* Understands Memcached protocols and is fully compatible with it.
	* Separates out _data access_ from _cluster management_.
	* Use for complex read/write heavy.
	* ![[memcached_vs_redis.png]]
	<p style="text-align: center"><i>Credit: Educative.io</i></p>
## Distributed Monitoring
#### Summary
In distributed monitoring, there is 
* client-side monitoring
* server-side monitoring
* distributed logging

#### Distributed Logging
Below is an example of a distributed logging system that is horizontally scalable.
![[distributed_logging.png]]
	<p style="text-align: center"><i>Credit: Educative.io</i></p>

#### Client-side monitoring
Since client-side errors do not necessarily show up in the infrastructure, it can be hard to track without taking some extra steps. Tracking client-side error is still vital since things like BGP leaks and 4XX errors can be detected and acted upon which would otherwise show nothing at all in our server-side monitoring system. One method suggested for handling this is using probes near where users are (i.e., a computer or web browser we control that imitates a users and sends diagnostic reports.)
#### Server-side monitoring
There are pull-based (fetching data) and push-based (listening for data) monitoring systems. Generally, some combination of the two are used in tandem for a monitoring system. Push-based systems are good for critical/urgent information that needs to be acted on immediately (i.e., alerting, automatic action). Pull-based monitoring systems can be good for larger work that does not need to be done often and is not considered critical/urgent. It is a balancing act in using both systems to minimize network congestion caused by metric data getting sent over the wire. Both of the potential to positively and negatively affect the network.

Here is an example of a hierarchy of systems for scaling a pull-based monitoring system.
![[serverside_pull_monitoring.png]]
	<p style="text-align: center"><i>Credit: Educative.io</i></p>

#### Questions on how to monitor server-side errors
Hello! I’m Ed, your AI mentor. Today, we’re going to revise some concepts related to System Design, specifically focusing on designing a server-side monitoring system. Let’s start with the first part of your revision.

Can you briefly describe how data collection works in a pull-based monitoring system?

SAL
A pull-based monitoring system fetches data (metrics) as needed. Because we are only fetching the metrics we want ad-hoc or at certain intervals, this greatly reduces the network congestion, but also makes us less likely to respond on-time.

Your description captures the essence of a pull-based monitoring system, focusing on the system fetching metrics as needed, which is correct. However, the point about reducing network congestion is more nuanced, as pull-based systems can actually lead to potential network congestion and scalability issues, especially when scaling up, due to the centralized system making multiple requests to many servers.

Now, could you briefly describe how data collection works in a push-based monitoring system? 

SAL
A push-based monitoring system is always feeding data to some centralized location where it can be stored, aggregated, or pushed upwards in the monitoring hierarchy. Since data is always being pushed over the network, this has the potential to lead to network congestion; especially when scaling up.

You’ve provided a good explanation of a push-based monitoring system, highlighting the continuous data feed to a centralized location for further processing. Your mention of the potential for network congestion, especially when scaling up, is also a valid point, as it reflects the challenges associated with managing the volume of data being pushed from numerous sources. Let’s move on to the second part of your revision.

Considering you’re adding 500 new servers to your monitoring system, discuss the potential implications of this change in a scenario where your system uses a purely pull-based approach.

SAL
I think there are many other questions we need answers for before we can answer this question properly. For instance, in our pull-based approach, how is the network hierarchy setup and how often does data need to be pulled? I’ll make a lot of assumptions here but we need to maybe consider how these 500 new servers are related to each other. Any similarities we might have between them could be grouped together. From there that group will have a centralized location where data is aggregated. Each one of these centralized locations could be pulled from by higher-level centralized location that aggregates all of the other ones. Depending on the groupings we decided on, we may have only 1 tier or multiple tiers of monitoring aggregators. If we could not take this tiered approach, depending on our network bandwidth, we would have to schedule each server that we intended to pull data from in some sort of order to prevent network congestion.

You’ve brought up several important considerations regarding the setup and management of a pull-based monitoring system, especially in the context of scaling up with 500 new servers. Your focus on the potential for network hierarchy, data aggregation, and the scheduling of data pulls to prevent network congestion touches on key aspects of managing scalability and efficiency in such systems. However, the core implication of adding 500 new servers to a pull-based system is the increased load on the central monitoring system due to the need to initiate requests to each of these new servers periodically. This can lead to potential network congestion and scalability issues, as the monitoring system needs to manage a significantly larger volume of requests within the same time frames.

Now, let’s consider the other scenario. Discuss the potential implications of adding 500 new servers to your monitoring system in a scenario where your system uses a purely push-based approach.

SAL
Without repeating anything I said in my last answer, one improvement is that any monitoring service or server no longer needs to initiate any requests for fetching data. This has the potential to reduce network congestion, but if the volume of data is pushed to centralized monitoring servers too frequently, the opposite effect might happen. Another nice benefit of a push-based approach is we will get our data in a timely manner. This can be especially useful for alerts or any critical or high-priority metrics that require immediate action.

You’ve correctly identified key aspects of transitioning to a push-based monitoring system with the addition of 500 new servers. Highlighting the shift from initiating requests for data to receiving data pushed from the servers themselves addresses a fundamental change in the system’s operation. You’ve also pointed out the potential for both reduced and increased network congestion, depending on the volume and frequency of the data being pushed, which is an important consideration for scalability and performance. Moreover, your mention of the timeliness of data reception in a push-based system, which facilitates more immediate responses to critical metrics and alerts, captures one of the significant advantages of this approach, especially in large-scale environments. Both scenarios you’ve discussed for pull-based and push-based systems reflect thoughtful consideration of the implications of scaling up monitoring capabilities. Well done!

## Distributed Search
-- Give short description here. #fill-in-later 
### Search System Components
* __Crawler__ - fetches content and creates a _document_. A document is text extract from a web page and is formatted (e.g., JSON).
* __Indexer__ - builds a searchable index.
* __Searcher__ - responds to search queries by running the search query on the _index_ created by the _indexer_.
![[search_system.png]]
	<p style="text-align: center"><i>Credit: Educative.io</i></p>
### Searchable Index
To build a searchable index that is scalable, an __inverted index__ is used that employs a __document-term matrix__. Instead of storing complete documents, it is split into individual words where frequently occurring words (terms) like "to", "the", "is", etc... are discarded and unique ones are stored. The document-term matrix maintains a term-level index through this identification of unique words and deletion of unnecessary terms.

For each term, the index computes the following information:
* The list of documents in which the term appeared.
* The frequency with which the term appears in each document.
* The position of the term in each document.

Inverted index is one of the most popular index mechanisms used in document retrieval. It enables efficient implementation of boolean, extended boolean, proximity, relevance, and many other types of search algorithms.

Below is a high-level overview of the distributed search process.
![[distributed_searching.png]]
	<p style="text-align: center"><i>Credit: Educative.io</i></p>	
Generally speaking for distributed storage, a replication factor of 3 is enough. 

### MapReduce
Below is a diagram for MapReduce
![[mapreduce_diagram.png]]
	<p style="text-align: center"><i>Credit: Educative.io</i></p>	

## Key-value Stores
#database #nosql 
#### Summary
Key-value stores are distributed hash tables (DHTs). A key is generated by a hash function and should be unique (collisions are really bad). In a key-value store, a key binds to a specific value and doesn't assume anything about the structure of the value. It can be a blob, an image, text; virtually anything.

Key-value stores are great for storing user sessions and building NoSQL-like databases.
#### Functional Requirements
* **Configurable service**: some applications might have a tendency to trade strong consistency for higher availability. We need to provide a configurable service so that different applications could use a range of consistency models.
* **Ability to always write**: The applications should always have the ability to write into the key-value storage. If the user wants strong consistency, this requirement might not always be fulfilled due to the implications of CAP theorem.
* **Hardware heterogeneity**: We want to add new servers with different and higher capacities, seamlessly, to our cluster without changing or upgrading existing servers. Our system should be able to accommodate and leverage different capacity servers, ensuring correct core functionality (e.g., GET and PUT data) while balancing the workload distribution according to each server's capacity. This calls for a peer-to-peer design with no distinguished nodes.
#### Scaling key-value stores
The ability to always write is a requirement for key-value stores. Since this system is highly available, consistency is usually an issue. Two common problems when scaling up key-value stores are data replication and data versioning. For replication, peer-to-per networks with consistent hashing quorums are generally used. For versioning, causality between objects needs to be retained. This can be achieved via **vector clocks** (node, counter) which can show a causal relationship between any two objects. Merkle trees can be used to handle permanent error scenarios.

## Shared Counter
### Summary
Also called _distributed counters_. Simply put, this component is a dynamically scaling set of counters to keep track of some sort of highly dynamic data point(s). Shared counters are especially useful in areas like social media for keeping track of likes, views, tags, and so on. When a strong consistency model is needed, shared counters may not be a suitable option.

![[shared_counter_architecture.png]]

Typically, a _counter_ will keep track of some data point we wish to track and the _shards_ within the counter can be considered individual numbers. When we want want to know the number for some data point, we go to its counter and sum all of the shards. When we want to increment/decrement a data point, we go to the counter and randomly pick an available shard to do the operation. 

Writes are more computationally expensive (as always) so a trade-off must be done. More shards means faster writes but slower reads (have to read more shards to get value). Conversely, less shards means faster reads but slower writes if the traffic is high enough.

Shared counters, at a minimum, have 3 APIs:
* CreateCounter(uniqueID, num_of_shads)
* ReadCounter(uniqueID)
* WriteCounter(uniqueID, action)
### How to handle write request bursts
How shards are selected during a write request require some sort of selection rule. Below are some common ones:
1. Round-robin (all-play-all)
	* Equal priority, circular order
	* Basic and easy to implement
	* Works well for simple operations like increment/decrement
2. Random selection
3. Metric-based selection
	* A load balancer sits between the counter and shards that is charge of selection of the shard based on some defined metric.

# Categorize Later
## Failure Types
* There are spectrum of failure types and below (in increasing order of difficulty) are the distributed system failure types:
	1. _Fail-Stop_
		* In this case a DS halts permanently, however, other nodes can still detect the node by (attempting) to communicate with it.
		* Generally the easiest to debug.
	2. _Crash_
		* In this case the DS halts silently and other nodes cannot detect the node has stopped working.
	3. _Omission_
		* The node fails to send or receive messages.
		* If it only fails to send messages, it is a _send omission failure_. If it fails only to receive messages, it is a _receive omission failure_.
	4. _Temporal_
		* The node generates the correct result but it arrives too late to be useful.
		* This can be caused by bad algorithms, slow hardware, poor design strategies, or loss of synchronization between processor clocks.
	5. _Byzantine_
		* The node exhibits random behavior like transmitting arbitrary messages at arbitrary times producing wrong results or stopping midway.
		* Likely caused by a software bug or a malicious entity.
		* These are the most challenging types of bugs to handle.

## Non-functional System Characteristics

Can be thought of in the form of "the system shall be X".
### Availability
* Availability is the percentage of time that some service or infrastructure is accessible to clients and is operated upon under normal conditions.
* This is a ratio calculated as follows: `A (in percent) = ((Total time - Amount of time server was down) / Total time) * 100`
### Reliability
* Reliability is the probability that the service will perform its function for a specified time.
* Reliability and availability are commonly used metrics decided upon on the _Service Level Objectives_ in a _Service Level Agreement_.
* Mean time between failures (MTBF) is calculated as: `MTBF = (Total elapsed time - Sum of downtime) / Total number of failures`
* Mean time to repair (MTTR) is calculated as: `MTTR = Total maintenance time / Total number of repairs`
* Teams should strive for a higher MTBF and lower MTTR.
### Scalability
* Scalability refers to the ability of a system to handle an increasing amount of workload without compromising performance.
* Workload types:
	* _Request workload_: the number of requests served by the system.
	* _Data/storage workflow_: the amount of data stored by the system.
* Dimensions:
	* _Size scalability_: a system is scalable in size if we can simply add additional users/resources to it.
	* _Administrative scalability_: This is the capacity for a growing number of organizations or users to share a single distributed system with ease.
	* _Geographical scalability_: This relates to how easily the program can cater to other regions while maintaining acceptable performance constraints.
* Scalability approaches:
	* _Vertical scaling_: i.e. scaling up. This is done by increasing the power of an existing device by adding better hardware (CPU, RAM, etc...). Vertical scaling usually has a noticeable upper limit and has major diminishing returns as you scale higher and higher up.
	* _Horizontal scaling_: i.e. scaling out. This is done adding more machines in the network. This can be much more cost-efficient compared to vertical scaling, but requires programs to be re-written in such a way that they work on a distributed system and act as a cohesive unit. This entails more complexity which leads to higher developer and monitoring costs at the benefit of better performance when going to scale.
### Maintainability
* Maintainability describes the property of being able to easily find and fix bugs, add new features, and keep the system update while ensuring smooth operation.
* Maintainability can be broken down into 3 aspects:
	1. _Operability_: this is the ease with which we can ensure the system's smooth operational running under normal circumstances and achieve normal conditions under a fault.
	2. _Lucidity_: This refers to the simplicity of the code. The simpler the code base, the easier it is to understand and maintain (and vice versa.)
	3. _Modifiability_: This is the capability of the system to integrate modified, new, and unforeseen features without any hassle.
* _Mean time to repair_ (MTTR) is the primary metric used to measure maintainability. It is defined as:
`MTTR = Total maintenance time / Total number of repairs`
### Fault Tolerance
* Fault tolerance refers to a system's ability to execute persistently even if one or more of its components fail. Here, components can be software or hardware. Conceiving a system that is 100% fault-tolerant is practically very difficult.
* Some ways to make a distributed system more fault tolerant is by:
	1. _Replication_ - i.e. replicating nodes that can switched out easily or redirected in case of failure.
	2. _Checkpointing_:
		* This is a technique where a system's state is saved in stable storage when the system state is consistent. Checkpointing is performed in many stages at different intervals.
		* When a failure occurs, we go back to the last computed stable state (i.e. the previous checkpoint.)

## Resource Estimation

### Back-of-the-envelope Hardware Latency

* Below is a rough estimation of some hardware latencies: ![[media/hardware_latency_ref.PNG]]
    <p style="text-align: center"><i>Credit: Educative.io</i></p>

### Consistency Models
* List of consistency models:
	* __Linearizability__
		* All operations happen instantaneously and therefore we do not need to worry about stale reads.
		* Guarantees that the effects of an operation took place at some point between when the client invoked the operation and when the result of the operation was returned to the client.
		* Within a centralized system, this is easy and obvious. In an asynchronous distributed system, this is virtually impossible unless algorithms like Paxos and Raft are used.
		* A system that is both has linearizability and serializability is called __Strictly Serializable/Consistent__.
		* Quorum-based replication can help improve the performance of a DS with this consistency model.
	* __Sequential consistency__
		*  In this consistency model, operations are allowed to take effect before their invocation or after their completion. As a result, there is no real-time guarantee. However, operations from different clients have to be seen in the same order by all other clients. The operations of every single client preserve the order specified by its program (global order).
		* Sequential order is preserved on the same processor or thread, while execution order of a program on different processors (or threads) is undefined.
		* e.g. in a social media app, the ordering of posts between friends isn't important but the order of posts from a single friend is preserved.
		* A weaker consistency model compared to _Linearizability_.
	* __Causal consistency__
		* Order, in all nodes, is only preserved in operations that are causally related. All other operations, order isn't preserved.
		* e.g. in a social media app, comment threads are causally related, but all the other comments aren't. So preserved order in a thread but not in the comments would lead to causal consistency.
		* Operations will need some way to indicate (data point) their relationship with each other in order to determine their casual relationship.
		* An even weaker consistency model compared to _Sequential Consistency_.
	* __Eventual consistency__
		* The weakest of the consistency models.
		* Order of operations can be different between multiple clients of the systems and reads are allowed to be stale. As long as no writes are done to the distributed system for a period of time, the DS will eventually read a stable state. i.e. the DS becomes consistent after a while if no writes are done.
		* The _Domain Name System (DNS)_ is a solid example of a highly available system that uses eventual consistency. Changes to the DNS records are not reflected immediately, but at some point, will reach its latest values.
* Consistency models are applied to a single-object operations.
* With respect to CAP theorem (and in an effort to reduce the amount of definitions for consistency models) there are two major categories:
	* _Strong consistency models_
		* These models correspond more to the "C" (i.e. consistency) in CAP theorem and cannot be supported in systems that need availability during network partitions.
		* Commonly, this is the _linearizability_ model.
	* _Weak consistency models_
		* These models that can be supported while also preserving availability during a network partition.
		* Commonly, this is the _eventual consistency_ model.

### Isolation Levels
* Isolation levels define what is possible and what is not in a system's behavior.
* Isolation levels are applied to multi-object operations.
* There are 5 common isolation levels:
	* __Serializability__ - i.e. two transactions, when executed concurrently, should give the same result as though executed sequentially.
	
	* __Repeatable Reads__ - ensures that the data, once read by a transaction, will not change throughout its course.
	
	* __Snapshot Isolation__ - if no other transaction has updated the same data since the snapshot, guarantees that all reads in a transaction see a consistent snapshot of the database from the point it started until the transaction commits successfully.
	
	* __Read Committed__ - does not allow transactions to read data that has not yet been committed by another transaction.
	
	* __Read Uncommitted__ - allows reading of uncommitted data by other transactions. This is the lowest isolation level.
### Anomalies, Distributed Database

* There are 7 common types of anomalies that can occur in a DS:
	* __Dirty Writes__
		* Occurs when a transaction overwrites a value that was previously written by another transaction that is still in-flight and has not been committed yet.
		* This is a direct violation of the integrity constraints in ACID.
	* __Dirty Reads__
		* Occurs when a transaction reads a value that has been written by another transaction that has not been committed yet.
		* This is a deadly issue in FinTech and should absolutely be avoided.
		* For big aggregate reports, this is less of an issue since some level of inaccuracy can be accepted.
		* E.g.
			```sql
			BEGIN;
			SELECT age FROM users WHERE id = 1;
			-- retrieves 20
			
			BEGIN;
			UPDATE users SET age = 21 WHERE id = 1;
			-- no commit here
			
			SELECT age FROM users WHERE id = 1;
			-- retrieves in 21
			COMMIT;
			```
	* __(Fuzzy)Non-repeatable Reads__
		* Similar to be a _dirty read_, but occurs when a value is retrieved twice in a transaction (without there being any updates in the same transaction) and the value is different.
		* (It is unclear how these could occur. Need to put in an example here.) 
		* E.g.
			```sql
			BEGIN;
			SELECT age FROM users WHERE id = 1;
			-- retrieves 20
			
			BEGIN;
			UPDATE users SET age = 21 WHERE id = 1;
			COMMIT;
			
			SELECT age FROM users WHERE id = 1;
			-- retrieves 21
			COMMIT;
			```
	* __Phantom Reads__
		* Occurs when a transaction does a predicate-based (e.g. WHERE) read, and another transaction writes or removes a data item matched by the aforementioned predicate while the first transaction is still in-flight.
		* If these occur, read data will be stale.
		* Phantom reads can be safe for applications that do NOT make predicate-based reads.
		* E.g.
			```sql
			BEGIN;
			SELECT name FROM users WHERE age > 17;
			-- retrieves Alice and Bob
			  
			BEGIN;
			INSERT INTO users VALUES (3, 'Carol', 26);
			COMMIT;
			  
			SELECT name FROM users WHERE age > 17;
			-- retrieves Alice, Bob and Carol
			COMMIT;
			```
	* __Lost Updates__
		* Can be compared to a dirty write, but with a small catch.
		* Occurs when two transactions read the same value and then try to update it to two different values. The end result is that one of the two updates survives, but the process executing the other update (that didn't survive) is not informed that its update didn't take effect.
	* __Read Skew__
		* Occurs when there are integrity constraints between two data items that seem to be violated because a transaction can only see partial results of another transaction.
		* A strict requirement to prevent read skews are rare.
	* __Write Skew__
		* Occurs when two transactions read the same data, but then modify disjoint sets of data.
	* Diagram for types of anomalies: ![[isolation_and_anomalies.PNG]]
	<p style="text-align: center"><i>Credit: Educative.io</i></p>
	* Further readings:
		* https://brooker.co.za/blog/
## Request Routing
* One problem that arises when partitioning data is how does the client know which node to connect to while making a request? If we want to read specific DB keys, we need to know which IP address we need to connect to read. This problem is problem is known as __Service Discovery__.
### ZooKeeper
* Separate management server for keeping track of all mappings in the network.
* Each node in the network connects to ZooKeeper for network mapping information.
* Open source software made by Apache.