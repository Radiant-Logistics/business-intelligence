let
    Source = Folder.Files("\\dev-fsx\BI-Data-Prod\tla\source-data\saptm"),
    #"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Cost xlsx" = Source{[#"Folder Path"="\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\",Name="Cost.xlsx"]}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(#"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Cost xlsx"),
    ALL_Table = #"Imported Excel Workbook"{[Item="ALL",Kind="Table"]}[Data],
    #"Merged Queries" = Table.NestedJoin(ALL_Table, {"Station Name"}, Contacts, {"Station"}, "Contacts", JoinKind.LeftOuter),
    #"Expanded Contacts" = Table.ExpandTableColumn(#"Merged Queries", "Contacts", {"ID"}, {"ContactID"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Contacts",{"Station Name", "Transportation Mode", "House Bill Number"})
in
    #"Removed Columns"