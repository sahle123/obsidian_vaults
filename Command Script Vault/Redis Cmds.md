#cmds 

	Lists:
		LPUSH <key> <value>				// Insert value to head of list.
		RPUSH <key> <value>				// Insert value to tail of list.
		LPOP <key>						// Get and remove head of list.
		RPOP <key> 						// Get and remove tail of list.
		LRANGE <key> <start> <end> 		// Gets list. Setting end range to -1 will return whole list.
		LREM <key> <count> <value>		// Remove from list.
		LLEN <key> 						// Get size of list.
		LTRIM <key>	<start> <stop>		// Trim list from start and stop points.


	Sets:
		SADD <key> <value>				// Adds value(s) to key set.
		SMEMBERS <key>					// Get all values in set.
		SISMEMBER <key> <value> 		// Check if value exists in key set.
		SCARD <key> 					// Get how many items are in a set.
		SRANDMEMBER <key> 				// Get an item from a set randomly w/o removing.
		SPOP <key> 						// Get and remove top of set (ordered???)
		SREM <key> <value>				// Remove value from set.
		SINTER <key1> <key2> 			// Get all values that overlap in the two sets.


	Sorted Sets:
		ZADD <key> <score> <value>		// Adds value(s) to key set.
		ZMEMBERS <key>					// Get all values in set.
		ZCARD <key> 					// Get how many items are in a set.
		ZPOP <key> 						// Get and remove top of set (ordered???)
		ZREM <key> <value>				// Remove value from set.
		ZRANK <key> <member> 			// Get score of a member in a sorted set.
		ZRANGE <key> <start> <end> 		// Gets sorted set. Setting end range to -1 will return whole set.
		ZINCRBY <key> <incr> <member> 	// Increment member by increment in sorted set.


	Hashes:
		HMSET <key> <field1> <value1> <field2> <value2> ... // Sets hash key with n many fields and values.
		HGETALL <key>
		HSET <key> <field> <value>		// Sets value in field for a hashmap.
		HINCRBY <key> <field> <incr>	// Increments field by increment amount for a hashmap.


	Basics:
		SET <key> <value>
		GET <key>
		EXISTS <key>
		DEL <key>
		KEYS * 							// Displays all keys.
		KEYS a* 						// Display all keys that begin with 'a'.
		INCR <key> 						// Increment key.
		INCRBY <key> <amount>
		DECR <key> 						// Decrement key.
		DECRBY <key> <amount>
		SETNX <key> <value> 			// Sets only if value in key does not exist.
		SETEX <key> <seconds> <value> 	// Sets key with an expiration date.
		TTL <key> 						// Get keys remaining time before expiration.
		EXPIRE <key> <seconds>			// Set an existing key to expire after n seconds.


	Publish/Subscribe:
		SUBSCRIBE <channel>				// Subscribes to channel. Will receive messages from publisher.
		PUBLISH <channel> <message>		// Publish a message to a channel where subscribers will receive message.
		


Notes:
- NoSQL database.
- Uses key/value store.
- High performance; typically used for caching.
- database is stored in memory, not disk.
- Each key can hold up to 512 MB of data.
- All transactions are atomic.
- The 5 data types in Redis:
	- string
	- hash
	- type list
	- type set
	- type sorted set
- Type lists can hold more than 4 billion items.
- Sets are NOT ordered.
- Sets only hold an item once.
- Sorted sets are sorted by score.
- Hashes are good for object-like stores since each key can hold more than 1 value.
