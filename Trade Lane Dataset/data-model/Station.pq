let
    Source = SharePoint.Tables("https://radiantdelivers.sharepoint.com/sites/CartageTaskforce", [ApiVersion = 15]),
    #"2ec857d5-7c32-4a1a-b56a-d2ba81cbe396" = Source{[Id="2ec857d5-7c32-4a1a-b56a-d2ba81cbe396"]}[Items],
    #"Removed Other Columns" = Table.SelectColumns(#"2ec857d5-7c32-4a1a-b56a-d2ba81cbe396",{"Title"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"Title", "Agent"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Agent", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","RGLDTW (A63DTW / S63DTW)","AGEA63",Replacer.ReplaceText,{"Agent"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","Radiant# SBAPDX -127453, SBA #-883471","SBAPDX",Replacer.ReplaceText,{"Agent"})
in
    #"Replaced Value1"