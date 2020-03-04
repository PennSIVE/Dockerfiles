# Databases

Example scripts to set up common databases. See [this comparison](https://kkovacs.eu/cassandra-vs-mongodb-vs-couchdb-vs-redis) of popular database platforms to determine what best suits your needs.

### MySQL
When you have relational data you know the structure of ahead of time.

### MongoDB
When you'd rather work with JSON and not have to predefine schemas.

### Cassandra
When you have so much data it needs to be distributed, and you don't care about [ACID](https://en.wikipedia.org/wiki/ACID). Writing data is practically free, but does not allow querying in a relational way (where clause _must_ include primary key, and is restricted to basic operands e.g. `=`, `!=`, `>` -- no joins, no functions).

