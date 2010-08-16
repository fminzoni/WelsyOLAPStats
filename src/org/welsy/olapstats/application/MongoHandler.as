package org.welsy.olapstats.application
{
	import org.welsy.olapstats.infrastructure.MongoQuery;
	import org.welsy.olapstats.presentation.OlapGridModel;

	public class MongoHandler
	{
		
		[Inject] [Bindable] public var model : OlapGridModel;
		[Inject] public var mongoQuery : MongoQuery;
		
		/**
		 * @brief Handler for MongoEvents
		 * @param event The MongoEvent to be analyzed
		 */
		[MessageHandler] public function mongoHandler( event : MongoQueryEvent ) : void {
			
			switch( event.type ) {
				
				case MongoQueryEvent.MONGO_SEND_QUERY:
					// query the database
					mongoQuery.queryDB();
					break;
				
				case MongoQueryEvent.MONGO_REPLY_RECEIVED:
					// set the results
					model.documents = event.result;
					// refresh the OLAP view
					model.olapCube.refresh();
					break;
				
				default:
					// should never get here
					trace( "MongoHandler:mongoHandler: unknown event type" );
			}
		}
		
	}
}