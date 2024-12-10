let
    Source = Table.Combine({#"Agent Stations", #"Company Stations"}),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Type", "Region"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Station", type text}, {"Address", type text}}),
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
    #"Renamed Columns1" = Table.RenameColumns(#"Changed Type2",{{"EMAIL", "Email"}, {"MANAGER/OWNER", "Name"}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Renamed Columns1",{"Name", "Email", "Station", "Region", "Brand"}),
    #"Sorted Rows" = Table.Sort(#"Removed Other Columns",{{"Name", Order.Ascending}}),
    #"Trimmed Text" = Table.TransformColumns(#"Sorted Rows",{{"Name", Text.Trim, type text}, {"Email", Text.Trim, type text}, {"Station", Text.Trim, type text}, {"Region", Text.Trim, type text}, {"Brand", Text.Trim, type text}}),
    #"Cleaned Text" = Table.TransformColumns(#"Trimmed Text",{{"Name", Text.Clean, type text}, {"Email", Text.Clean, type text}, {"Station", Text.Clean, type text}, {"Region", Text.Clean, type text}, {"Brand", Text.Clean, type text}}),
    #"Removed Duplicates" = Table.Distinct(#"Cleaned Text"),
    #"Added Index" = Table.AddIndexColumn(#"Removed Duplicates", "Index", 1, 1, Int64.Type),
    #"Renamed Columns2" = Table.RenameColumns(#"Added Index",{{"Index", "ID"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns2",{"ID", "Name", "Email", "Station", "Region", "Brand"})
in
    #"Reordered Columns"