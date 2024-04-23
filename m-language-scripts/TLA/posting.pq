let
    Source = SharePoint.Files("https://radiantdelivers.sharepoint.com/sites/AsEasyAsECC/", [ApiVersion = 15]),
    #"Filtered Rows" = Table.SelectRows(Source, each [Folder Path] = "https://radiantdelivers.sharepoint.com/sites/AsEasyAsECC/Shared Documents/Dashboards/TLA/Source/Posting/"),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Rows",{"Name", "Extension", "Date accessed", "Date modified", "Date created", "Attributes", "Folder Path"}),
    #"Filtered Hidden Files1" = Table.SelectRows(#"Removed Columns", each [Attributes]?[Hidden]? <> true),
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File", each #"Transform File"([Content])),
    #"Removed Other Columns1" = Table.SelectColumns(#"Invoke Custom Function1", {"Transform File"}),
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File", Table.ColumnNames(#"Transform File"(#"Sample File"))),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Table Column1",{{"House Bill Number", Int64.Type}, {"Station Name", type text}, {"Transportation Mode", type text}, {"Bill To Party ID", Int64.Type}, {"Bill To Party Name", type text}, {"Invoice Number", Int64.Type}, {"Invoice Date", type date}, {"Posted Date", type text}, {"Gross", type number}, {"Gross Currency", type text}, {"Document Type", type text}, {"MAWB", type text}, {"LH Vendor", type text}, {"LH Amount", type text}, {"LH Currency", type text}, {"PU Vendor", type text}, {"PU Amount", type text}, {"PU Currency", type text}, {"DL Vendor", type text}, {"DL Amount", type text}, {"DL Currency", type text}, {"Misc Vendor", type text}, {"Misc Amount", type text}, {"Misc Currency", type any}, {"Station", type number}, {"Station Currency", type text}, {"G&A", type number}, {"G&A Currency", type text}, {"Variance", type text}, {"Total Variance", type text}})
in
    #"Changed Type"