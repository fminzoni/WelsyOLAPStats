package org.welsy.olapstats.presentation
{
	
	import mx.collections.ArrayCollection;
	import mx.events.CubeEvent;
	import mx.olap.IOLAPResult;
	import mx.olap.OLAPCube;
	
	public class OlapGridModel
	{
		
		[MessageDispatcher] public var dispatchMessage : Function;
		
		[Bindable] public var olapCube : OLAPCube;
		
		// results from the database
		[Bindable] public var documents : ArrayCollection;
		
		// results from an OLAP query
		[Bindable] public var results : IOLAPResult;
		
		/**
		 * @brief Dispatch an OLAP cube query event
		 * @param event OLAPCube.complete event
		 */
		public function queryCube( event : CubeEvent ) : void {
			dispatchMessage( event );
		}
	}
}