package org.welsy.olapstats.domain
{
	import flash.profiler.showRedrawRegions;
	import flash.system.Security;
	
	import mx.controls.Alert;
	
	import org.welsy.olapstats.MongoConfig;
	import org.welsy.olapstats.application.MongoQueryEvent;

	public class AppInit
	{
		
		[MessageDispatcher] public var dispatchMessage : Function;
		
		[Inject] public var mongoConfig : MongoConfig;
		
		
		/**
		 * @brief Init the entire app environment
		 */
		public function initEnvironment() : void {
			// load the crossdomain policy
			// to gain access to Mongo
			obtainCrossdomain();
			
			// query the server for data
			dispatchMessage( MongoQueryEvent.getMongoSendQuery() );
		}
		
		/**
		 * @brief Load the cross-domain policy file
		 */
		public function obtainCrossdomain() : void {
			Security.loadPolicyFile( mongoConfig.crossdomainPolicyURL );
		}
		
	}
}