let
    Source = SharePoint.Files("https://radiantdelivers.sharepoint.com/sites/AsEasyAsECC", [ApiVersion = 15]),
    #"Filtered Rows" = Table.SelectRows(Source, each ([Folder Path] = "https://radiantdelivers.sharepoint.com/sites/AsEasyAsECC/Shared Documents/Dashboards/Data/RLS/")),
    #"Filtered Rows1" = Table.SelectRows(#"Filtered Rows", let latest = List.Max(#"Filtered Rows"[Date created]) in each [Date created] = latest),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows1",{"Content"}),
    #"Filtered Hidden Files1" = Table.SelectRows(#"Removed Other Columns", each [Attributes]?[Hidden]? <> true),
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File (3)", each #"Transform File (3)"([Content])),
    #"Removed Other Columns1" = Table.SelectColumns(#"Invoke Custom Function1", {"Transform File (3)"}),
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File (3)", Table.ColumnNames(#"Transform File (3)"(#"Sample File (3)"))),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Table Column1",{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}}),
    #"Promoted Headers" = Table.PromoteHeaders(#"Changed Type", [PromoteAllScalars=true]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Promoted Headers",{{"Contacts[Name]", type text}, {"Contacts[Email]", type text}, {"Contacts[Station]", type text}, {"Contacts[Region]", type text}, {"Contacts[Brand]", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type1",{{"Contacts[Name]", "Name"}, {"Contacts[Email]", "Email"}, {"Contacts[Station]", "Station"}, {"Contacts[Region]", "Region"}, {"Contacts[Brand]", "Brand"}}),
    #"Added Index" = Table.AddIndexColumn(#"Renamed Columns", "Index", 1, 1, Text.Type),
    #"Reordered Columns" = Table.ReorderColumns(#"Added Index",{"Index", "Name", "Email", "Station", "Region", "Brand"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Reordered Columns",{{"Index", "ID"}})
in
    #"Renamed Columns1"