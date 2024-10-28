#software-architecture 

## Enterprise Integration Patterns/Styles
* [Start here](https://en.wikipedia.org/wiki/Enterprise_Integration_Patterns)

## Application Architecture
* [Start here](https://www.redhat.com/en/topics/cloud-native-apps/what-is-an-application-architecture#overview)
### N-tier architecture
* Any N layers can be specified and these are to represent a separation of concerns. Each layer should have a specific focus and all communicate to each other accordingly.
* It's easy to create layers that add extra work without adding any benefit so finding the sweet-spot is a matter of the scope of the project, the business, and the team's ability.
* 3-tier is the most common which is segregated into 3 layers:
    1. Presentation
    2. Application
    3. Data
* [More can be found here](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/n-tier)
### Event-Driven Architecture
* All EDAs have 3 components:
    * Event producers
    * Event routers
    * Event consumers
### Test-Driven Design (TDD)
  #fill-in-later
### Domain-Driven Design (DDD)
#domain-driven-design 
* A somewhat dated approach that is arguably most useful in project domains that are highly complex.
* DDD is predicated on the following goals:
    * Place the project's primary focus on the core domain and domain logic.
    * Basing complex designs on a model of the domain.
    * Initiating collaboration between technical and domain experts to iteratively refine a conceptual model that addresses particular domain problems.
#### Composite Specification Pattern
* Falls under _Domain-Driven Design_.
* Essentially, this is a design pattern that allows the chaining of business rules via Boolean logic at runtime.
* In more simple terms, I can AND, OR, XOR, NOT, etc... any business rules I want within the code at runtime.
* The implementation for this can be done via the object-oriented composite design patterns. (Yes, I know, the naming is confusing).
* [Useful StackExchange post](https://softwareengineering.stackexchange.com/a/443871/248566)
#### Repository Design Pattern
* Falls under _Domain-Driven Design_.
* __Unit of Work__ goes hand-in-hand w/ the repo pattern.
* This pattern mediates between the domain and data mapping layers, acting like an _in-memory collection_ of domain objects.
* The repo layer is NOT responsible for persisting data. This is meant to be an in-memory construct and any changes that are to be reflected in the data layer will be handled by the UoW context.
* It is an anti-pattern to have repos tied one-to-one w/ a single table. Rather, it should be tied to the __aggregate root__ which is a cohesive, meaningful concept in a domain. e.g. the orders, orderItem, address, and user tables maybe part of one aggregate root.
* Benefits of using a repo pattern:
    * Decouples the app by adding a layer of abstraction between the domain layer and persistence layer.
    * Minimize duplicate query logic.
    * Make it easier to switch out an ORM if need be.
        * On average, there is a new ORM every 2 years.
#### Unit Of Work (UoW)
* __Repo__ usually goes hand-in-hand w/ the UoW pattern.
* Is responsible for persisting data to the date tier.
* Commits and rollbacks are done here.
* Note that UoW context (usually called a DbContext) contains a set of repos.
* When a save or commit is done, the current state of all repos within this UoW context will be persisted to the data tier.
* The combination of Repo and UoW forms a _Data Access Layer (DAL)_. DALs that do not separate out persistence and data access are considered poor practices in enterprise-level applications.
### Command and Query Responsibility Segregation (CQRS)
#cqrs

* Frequently paired with _Event Sourcing_ to for us as an auditing or logging mechanism.
* Plainly speaking, CQRS is the separation of _Commands_ (i.e. update/transform data) and _Queries_ (i.e. read data).
    * Since reads are more frequent than writes, certain kind of data structures will be more useful for queries than commands.
    * We also get to separate out the concerns within the code. This enhances readability and potentially performance if done rightly.
* __CQS__ (Command Query Separation) is a design pattern. CQRS builds on top of CQS working as a broader architectural pattern.
* Since CQRS and DDD are orthogonal, they can be used separately or together; they're independent of each other.

## API Architectures

![[./media/api_architectures.PNG]]
<p style="text-align: center"><i>Credit: ByteByteGo</i></p>

## API Lifecycle

![[./media/api_lifecycle_map.PNG]] 
<p style="text-align: center"><i>Credit: Educative.io</i></p>
### SOAP
* XML-based data format and highly structured.
* Useful for enterprise architectures where state, security, ACID compliance, and reliability are paramount.
    * This comes at the cost of complexity, less scalability (since each client's state is maintained), and larger payloads.
    * Not ideal for lightweight or resource-based APIs.
    * SOAP is used heavily in FinTech.
### RESTful
* Resource-based format and commonly used.
* Stateless, lightweight, and ideal for websites.
* Although less resource intensive and more efficient compared to SOAP, REST is still a poor choice for realtime or streamed data.
* Scaling w/ REST is relatively trivial.
* Easily cacheable since data is
* REST comes with no security since it is technically more of a set of principles rather than a framework.
### GraphQL
* Developed by Meta and has a high learning curve.
* Query language for reducing network loads.
    * You fetch exactly what you request for in the payload. No under- or over-fetching.
### gRPC
* Useful for high-performance distributed architectures such as microservices.
* Has limited browser support and is more suited for inter-server communication.
* Data is converted into protocol buffers which are transmitted in binary over the network this reducing bandwidth usage significantly.
### Websocket
* For bidirectional, low latency data exchange.
* Perfect for streaming data or data needed in realtime. i.e. video streaming, game servers, etc...
* With websockets, a connection is maintained until either party member disconnects.
### Webhook
* For asynchronous, event-driven apps.
* Ideal for notifications or any type of system that relies on events and triggers.
## Containerization
### Facts
* Mostly a duty for DevOps teams.
### Docker
* Commercial container runtime. Considered easier to use compared to Kubernetes.
* Docker Swarm is the platform for running/managing containers + orchestration. It would be more apt to compare Docker Swarm to K8s.
* [Kubernetes vs. Docker](https://www.atlassian.com/microservices/microservices-architecture/kubernetes-vs-docker)
### Kubernetes
* Open source but considered harder to use. Most people opt to use some managed Kubernetes service.
* K8s is a platform for running and managing containers and therefore you could run Docker or any other container runtime on top of it.
* [Kubernetes vs. Docker](https://www.atlassian.com/microservices/microservices-architecture/kubernetes-vs-docker)
## Message Brokering
### Facts
* Message Queues and Message Brokering are used interchangeably.
* MQs are great for image scaling, video encoding, search engine indexing, PDF processing, and processing user sign-ups for a website/app.
* [Detailed tutorial on AMQP](https://www.cloudamqp.com/blog/microservices-and-message-queues-part-1-understanding-message-queues.html)
* [Message queue vs. Service mesh vs. API gateway](https://arcentry.com/blog/api-gateway-vs-service-mesh-vs-message-queue/)
### Kafka
* Use for real-time streaming and analyzing data. e.g. video streaming/encoding
* [Difference between Kafka vs. RabbitMQ](https://www.simplilearn.com/kafka-vs-rabbitmq-article)
### RabbitMQ
* Use for web servers with long running tasks that don't need quick responses. e.g. user sign-ups for a website.
* [Difference between Kafka vs. RabbitMQ](https://www.simplilearn.com/kafka-vs-rabbitmq-article)
## Unified Modeling Language (UML)
#fill-in-later 