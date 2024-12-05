let
    Source = Table.Combine({#"Agent Stations", #"Company Stations"}),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Type", "Region"}}),
    #"Sorted Rows" = Table.Sort(#"Renamed Columns",{{"Region", Order.Ascending}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Sorted Rows",{{"Station", type text}, {"Address", type text}}),
    #"Added Conditional Column" = Table.AddColumn(#"Changed Type", "Brand", each 
    if ([Region] = "Company Stores") then "RGL"
    else if ([EMAIL] = null and Text.StartsWith([Name], "D")) then "DBA"
    else if ([EMAIL] = null and Text.StartsWith([Name], "B")) then "ADC"
    else if ([EMAIL] = null and Text.StartsWith([Name], "S")) then "SBA"
    else if ([EMAIL] = null and Text.StartsWith([Name], "R")) then "RGL"
    else if Text.Contains([EMAIL], "radiant") then "RGL"
    else if ([Region] = "Company Stores") then "RGL"
    else if Text.Contains([EMAIL], "airgroup") then "AGE"
    else if Text.Contains([EMAIL], "adcom") then "ADC"
    else if Text.Contains([EMAIL], "road") then "RGL"
    else if Text.Contains([EMAIL], "dba") then "DBA"
    else if Text.Contains([EMAIL], "sba") then "SBA"
    else null
),
    #"Changed Type2" = Table.TransformColumnTypes(#"Added Conditional Column",{ {"Brand", type text}}),
    #"Sorted Rows1" = Table.Sort(#"Changed Type2",{{"Station", Order.Ascending}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Sorted Rows1",{"Station", "EMAIL", "MANAGER/OWNER"}),
    #"Cleaned Text" = Table.TransformColumns(#"Removed Other Columns",{{"Station", Text.Clean, type text}, {"EMAIL", Text.Clean, type text}, {"MANAGER/OWNER", Text.Clean, type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Cleaned Text",{{"Station", Text.Trim, type text}, {"EMAIL", Text.Trim, type text}, {"MANAGER/OWNER", Text.Trim, type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Trimmed Text","Charlie Justice","Charles Justice",Replacer.ReplaceText,{"MANAGER/OWNER"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Replaced Value",{"Station", "MANAGER/OWNER", "EMAIL"}),
    #"Sorted Rows2" = Table.Sort(#"Reordered Columns",{{"MANAGER/OWNER", Order.Ascending}}),
    #"Removed Duplicates" = Table.Distinct(#"Sorted Rows2")
in
    #"Removed Duplicates"