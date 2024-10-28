#database #data

## Data Modeling
### Conceptual Data Model
* Very high level.
* Shows relationships between objects.
* Usually just names of concepts.

![[./media/data-modeling/concept_model.PNG]]
	<p style="text-align:center"><i>Credit: Ben Brumm</i></p>
### Logical Data Model
* Contains the objects, their relationships, and some attributes.

![[media/data-modeling/logical_model.PNG]]
	<p style="text-align:center"><i>Credit: Ben Brumm</i></p>
### Physical Data Model
* Describes the internal schema of the database.
* Includes table names, column names, keys, and relationships.  

![[media/data-modeling/physical_model.PNG]]
	<p style="text-align: center"><i>Credit: Ben Brumm</i></p>
### Entity Data Model (EDM)
#entity-data-model
* An EDM uses 3 key concepts to describe the structure of data:
	1. _Entity type_
	2. _Association type_
	3. _Property_
* An _entity type_ is the fundamental unit for describing data within an EDM. They can be thought of as tables.
* An _association type_ is the building block for describing relationships between entity types. Associations can be 0, 1, or many. These associations can be thought of as the foreign keys in a table.
* A _property_ can be thought of as the columns in an entity type. Properties contain the structure and characteristics of an entity type. These are generally primitives like integers, strings, or even binary streams.
* Within Entity Framework for .NET Core, the EDM is used heavily and comes with extra features such as [namespaces and inheritance](https://learn.microsoft.com/en-us/dotnet/framework/data/adonet/entity-data-model).

## Normal Forms
### First Normal Form
#1nf
* Formal definition: "Each set of columns must uniquely identify a row."
* Every attribute must have some kind of uniquely identifying column or field. This is generally achieved w/ primary keys.
* 1NF makes searching records easier is a must for good database design.
### Second Normal Form
#2nf
* Formal definition: "Fulfill the requirements of 1NF and each non-key attribute must be functionally dependent on the primary key."
* Tables need a way to be related to each other. This is achieved w/ foreign keys. i.e. key of the primary key of a related table.
* Without 2NF, we could not have relational tables. All tables would effectively work independently of each other.
* The types of relationships are:
    * 1-to-1
    * 1-to-many
    * many-to-many (not good)
    * self
### Third Normal Form
#3nf
* Formal definition: "Fulfill the requirements of 2NF and have no transitive functional dependencies."
    * i.e. if column A determines column B and column B determines column C, then column A determines column C.
    * This is the transitive property and this violates 3NF.
* Normal forms beyond 3NF aren't used often and may introduce too much complexity.

## Relational Databases (RDBMS) 
#rdbms
### Facts
* RDBMS are great for data that needs to be highly consistent.
* RDBMS can be scaled, but usually only vertically. Horizontal scaling requires extra complexity in order to achieve.
### SQL-specific
* There are 4 types of SQL commands:
	1. __DDL__ - Data Definition Language
		* e.g. DROP, CREATE
	2. __DML__ - Data Manipulation Language
		* e.g. SELECT, UPDATE, INSERT
	3. __DCL__ - Data Control Language
		* e.g. GRANT, REVOKE
	4. __TCL__ - Transaction Control Language
		* e.g. COMMIT, ROLLBACK
* Regarding `WITH (NOLOCK)`
	* Allows us to read uncommitted, dirty data, even if the row or page has a _shared lock_.
	* For use without the `WITH` keyword will be deprecated.
	* A good use case is for reporting or read-heavy tables.
	* `sp_who2` command.
	* These types of queries will block schema changes. i.e. it will acquire the _schema stability lock_ (sch-S).
### ACID
#acid
* _Atomicity_
	* Guarantee that all commands that make up a transaction are treated as a single unit. Everything will either succeed or fail; no in-between, no partial failures.
* _Consistency_
	* All rules, constraints, and triggers in a database are enforced. Otherwise, we will have an illegal state and this property will be violated.
* _Isolation_
	* All transactions are insulated from each other. No running transactions can affect any other transaction.
* _Durability_
	* Data is persisted and will continue to persist in the event of a crash or power outage.
### Cluster vs non-clustered indexing
* _Cluster_
	* Data is sorted within the table. i.e. PK. This is generally done automatically.
	* Since clustered indexes store the order within the table itself, no extra memory is taken.
* _Non-clustered_
	* Data indexes are stored in a separate space and it doesn't affect the ordering of the table. N.B. that a clustered index can still exist in the table while a non-clustered index for the table exists as well. e.g. a students table is order by ID, but a non-clustered index for student names is also made.
	* Non-clustered indexes take up extra memory.
### Common Table Expressions (CTE) 
#cte
* Basically allows you to create a virtual, named table that can be used for other `SELECT` queries. A useful tool for simplifying complex queries.
* Below is an example of a CTE:
```sql
SET @UPPERDATELIMIT := CURDATE() - INTERVAL 2 MONTH;
SET @DATELIMIT := '2023-05-31';
WITH
    customer AS (
        SELECT
            entity_id
            , email
        FROM dzrt1212.customer_entity
    ),
    c_grid AS (
        SELECT
            email
            , mobilenumber
            , billing_postcode
        FROM
            dzrt1212.customer_grid_flat
        WHERE created_at > @DATELIMIT
    )

SELECT
    c_grid.mobilenumber
    , c.email
FROM
    customer AS c
    INNER JOIN sales
        ON sales.customer_id = c.entity_id
```

### View vs. Query

* A view is a virtual table whose contents are defined by a query. Views can be partitioned or be indexed (non-clustered index).

## NoSQL Databases 
#nosql
### Facts
* NoSQL databases can be ACID compliant, but that is highly dependent on the programmer and database engine.
* NoSQL databases are great for data that needs to be highly available and easily scalable. i.e. very horizontally scalable.
### BASE
* _Basically Available_
    * Rather than enforce immediate consistency, NoSQL databases ensure availability of data by spreading and replicating it across nodes of the database cluster.
* _Soft State_
    * State is now the onus of the developer instead of a integral feature of the database.
* _Eventually Consistent_
    * Since NoSQL doesn't ensure immediate consistency, data will eventually reach consistency as long as the developer takes the right measures.

### NoSQL engines
* [SurrealDB](https://surrealdb.com/)
	* Multi-modal database
* [MongoDB](https://www.mongodb.com/)
	* Fast, document-based database.
* Redis
	* In-memory key-value storage
* Cassandra
* GraphQL
	* Not technically a DB engine, but a declarative API that can query from multiple data sources.
* HBase