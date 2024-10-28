#oop #object-oriented-programming

## Design Patterns

### "Gang of Four"
#gang-of-four #oop-principles

* __Creational__ patterns are ones that deal w/ object creation mechanisms.

    * **Abstract Factory**
        * Intent: Product families of related objects without specifying their concrete classes.
        * Allows creation of a factory for a factory class.
        * Formal definition: an interface for creating families of related or dependent objects w/o specifying their concrete classes.
        * This design pattern is generally uncommon.
        * Applicability:
            * Use when your code needs to work with various families of related products, but don't want it to depend on the concrete classes of those products; they might be unknown beforehand or you simply want to allow for future extensibility.
            * Consider using when you have a class with a set of _factory methods_ that blur its primary responsibility.

    * **Builder**
        * Intent: Creating complex objects step-by-step.
        * Allows creation of an object discretely step-by-step with a final 'build' method call to assemble the object instance.
        * Generally uses the _fluent interface pattern_ i.e. chaining method calls together.
        * Applicability:
            * Use when you want to get rid of "telescoping constructors".
            * Use when you want your code to be able to create different representations of some product.
            * Use to construct _Composite_ trees or other complex objects.

    * **Factory / Factory Method**
        * Intent:
            * Have interface for creating objects in a superclass, but allow subclasses to alter the type of objects that will be created.
            * A component responsible solely for the wholesale (not piece-wise) creation of objects.
        * Motivation:
            * Object creation logic is sometimes too convoluted.
            * Constructors are not descriptive and they cannot be overloaded.
        * Takes out the responsibility of instantiating an object from the class to the factory method.
        * These are generally implemented as static classes that call the right constructor depending on which factory method is invoked.
        * This is similar to the _strategy_ pattern, but we are not concerned about the behavior of the object, only its creation.
        * _Builder_ pattern is done piece-wise, _factory_ is done wholesale.
        * Applicability:
            * Use when you don't know beforehand the exact types and dependencies of the object your code should work with.
            * Use when you want to provide users of your library/framework w/ a way to extend its internal components.
            * Use when you want to save system resources by reusing existing objects instead of rebuilding them each time.

    * **Prototype**
        * Intent:
            * Copy existing objects without making your code dependent on their classes.
            * Create a new, separate object from copying an existing object.
        * This pattern is achieved by creating a new object instance from another, similar instance and modifying them according to our requirements.
        * This is done mostly by deep copying w/ a factory method.
        * Applicability:
            * Use this pattern when your code should not depend on the concrete classes of objects that you need to copy.
            * Use this pattern when you want to reduce the number of subclasses that only differ in the way they initialize their respective objects.

    * **Singleton**
        * Intent: A single, global access point for some class or resource.
        * Restricts the initialization of a class to only one instance of the class.
        * Unlike static classes, singletons follow OOP principles.
        * Another type of Singleton is called the _monostate_ pattern. (Not sure what the use cases for this is.)
        * Applicability:
            * Useful for database contexts in object relational mappers (ORMs).
            * Making a single, shared database connection object.
            * Making an object factory.
            * When needing stricter control over global variables.
        * This pattern generally has a bad reputation:
            * Hard to do unit/integration tests since test frameworks typically rely on inheritance to produce mock objects and run tests.
            * This pattern needs special treatment in multi-threaded environments.
            * Violates the "Single Responsibility Pattern" by solving 2 problems at once. (i.e. ensure single instance, provide global access point to single instance).

* __Structural__ patterns are concerned w/ the structure (e.g. class members) or relationships among entities. Many of these are wrappers that mimic the underlying classes' interface.

    * **Adapter**
        * Also called a "wrapper", just like the _decorator_ pattern unfortunately.
        * Intent:
            * Allow objects with incompatible interfaces to communicate.
            * Allows for 2 (or more?) incompatible types to communicate.
        * The difference between _adapter_ and _bridge_ is that the bridge pattern is planned in the app's design beforehand. Conversely, the adapter pattern is implemented at a later stage and when it is too inconvenient or difficult to change the underlying implementation.
        * Applicability:
            * Use when you want to use some existing class, but its interface isn't compatible with the rest of your code.
            * Use when you want to reuse several existing subclasses that lack some common functionality that can't be added to the superclass.

    * **Bridge**
        * Intent: Split a large class or set of closely related classes into 2 separate hierarchies: abstraction and implementation.
        * Decouples an abstraction from its implementation so that the two can vary independently. i.e. connecting components through abstractions.
        * The _Bridge_ and _Adapter_ patterns usually get conflated.
            * Note that _bridge_ is generally designed before an application is built whilst _adapter_ is commonly used for an existing app that has incompatible elements.
            * Typically used for cross-platform apps, supporting multiple types of database servers, working with several API providers of a certain kind, etc...
        * Applicability:
            * Use when you want to divide and organize a monolithic class that has several variants of some functionality.
            * Use when you need to extend a class in several orthogonal (independent) dimensions.
            * Use when you need to switch implementations at runtime. (isn't this the same as _strategy_?)

    * **Composite**
        * Intent:
            * Treating individual (scalar) and aggregate objects uniformly.
            * Compose objects into tree-like structures and then work with these structures as if they were individual objects.
        * Within C#, you can masquerade single object types as a collection with `yield return this`.
        * Note that in some cases it may too difficult to implement a common interface for classes whose functionality differ too much.
        * Compared to the _decorator_ pattern, the _composite_ pattern "sums up" it's children's results. The _decorator_ adds new functionality.
        * Applicability:
            * Use when you want the client code to treat both simple and complex elements uniformly.
            * Use when you have to implement a tree-like object structure.

    * **Decorator**
        * Also called a "wrapper".
        * Intent:
            * Attach new behaviors to objects by placing these objects inside special wrapper objects that contain the behaviors.
            * Facilitate the addition of behaviors to individual objects without inheriting from them.
        * Note that _Decorators_ may or may not proxy all calls. i.e. not all APIs may be implemented. _Proxies_, on the other hand, will implement all APIs. In fact, proxies need to provide an identical interface.
        * Compared to _Adapters_, _Decorators_ add new behaviors. Adapters are for allowing incompatible types to communicate (by changing their interface).
        * _Aggregation_ vs. _Composition_:
            * _Aggregation_: A contains B; B can live without A.
            * _Composition_: A consists of B; A manages B's lifecycle; B cannot live without A.
        * Applicability:
            * Use when you need to be able to assign extra behaviors to objects at runtime without breaking the code that uses these objects.
            * Use when it is difficult or not possible to extend an object's behavior using inheritance.
        * [More reading...](https://refactoring.guru/design-patterns/decorator)

    * **Facade**
        * Intent: Provide a simplified interface to a library, a framework, or a complex set of classes.
        * Be wary of coupling all classes to _facades_. This will lead to _god objects_ which are an anti-pattern.
        * _Facades_ do not introduce any new behavior, functionality, or indirection. The purpose is solely for simplifying the use of some library, framework, or set of classes.
        * Applicability:
            * Use when you need a limited, but straight-forward interface to a complex system.
            * Use when you want to structure a subsystem into layers.
        * [Handy reference](https://refactoring.guru/design-patterns/facade)

    * **Flyweight**
        * Sometimes called "cache".
        * Intent: Fitting more objects into the available amount of RAM by sharing common parts of state between multiple objects instead of keeping all of the data in each object.
        * This pattern is essentially a space-optimization technique. It is used heavily in gameDev.
        * States are typically split up into the _extrinsic_ and _intrinsic_ states:
            * Extrinsic = data directly and exclusively specific to that object instance. This data is mutable. E.g. local/world coordinate data for a game object.
            * Intrinsic = data that is shared across all the other related objects. This data is immutable. E.g. Prefab data for a game object in a game engine.
        * This pattern can save lots on RAM if there are tons of similar objects. However, you could be trading in CPU for RAM because some context data needs to be recalculated each time somebody calls a flyweight method.
        * .NET implements this pattern w/ its strings via _string interning_. String interning basically has strings objects with identical string point to the same area in memory to save on space.
        * Applicability:
            * Use the _flyweight_ pattern only when your program must support a huge number of objects which barely fit into available RAM.

    * **Proxy**
        * Intent:
            * Use substitute/placeholder for another object that controls access and can perform something before/after sending the request to the original object.
            * An interface for accessing a particular resource.
        * This design pattern is used a lot in networking and cloud. e.g. proxy, reverse proxy, load balancer, etc...
        * Proxies usually manage the lifetime of the object they are referencing.
        * Note that there are many types of proxies. Some examples include:
            * Protection Proxy
            * Property Proxy
            * Value Proxy --> essentially a wrapper around a primitive value type.
            * Composite Proxy
            * Dynamic Proxy
            * Caching Proxy
        * Applicability:
            * Use for lazily loading heavyweight service objects, especially ones that will be used only once.
            * Use for access control (i.e. protection proxy).
            * Use for logging requests (i.e. logging proxy).
            * Use for caching results (i.e. caching proxy).
            * Use for smart referencing. That is, to manage dismissal of a heavyweight object once all client references to it reaches 0.

* __Behavioral__ patterns are ones that do not fall in either creational or structural. They tend to be broad in their use cases.

    * **Chain of Responsibility**
        * Intent: Pass requests along a chain of handlers. Each handler decides either to process, drop, or pass request to the next handler in the chain.
        * All handler classes must implement the same interface.

        * ![[./media/DesignPatterns_ChainOfResp.png]]

            <p style="text-align: center"><i>Credit: refactoring.guru</i></p>
        * Compared to _Decorators_, the CoR pattern is allowed to break the flow of the request.
        * Some relationships and differences of other patterns:
            * _CoR_ passes a request sequentially along a dynamic chain of potential receivers until one of them handles it.
            * _Command_ establishes unidirectional connections between senders and receivers.
            * _Mediator_ eliminates direct connections between senders and receivers, forcing them to communicate indirectly via a mediator object.
            * _Observer_ lets receivers dynamically subscribe to and unsubscribe from receiving requests.
        * Applicability:
            * Use when your program is expected to process different kinds of requests in various ways, but the exact type of requests and their sequences are unknown beforehand.
            * Use when it's essential to execute several handlers in a particular order.
            * Use when the set of handlers and their order are supposed to change at runtime.

    * **Command**
        * Intent: Turning the request into a standalone object that contains all info about the request.
        * Request generally come in one of two types: Commands (add/transform data) and Queries (read data).
        * A powerful design patterns that adheres to all SOLID principles.
        * Since this adds a new layer between senders and receivers, this introduces more complexity to the code.
        * Commands can be serialized, undone, and turned into macros (i.e. composite commands).
        * This design pattern is used heavily in CQS/CQRS (Command Query Separation)/(Command Query Responsibility Segregation).
        * Applicability:
            * Use when we want to parameterize objects w/ operations.
            * Use when we want to queue operations, schedule operations, or run them remotely.
            * Use when we want undo/redo, macro, or replay functionality.
        * [Handy reference](https://refactoring.guru/design-patterns/command)

    * **Interpreter**
        * N.B. that the _interpreter_ design pattern is in fact a separate field of computer science! This branch is called 'compiler theory'.
        * Intent: Given a language, define a representation for its grammar along w/ an interpreter that uses the representation to interpret sentences in the language.
        * An interpreter is a component that processes structured text data. It does so by turning it into separate lexical tokens (lexing) and then interpreting sequences of said tokens (parsing).
        * Applicability:
            * Use when you want to build your own Regex, literal expressions, or anything that **takes some textual input and turns it into some king of OOP structure.**
                * Note that for compilers, this design pattern is too weak and unmanageable. Using parser generators and other tools would be better.
        * Examples of programs that use the _interpreter_ design pattern:
            * Some programming compilers
            * IDEs
            * HTML, XML, JSON, CSS
            * Numeric expressions --> e.g. (3 + 4 / 5)
            * Regular Expressions (Regex)

    * **Iterator**
        * Intent: Allowing traversal of collection elements without exposing its underlying representation.
        * Makes traversing complex objects much easier for the user.
        * This pattern is overkill for simple collections.
        * `yield return` and `yield break` statements are used in tandem w/ _iterators_.
        * Applicability:
            * Use when your collection has a complex data structure under the hood and you want to hide the complexity due to convenience or security reasons.
            * Use when you want to reduce duplication of traversal code across your app.
            * Use when you want your code to be able to travel different data structures or when the data structure is unknown before runtime.
        * [Handy reference](https://refactoring.guru/design-patterns/iterator)

    * **Mediator**
        * a.k.a. "Intermediary", "Controller"
        * Intent: Restrict direct communications between the objects by forcing them to collaborate only via a mediator object.
        * Warning: over time a mediator can evolve into a _god object_.
        * Mediators are typically implemented as singletons.
        * How _Mediator_ differs from _Observer_:
            * The mediator design pattern goal is to eliminate dependencies among a set of system components.
            * The goal of the observer design pattern is to establish dynamic, one-way connections between objects where some objects act as subordinates of others.
            * You can implement both patterns together.
        * How _Mediator_ differs from _Facade_:
            * The _Facade_ pattern is used for simplifying interfaces to subsystems of objects, but introduces no new functionality.
        * Applicability:
            * Use this pattern when it's hard to change some of the classes because they are tightly coupled to a bunch of other classes.
            * Use when you can't reuse a component in a different program because it's too dependent on other components.
            * Use when you find yourself creating tons of component subclasses just to reuse some basic behavior in various contexts.
            * Use when you want some kind of "middleman" between two or more objects.

    * **Memento**
        * a.k.a. "Snapshot" pattern.
        * Intent:
            * Storing the previous state of an object without knowing its implementation.
            * Yielding tokens representing system states.
        * Check Linq code references for implementation details.
        * Applicability:
            * Use anytime when a history of transactions needs to be saved, even temporarily.
            * Generally works hand-in-hand with the _command_ pattern.
        * [Handy reference](https://refactoring.guru/design-patterns/memento)

    * **Null Object**
        * N.B. this is not officially in the book of the 'Gang of Four', but is a widely used OOP design pattern.
        * Intent:
            * A design pattern with no behavior.
            * A no-op object that conforms to the required interface, satisfying a dependency requirement of some other object.
        * When component A uses component B, it typically assumes that B is non-null. This pattern solves the aforementioned issue.
        * Applicability:
            * No idea when to use this design pattern...

    * **Observer**
        * a.k.a. "Event-Subscriber", "Pub/Sub", or "Listener".
        * Intent:
            * Define a subscription mechanism to notify multiple objects about any events that happen to the object they're observing.
            * Allowing users to receive event-timed messages on topics they are interested (subscribed) in.
        * Some interesting state we want to capture is called the "subject" and the state's info is disseminated by a "publisher". All other objects that want to track changes for this _state_ are called "Subscribers".
        * _Property dependencies_ in the Observer pattern is a difficult issue that has no clear, easy answer for.
        * The observer pattern is baked right into C# and has many classes and interfaces that support this design pattern; it's part of C#'s design.
            * Specifically to .NET, there is the _Weak Event Pattern_ which is used a lot in WPF applications.
        * Applicability:
            * Use when changes to the state of one object may require changing other objects, and the actual set of objects is unknown beforehand or changes dynamically.
            * Use the pattern when some objects in your app must observe others, but only for a limited time or in specific cases.
            * Used pretty often for implementing GUIs.

    * **State**
        * Intent: Letting an object alter its behavior when its internal state changes. It appears as if the object changed its class.
        * The _state_ pattern is closely related to the concept of a finite-state machine.
        * Classes usually implement some shared interface or abstract class that allows for switching between different object states.
        * "A formalized construct which manages state and transition is called a _state machine_."
        * Dmitri Nesteruk claims that the implementation example given in the Gang of Four book isn't well designed. Too many classes, bidirectional influence of state object and controller object, etc...
        * The _strategy_ pattern and _state_ pattern are fairly similar, but in the _state_ pattern the particular states may be aware of each other and initiate transitions from one to another, whereas the _strategies_ know almost nothing about each other.
        * Applicability:
            * Use when you want certain behaviors of some objects to work differently depending on what state they are in. (e.g. the middle button in a smart phone. Its function is context sensitive.)
            * Use when you have a class polluted with massive conditionals that alter how the class behaves according to the current values of the class's fields.

    * **Strategy**
        * a.k.a. "Policy" pattern.
        * Intent:
            * Define family of algorithms, put each in separate class, and make their objects interchangeable.
            * Define set of algorithms of same set of interfaces and decide upon which algorithm to use at compile-time or run-time.
        * Enables the exact behavior of a system to be selected either at run-time (dynamic) or compile-time, (static).
        * (I think) dependency injection is a perfect example of a compile-time (static) strategy design pattern.
        * E.g. calling a sort method and providing a predicate on how to sort the members.
        * Applicability:
            * Use when you want to use different variants of an algorithm within an object and be able to switch from one to the other at runtime.
            * Use when you have lots of similar classes that only differ in the way they execute some behavior.
            * Use when you want to isolate business logic of a class from the implementation details of algorithms that may not be as important to the context of that logic.

    * **Template Method**
        * Intent: A skeleton algorithm that lets the subclasses override specific steps of the algorithm without changing its structure.
        * Very similar in function to the _strategy_ pattern, but instead of working via composition the template method works through inheritance.
        * Note that the _Factory Method_ is a specialization of the _Template Method_.
        * Potential drawbacks:
            * Can violate Liskov Substitution Principle by suppressing a default step implementation via a subclass.
            * Template methods tend to be harder to maintain the more steps they have.
        * Applicability:
            * Use when you want clients to extend only particular steps of an algorithm, but not the whole structure.
            * Use when you have several classes that contain almost identical algorithms with some minor differences.

    * **Visitor**
        * Intent:
            * Separate algorithms from the objects on which they operate.
            * A pattern where a component (visitor) is allowed to traverse the entire inheritance hierarchy. Implemented by propogating a single `visit()` method throughout the entire hierarchy.
        * The 'Double Dispatch' trick is also called the 'Classic Visitor'.
        * Motivation:
            * Need to define a new operation on an entire class hierarchy.
            * Do not want to keep modifying every class in the hierarchy.
            * Need access to the non-common aspects of classes in the hierarchy.
                * i.e. an extension method won't do.
        * Note that the visitor pattern is common due to its complexity and narrow applicability.
        * Can do 'Dynamic Dispatching' in C# by leveraging the DLR. Bear in mind that this will incur a pretty big performance penalty.
        * ![[./media/DesignPatterns_Visitor.png]]
            <p style="text-align: center"><i>Credit: refactoring.guru</i></p>
        * Applicability:
            * Use when you need to perform an operation on all elements of a complex object structure (e.g. a tree).
            * Use to clean up business logic of auxiliary behaviors.
            * Use when a behavior makes sense only in some classes of a class hierarchy, but not in others.
        * [Useful reference](https://refactoring.guru/design-patterns/visitor)

## Task-based Asynchronous Pattern vs. Multithreading 
#threading

* Task-based Async Pattern (TAP) is generally single threaded asynchronous programming.
    * There is a synchronization context within TAP. [Handy reference](https://stackoverflow.com/questions/34680985/what-is-the-difference-between-asynchronous-programming-and-multithreading).
    * Many tasks are not processor-bound. These type of tasks work well w/ TAP.
* Multithreading actually uses multiple threads to compute some result.
    * For tasks that are processor-bound, multithreading can be useful as we assign one task to each worker and one processor to each worker.
* "Threading is about workers. Asynchrony is about tasks."

## C#-specific 
#c-sharp 

* __Reflections__: are used to retrieve metadata on types at runtime.
    * This can allow one to create instances, do late binding, create new types, or find out about dynamic types at runtime.
    * Note that _reflections_ are considered slow since they do add some extra overhead.
* __Attributes__: add metadata to your program. This is helpful for a lot of features in the .NET Core environment.
* __Task-based Async Pattern__ in C# uses a _managed thread pool_ to implement its async behavior. So, technically speaking, TAP in C# is a sort of 'managed multithreaded' approach.
    * Note that all threads in the managed thread pool are _background threads_. [Managed thread pool in detail](https://learn.microsoft.com/en-us/dotnet/standard/threading/the-managed-thread-pool).
    * There is only 1 thread pool per process.
    * [TAP in detail](https://learn.microsoft.com/en-us/dotnet/standard/asynchronous-programming-patterns/consuming-the-task-based-asynchronous-pattern)
* Late-binding vs. Early-binding:
    * Early-bound objects are determined at compile time and no implicit casts occur. These objects are associated with some defined class.
    * Late-bound objects are only checked at runtime when the object is created or an action is performed on the type. This is achieved using the __Entity__ class.
* Misc:
    * C# strings use UTF-16.