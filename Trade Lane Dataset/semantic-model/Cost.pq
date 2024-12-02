let
    Source = Folder.Files("\\dev-fsx\BI-Data-Prod\tla\source-data\saptm"),
    #"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Cost xlsx" = Source{[#"Folder Path"="\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\",Name="Cost.xlsx"]}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(#"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Cost xlsx"),
    ALL_Table = #"Imported Excel Workbook"{[Item="ALL",Kind="Table"]}[Data]
in
    ALL_Table