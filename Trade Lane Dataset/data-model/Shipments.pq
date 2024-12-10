let
    Source = Folder.Files("\\dev-fsx\BI-Data-Prod\tla\source-data\saptm"),
    #"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Shipment xlsx" = Source{[#"Folder Path"="\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\",Name="Shipment.xlsx"]}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(#"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Shipment xlsx"),
    shipments_Table = #"Imported Excel Workbook"{[Item="shipments",Kind="Table"]}[Data],
    #"Filtered Rows" = Table.SelectRows(shipments_Table, each [Document] <> null and [Document] <> ""),
    #"Merged Queries" = Table.NestedJoin(#"Filtered Rows", {"Station name"}, Contacts, {"Station"}, "Contacts", JoinKind.LeftOuter),
    #"Expanded Contacts" = Table.ExpandTableColumn(#"Merged Queries", "Contacts", {"ID"}, {"ContactID"}),
    #"Removed Duplicates" = Table.Distinct(#"Expanded Contacts", {"Document"}),
    #"Merged Queries1" = Table.NestedJoin(#"Removed Duplicates", {"Station name"}, Stations, {"Name"}, "Stations", JoinKind.LeftOuter),
    #"Expanded Stations" = Table.ExpandTableColumn(#"Merged Queries1", "Stations", {"StationID"}, {"StationID"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Stations",{"Station name"})
in
    #"Removed Columns"