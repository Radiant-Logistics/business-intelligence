let
    Source = Excel.Workbook(File.Contents("Z:\TLA\source-data\SAPTM\Cost.xlsx"), null, true),
    ALL_Table = Source{[Item="ALL",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(ALL_Table,{{"House Bill Number", type text}, {"Station Name", type text}, {"Transportation Mode", type text}, {"Posted Date", type date}, {"Vendor", type text}, {"Amount", type number}, {"Currency", type text}, {"Cost Type", type text}, {"FWO", type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each [FWO] <> null and [FWO] <> "")
in
    #"Filtered Rows"