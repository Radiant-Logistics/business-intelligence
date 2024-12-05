let
    Source = Folder.Files("\\dev-fsx\BI-Data-Prod\tla\source-data\saptm"),
    #"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Shipment xlsx" = Source{[#"Folder Path"="\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\",Name="Shipment.xlsx"]}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(#"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Shipment xlsx"),
    shipments_Table = #"Imported Excel Workbook"{[Item="shipments",Kind="Table"]}[Data],
    #"Filtered Rows" = Table.SelectRows(shipments_Table, each [Document] <> null and [Document] <> ""),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows",{"Station name"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Station name", "Station"}}),
    #"Removed Duplicates" = Table.Distinct(#"Renamed Columns"),
    #"Merged Queries" = Table.NestedJoin(#"Removed Duplicates", {"Station"}, #"All Stations", {"Station"}, "AllStations", JoinKind.LeftOuter),
    #"Expanded AllStations" = Table.ExpandTableColumn(#"Merged Queries", "AllStations", {"Region", "Brand"}, {"Region", "Brand"}),
    #"Removed Duplicates1" = Table.Distinct(#"Expanded AllStations", {"Station"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Duplicates1",{{"Station", "Name"}}),
    #"Filtered Rows1" = Table.SelectRows(#"Renamed Columns1", each [Region] <> null and [Region] <> ""),
    #"Appended Query" = Table.Combine({#"Filtered Rows1", Blanks}),
    #"Sorted Rows" = Table.Sort(#"Appended Query",{{"Name", Order.Ascending}})
in
    #"Sorted Rows"