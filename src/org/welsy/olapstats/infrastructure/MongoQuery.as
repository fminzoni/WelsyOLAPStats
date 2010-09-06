package org.welsy.olapstats.infrastructure
{
	import mx.collections.ArrayCollection;
	
	import org.db.mongo.Cursor;
	import org.db.mongo.Mongo;
	import org.db.mongo.mwp.OpReply;
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
			var mongo : Mongo = new Mongo( mongoConfig.dbHost, mongoConfig.dbPort );
			cursor = mongo.getDB( mongoConfig.dbName ).getCollection( mongoConfig.dbCollection ).find( {}, null, readAll );
		}
		
		// called when all results from the database are loaded
		public function readAll() : void {
			var documents : ArrayCollection = new ArrayCollection();
			for each( var reply : OpReply in cursor.replies ) {
				documents.addAll( new ArrayCollection( reply.documents ) );
			}
			dispatchMessage( MongoQueryEvent.getMongoReplyReceived( documents ) );
		}
	}
}