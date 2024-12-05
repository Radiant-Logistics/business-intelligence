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
    #"Removed Other Columns" = Table.SelectColumns(#"Sorted Rows1",{"Brand", "Address", "Region", "Station", "Phone Number", "Local Number"}),
    #"Filtered Rows" = Table.SelectRows(#"Removed Other Columns", each ([Address] <> null)),
    #"Cleaned Text" = Table.TransformColumns(#"Filtered Rows",{{"Brand", Text.Clean, type text}, {"Address", Text.Clean, type text}, {"Region", Text.Clean, type text}, {"Station", Text.Clean, type text}, {"Phone Number", Text.Clean, type text}, {"Local Number", Text.Clean, type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Cleaned Text",{{"Brand", Text.Trim, type text}, {"Address", Text.Trim, type text}, {"Region", Text.Trim, type text}, {"Station", Text.Trim, type text}, {"Phone Number", Text.Trim, type text}, {"Local Number", Text.Trim, type text}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Trimmed Text",{"Station", "Brand", "Region", "Address", "Phone Number", "Local Number"})
in
    #"Reordered Columns"