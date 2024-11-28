// transformed data for report/power pivot 
let
    Source = Excel.Workbook(File.Contents("Z:\TLA\source-data\SAPTM\Revenue.xlsx"), null, true),
    Revenue_Table = Source{[Item="Revenue",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Revenue_Table,{{"House Bill Number", Int64.Type}, {"Station Name", type text}, {"Transportation Mode", type text}, {"Bill To Party ID", Int64.Type}, {"Bill To Party Name", type text}, {"Invoice Number", Int64.Type}, {"Invoice Date", type date}, {"Posted Date", type date}, {"Posted Time", type datetime}, {"Posted TZ", type text}, {"Gross", type number}, {"Gross Currency", type text}, {"Document Type", type text}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Changed Type",{"House Bill Number", "Station Name", "Transportation Mode", "Bill To Party ID", "Bill To Party Name", "Invoice Number", "Invoice Date", "Posted Date", "Posted Time", "Posted TZ", "Gross", "Gross Currency", "Document Type"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Reordered Columns",{{"Posted Time", type time}, {"FWO", type text}, {"House Bill Number", type text}, {"Bill To Party ID", type text}, {"Invoice Number", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type1",{{"Gross", "Gross Revenue"}})
in
    #"Renamed Columns"