let
    Source = Folder.Files("\\dev-fsx\BI-Data-Prod\tla\source-data\saptm"),
    #"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Shipment xlsx" = Source{[#"Folder Path"="\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\",Name="Shipment.xlsx"]}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(#"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Shipment xlsx"),
    shipments_Table = #"Imported Excel Workbook"{[Item="shipments",Kind="Table"]}[Data],
    #"Filtered Rows" = Table.SelectRows(shipments_Table, each [Document] <> null and [Document] <> "")
in
    #"Filtered Rows"