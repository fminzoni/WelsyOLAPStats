package org.welsy.olapstats.application
{
	import mx.controls.Alert;
	import mx.events.CubeEvent;
	import mx.olap.IOLAPResult;
	import mx.olap.OLAPCube;
	
	import org.welsy.olapstats.infrastructure.CubeQuery;
	import org.welsy.olapstats.presentation.OlapGridModel;

	public class CubeHandler
	{
		
		[Inject] [Bindable] public var model : OlapGridModel;
		[Inject] public var cubeQuery : CubeQuery;
		
		/**
		 * @brief Handler for CubeEvents
		 * @param event The CubeEvent to be analyzed
		 */
		[MessageHandler] public function cubeHandler( event : CubeEvent ) : void {
			// query the cube
			cubeQuery.queryCube( event.target as OLAPCube );
		}
		
		/**
		 * @brief Handler for CubeQueryEvents
		 * @param event The CubeQueryEvent to be analyzed
		 */
		[MessageHandler] public function cubeQueryHandler( event : CubeQueryEvent ) : void {
			switch( event.type ) {
				case CubeQueryEvent.CUBE_QUERY_SUCCESS:

					// update the results in the view
					model.results = event.result as IOLAPResult;
					break;
				
				case CubeQueryEvent.CUBE_QUERY_FAULT:
					
					// report the failure
					Alert.show( "OLAP query failed", "Error" );
					break;
				
				default:
					// should never happen
					trace( "CubeHandler:cubeQueryHandler: unknown event type" );
			}
		}
		
	}
}