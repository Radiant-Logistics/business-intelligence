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
    #"Sorted Rows" = Table.Sort(#"Renamed Columns1",{{"Name", Order.Ascending}}),
    #"Filtered Rows1" = Table.SelectRows(#"Sorted Rows", each ([Region] = null)),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows1",{"Region", "Brand"}),
    #"Added Conditional Column" = Table.AddColumn(#"Removed Columns", "Region", each if [Name] = "A63" then "Company Stores" else if [Name] = "ORD" then "Central" else if Text.StartsWith([Name], "R") then "Company Stores" else if [Name] = "S42MSP" then "Central" else if [Name] = "S54ATL" then "East" else null),
    #"Added Conditional Column1" = Table.AddColumn(#"Added Conditional Column", "Brand", each if [Name] = "A63" then "RGL" else if [Name] = "ORD" then "AGE" else if Text.StartsWith([Name], "R") then "RGL" else if Text.StartsWith([Name], "S") then "SBA" else null)
in
    #"Added Conditional Column1"