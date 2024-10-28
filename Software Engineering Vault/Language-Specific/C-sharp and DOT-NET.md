#dot-net #c-sharp


### ADO.NET vs. Entity Framework
#### ADO.NET
* Establishes a direct communication between the relational/non-relational system and app.
* Is directly connected to the database.
* Provides complete control of the DAL and allows creation of classes and methods from scratch.
* Debugging can be difficult.
* More flexible in terms of raw SQL queries and procedures.
* Is NOT an Object-Relational Mapper (ORM).
#### Entity Framework
* Provides ORM framework over ADO.NET. EF is built on top of ADO.NET.
* Translates LINQ queries into raw SQL and then executes that query to the database.
* Always creates the data model classes and their related database context class automatically.
* Provides clear relationship between the different model classes.
* Not as flexible as ADO.NET because it always depends on LINQ queries which return the data entity model class type. N.B. that raw SQL can still be used in EF, but that would defeat the purpose of EF's use.
* Is an Object-Relational Mapper (ORM).

### Common Language Runtime (CLR) vs. Dynamic Language Runtime (DLR)
* [Read up more here](https://learn.microsoft.com/en-us/dotnet/framework/reflection-and-codedom/dynamic-language-runtime-overview)
