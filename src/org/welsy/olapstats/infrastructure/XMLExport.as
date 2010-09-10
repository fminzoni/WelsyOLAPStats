package org.welsy.olapstats.infrastructure
{
	import mx.olap.IOLAPAxisPosition;
	import mx.olap.IOLAPMember;
	import mx.olap.IOLAPResult;
	import mx.olap.IOLAPResultAxis;
	import mx.olap.OLAPQuery;
	
	import org.welsy.olapstats.ExcelConfig;

	public class XMLExport
	{
		
		private static const declaration : String = "<?xml version=\"1.0\"?>\n<?mso-application progid=\"Excel.Sheet\"?>\n";
		
		private static const openXml : String =
<![CDATA[
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
		  xmlns:o="urn:schemas-microsoft-com:office:office"
		  xmlns:x="urn:schemas-microsoft-com:office:excel"
		  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		  xmlns:html="http://www.w3.org/TR/REC-html40">

	<Styles>
					
		<Style ss:ID="Default" ss:Name="Normal">
			<Alignment ss:Vertical="Bottom"/>
			<Borders/>
			<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>
			<Interior/>
			<NumberFormat/>
			<Protection/>
		</Style>
					
		<Style ss:ID="bold">
			<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000" ss:Bold="1"/>
		</Style>
				
	</Styles>
			 
	<Worksheet ss:Name="WelsyStats">
]]>;
		
		//<Table ss:ExpandedColumnCount="2" ss:ExpandedRowCount="2" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="15">
		//	<Row ss:AutoFitHeight="0">
		//		<Cell ss:StyleID="bold"><Data ss:Type="String">title0</Data></Cell>
		//		<Cell ss:StyleID="bold"><Data ss:Type="String">title1</Data></Cell>
		//	</Row>
		//	<Row ss:AutoFitHeight="0">
		//		<Cell><Data ss:Type="String">value0</Data></Cell>
		//		<Cell><Data ss:Type="String">value1</Data></Cell>
		//	</Row>
		
		private static const closeXml : String = <![CDATA[
		</Table>
				
	</Worksheet>
			
</Workbook>
]]>;

		
		public static function exportXML( olap : IOLAPResult ) : String {			
			
			var rowAxis : IOLAPResultAxis = olap.getAxis( OLAPQuery.ROW_AXIS );
			var colAxis : IOLAPResultAxis = olap.getAxis( OLAPQuery.COLUMN_AXIS );
			
			// array with the rows
			var xmlRows : Array = new Array();
			var k : int = 0;
			
			// retrieve the table header
			for each( var col : IOLAPAxisPosition in colAxis.positions ) {
				k = 0;
				for each( var col_member : IOLAPMember in col.members ) {
					var xmlHCell : String = '\t\t\t\t<Cell ss:StyleID="bold"><Data ss:Type="String">' + col_member.name + '</Data></Cell>\n';
					if( xmlRows.length <= k  ) { // add the cell in a new row
						// spacer cell
						var spacerCell : String = '\t\t\t\t<Cell><Data ss:Type="String"></Data></Cell>\n';
						xmlRows.push( spacerCell + xmlHCell );
					} else { // append the cell to an existing row
						xmlRows[k] += xmlHCell;
					}
					++k;
				}
			}
			
			var i : int = 0;
			var j : int = 0;
			// retrieve row names and cell values
			for each( var row : IOLAPAxisPosition in rowAxis.positions ) {
				for each( var row_member : IOLAPMember in row.members ) {
					var xmlRowName : String = '\t\t\t\t<Cell ss:StyleID="bold"><Data ss:Type="String">' + row_member.name + '</Data></Cell>\n';
					xmlRows.push( xmlRowName );
					for( j = 0; j < colAxis.positions.length; ++j ) {
						var xmlValue : String;
						if( isNaN( olap.getCell( i, j ).value ) ) {
							xmlValue = '\t\t\t\t<Cell><Data ss:Type="String">' + olap.getCell( i, j ).value + '</Data></Cell>\n';
						} else {
							xmlValue = '\t\t\t\t<Cell><Data ss:Type="Number">' + olap.getCell( i, j ).value + '</Data></Cell>\n';
						}
						xmlRows[k] += xmlValue;
					}
				}
				++i;
				++k;
			}
			
			var finalXml : String;
			finalXml = declaration;
			finalXml += openXml;
			finalXml += '\t\t<Table ss:ExpandedColumnCount="' + (j+1) + '" ss:ExpandedRowCount="' + k + '" x:FullColumns="1" x:FullRows="1">\n\n';
			
			// set the column width
			finalXml += '\t\t\t<Column ss:AutoFitWidth="0" ss:Width="' + ExcelConfig.titleCellWidth + '"/>\n';
			for( var t : int = 0; t < j; ++t ) {
				finalXml += '\t\t\t<Column ss:AutoFitWidth="0" ss:Width="' + ExcelConfig.valueCellWidth + '"/>\n';
			}
			
			// create the row delimiters
			for each( var line : String in xmlRows ) {
				finalXml += '\t\t\t<Row ss:AutoFitHeight="0">\n';
				finalXml += line;
				finalXml += '\t\t\t</Row>\n';
			}
			
			finalXml += closeXml;
			
			return finalXml;
		}
	}
}