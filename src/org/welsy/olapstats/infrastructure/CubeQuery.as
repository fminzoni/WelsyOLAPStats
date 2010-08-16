package org.welsy.olapstats.infrastructure
{
	import mx.olap.IOLAPQuery;
	import mx.olap.OLAPCube;
	import mx.olap.OLAPQuery;
	import mx.olap.OLAPSet;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	
	import org.welsy.olapstats.application.CubeQueryEvent;

	public class CubeQuery
	{
		
		[MessageDispatcher] public var dispatchMessage : Function;
			
		/**
		 * @brief Set up an OLAP cube query
		 * @param cube The OLAP cube to be queried
		 */
		public function queryCube( cube : OLAPCube ) : void {
			var query : IOLAPQuery = new OLAPQuery();
			
			var countrySet : OLAPSet = new OLAPSet();
			countrySet.addElements( cube.findDimension( "CountryDim" ).findAttribute( "Country" ).children );
			var categorySet : OLAPSet = new OLAPSet();
			categorySet.addElements( cube.findDimension( "CategoryDim" ).findAttribute( "Category" ).children );
			var targetSet : OLAPSet = new OLAPSet();
			targetSet.addElements( cube.findDimension( "TargetDim" ).findAttribute( "Target" ).children );
			
			query.getAxis( OLAPQuery.ROW_AXIS ).addSet( countrySet );
			query.getAxis( OLAPQuery.COLUMN_AXIS ).addSet( categorySet );
			query.getAxis( OLAPQuery.COLUMN_AXIS ).addSet( targetSet );
			
			// execute the query and assign event handlers
			var token : AsyncToken = cube.execute( query );
			token.addResponder( new AsyncResponder( cubeQuerySuccess, cubeQueryFault ) );
		}
			
		public function cubeQuerySuccess( result : Object, token : Object ) : void {
			dispatchMessage( CubeQueryEvent.getCubeQuerySuccess( result ) );
		}
		
		public function cubeQueryFault( result : FaultEvent, token : Object ) : void {
			dispatchMessage( CubeQueryEvent.getCubeQueryFault( result ) );
		}
	}
}