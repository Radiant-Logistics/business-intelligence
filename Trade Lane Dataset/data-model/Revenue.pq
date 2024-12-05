let
    Source = Folder.Files("\\dev-fsx\BI-Data-Prod\tla\source-data\saptm"),
    #"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Revenue xlsx" = Source{[#"Folder Path"="\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\",Name="Revenue.xlsx"]}[Content],
    #"Imported Excel Workbook" = Excel.Workbook(#"\\dev-fsx\BI-Data-Prod\tla\source-data\saptm\_Revenue xlsx"),
    Revenue_Table = #"Imported Excel Workbook"{[Item="Revenue",Kind="Table"]}[Data]
in
    Revenue_Table