package org.welsy.olapstats.presentation
{
	import flash.events.Event;
	import flash.net.FileReference;
	
	import org.welsy.olapstats.ExcelConfig;
	import org.welsy.olapstats.infrastructure.XMLExport;

	public class MenuBarModel
	{
		[Inject] public var olapGridModel : OlapGridModel;
		
		public function exportXML( event : Event ) : void {
			var xml : String = XMLExport.exportXML( olapGridModel.results );
			var file : FileReference = new FileReference();
			file.save( xml, ExcelConfig.getDefaultExportFilename() );
		}
		
	}
}