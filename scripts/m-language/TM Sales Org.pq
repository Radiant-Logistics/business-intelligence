let
    Source = SharePoint.Files("https://radiantdelivers.sharepoint.com/sites/AsEasyAsECC", [ApiVersion = 15]),
    #"Filtered Rows" = Table.SelectRows(Source, each ([Folder Path] = "https://radiantdelivers.sharepoint.com/sites/AsEasyAsECC/Shared Documents/Dashboards/TLA/Source/")),
    #"TM_Sales_Orgs xlsx_https://radiantdelivers sharepoint com/sites/AsEasyAsECC/Shared Documents/Dashboards/TLA/Source/" = #"Filtered Rows"{[Name="TM_Sales_Orgs.xlsx",#"Folder Path"="https://radiantdelivers.sharepoint.com/sites/AsEasyAsECC/Shared Documents/Dashboards/TLA/Source/"]}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(#"TM_Sales_Orgs xlsx_https://radiantdelivers sharepoint com/sites/AsEasyAsECC/Shared Documents/Dashboards/TLA/Source/"),
    #"Filtered Rows1" = Table.SelectRows(#"Imported Excel Workbook", each ([Name] = "Table1")),
    #"Expanded Data" = Table.ExpandTableColumn(#"Filtered Rows1", "Data", {"Name", "Code", "ID"}, {"Data.Name", "Data.Code", "Data.ID"}),
    #"Removed Other Columns" = Table.SelectColumns(#"Expanded Data",{"Data.ID", "Data.Code", "Data.Name"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Data.ID", "ID"}, {"Data.Code", "Plant"}, {"Data.Name", "Name"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"ID", type text}, {"Plant", type text}, {"Name", type text}}),
    #"Sorted Rows" = Table.Sort(#"Changed Type",{{"Name", Order.Ascending}})
in
    #"Sorted Rows"