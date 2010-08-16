package org.welsy.olapstats.infrastructure
{
	import mx.collections.ArrayCollection;
	
	import org.db.mongo.Cursor;
	import org.db.mongo.Mongo;
	import org.welsy.olapstats.MongoConfig;
	import org.welsy.olapstats.application.MongoQueryEvent;

	public class MongoQuery
	{
		
		[MessageDispatcher] public var dispatchMessage : Function;
		
		[Inject] public var mongoConfig : MongoConfig;
		
		public var cursor : Cursor;
			
		/**
		 * @brief Set up a database query
		 */
		public function queryDB() : void {
			var mongo : Mongo = new Mongo( mongoConfig.db_host, mongoConfig.db_port );
			cursor = mongo.getDB( mongoConfig.db_name ).getCollection( mongoConfig.db_collection ).find( {}, null, readAll );
		}
		
		// called when all results from the database are loaded
		public function readAll() : void {
			dispatchMessage( MongoQueryEvent.getMongoReplyReceived( new ArrayCollection( cursor.documents ) ) );
		}
	}
}