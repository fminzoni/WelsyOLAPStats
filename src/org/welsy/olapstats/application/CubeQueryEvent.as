package org.welsy.olapstats.application
{
	import flash.events.Event;

	public class CubeQueryEvent extends Event
	{
		public static const CUBE_QUERY_SUCCESS : String = "cubeQuerySuccess";
		public static const CUBE_QUERY_FAULT : String = "cubeQueryFault";
		
		public var result : Object;
		
		/**
		 * @brief Create a new CubeQueryEvent
		 * @param type CUBE_QUERY_SUCCESS or CUBE_QUERY_FAULT
		 * @param result The result object produced by the cube query
		 */
		public function CubeQueryEvent( type : String, result : Object )
		{
			super( type );
			this.result = result;
		}
		
		/**
		 * @brief Produce a CubeQueryEvent representing success
		 * @param result The result object produced by the cube query
		 * @return A CubeQueryEvent representing success
		 */
		public static function getCubeQuerySuccess( result : Object ) : CubeQueryEvent {
			return new CubeQueryEvent( CUBE_QUERY_SUCCESS, result );
		}
		
		/**
		 * @brief Produce a CubeQueryEvent representing failure
		 * @param result The result object produced by the cube query
		 * @return A CubeQueryEvent representing failure
		 */
		public static function getCubeQueryFault( result : Object ) : CubeQueryEvent {
			return new CubeQueryEvent( CUBE_QUERY_FAULT, result );
		}
	}
}