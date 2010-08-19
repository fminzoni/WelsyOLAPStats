package org.welsy.olapstats.application
{
	import org.welsy.olapstats.domain.AppInit;

	public class InitHandler
	{
		
		[Inject] public var appInit : AppInit;
		
		[MessageHandler] public function initHandler( event : InitEvent ) : void {
			// set up the system
			appInit.initEnvironment();
		}
	}
}