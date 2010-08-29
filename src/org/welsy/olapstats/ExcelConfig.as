package org.welsy.olapstats
{
	public class ExcelConfig
	{
		/**
		 * Width of the cells in pixels
		 */
		public static var titleCellWidth : uint = 130;
		public static var valueCellWidth : uint = 100;
		
		/**
		 * @brief Return the default export filename
		 * @return The default export filename
		 * @warning This value can be overridden by the user
		 */
		public static function getDefaultExportFilename() : String {
			var date : Date = new Date();
			var day : String = date.getDate().toString();
			if( day.length < 2 ) {
				day = "0" + day;
			}
			var month : String = ( date.getMonth() + 1 ).toString();
			if( month.length < 2 ) {
				month = "0" + month;
			}
			var year : String = date.getFullYear().toString();
			return "welsyStats_" + year + "-" + month + "-" + day + ".xml";
		}
	}
}