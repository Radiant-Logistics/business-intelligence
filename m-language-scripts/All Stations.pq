let
    Source = Table.Combine({AgentStations, CompanyStations}),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Type", "Region"}}),
    #"Sorted Rows" = Table.Sort(#"Renamed Columns",{{"Region", Order.Ascending}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Sorted Rows",{{"Station", type text}, {"Address", type text}}),
    #"Replaced Value5" = Table.ReplaceValue(#"Changed Type","62/67MCO","A62MCO",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value6" = Table.ReplaceValue(#"Replaced Value5","12BUR","BUR",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value7" = Table.ReplaceValue(#"Replaced Value6","16LAS","LAS",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value8" = Table.ReplaceValue(#"Replaced Value7","18SJU","SJU",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value9" = Table.ReplaceValue(#"Replaced Value8","21EUG","EUG",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value10" = Table.ReplaceValue(#"Replaced Value9","24CHS","CHS",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value12" = Table.ReplaceValue(#"Replaced Value10","25PHL","PHL",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value13" = Table.ReplaceValue(#"Replaced Value12","28PHX","PHX",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value14" = Table.ReplaceValue(#"Replaced Value13","30 MIA","MIA",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value15" = Table.ReplaceValue(#"Replaced Value14","33IAH","IAH",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value16" = Table.ReplaceValue(#"Replaced Value15","34ICT","ICT",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value17" = Table.ReplaceValue(#"Replaced Value16","45CVG ","CVG",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value18" = Table.ReplaceValue(#"Replaced Value17","48OGG","OGG",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value19" = Table.ReplaceValue(#"Replaced Value18","51DFW","DFW",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value20" = Table.ReplaceValue(#"Replaced Value19","54ATL","ATL",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value21" = Table.ReplaceValue(#"Replaced Value20","56TUL","TUL",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value22" = Table.ReplaceValue(#"Replaced Value21","57TPA","TPA",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value23" = Table.ReplaceValue(#"Replaced Value22","65MHT","MHT",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value24" = Table.ReplaceValue(#"Replaced Value23","67SJC","SJC",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value25" = Table.ReplaceValue(#"Replaced Value24","68MKE","MKE",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value26" = Table.ReplaceValue(#"Replaced Value25","69CMH","CMH",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value27" = Table.ReplaceValue(#"Replaced Value26","71MDT","MDT",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value28" = Table.ReplaceValue(#"Replaced Value27","7387","IND",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value29" = Table.ReplaceValue(#"Replaced Value28","77LAX","A77LAX",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value30" = Table.ReplaceValue(#"Replaced Value29","79OMA","AGEOMA",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value31" = Table.ReplaceValue(#"Replaced Value30","85STL","STL",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value33" = Table.ReplaceValue(#"Replaced Value31","BPHL","B25PHL",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value34" = Table.ReplaceValue(#"Replaced Value33","76LGB","LGB",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value35" = Table.ReplaceValue(#"Replaced Value34","DTW","A63",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value38" = Table.ReplaceValue(#"Replaced Value35","DAGEOMA","AGEOMA",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value39" = Table.ReplaceValue(#"Replaced Value38","MIA","MIAAGE",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value40" = Table.ReplaceValue(#"Replaced Value39","45CVG ","CVG",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value42" = Table.ReplaceValue(#"Replaced Value40","51DFW","DFW",Replacer.ReplaceValue,{"Station"}),
    #"Sorted Rows2" = Table.Sort(#"Replaced Value42",{{"Station", Order.Ascending}}),
    #"Replaced Value36" = Table.ReplaceValue(#"Sorted Rows2","DA77LAX","D77LAX",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value37" = Table.ReplaceValue(#"Replaced Value36","DATL","D54ATL",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value41" = Table.ReplaceValue(#"Replaced Value37","RMDT","R71MDT",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value43" = Table.ReplaceValue(#"Replaced Value41","DPHL","D25PHL",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value44" = Table.ReplaceValue(#"Replaced Value43","DPHX","D28PHX",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value45" = Table.ReplaceValue(#"Replaced Value44","RPHX","R28PHX",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value46" = Table.ReplaceValue(#"Replaced Value45","B81BUR","B81LAX",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value32" = Table.ReplaceValue(#"Replaced Value46","ORD","R50ORD",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value47" = Table.ReplaceValue(#"Replaced Value32","SLAS","S16LAS",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value48" = Table.ReplaceValue(#"Replaced Value47","STPA","S57TPA",Replacer.ReplaceText,{"Station"}),
    #"Replaced Value49" = Table.ReplaceValue(#"Replaced Value48","SPHX","S28PHX",Replacer.ReplaceValue,{"Station"}),
    #"Replaced Value50" = Table.ReplaceValue(#"Replaced Value49","SSJU","S18SJU",Replacer.ReplaceValue,{"Station"}),
    #"Added Conditional Column" = Table.AddColumn(#"Replaced Value50", "Brand", each 
    if ([EMAIL] = null and Text.StartsWith([Name], "D")) then "DBA"
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
    #"Replaced Errors" = Table.ReplaceErrorValues(#"Added Conditional Column", {{"Brand", "RGL"}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Replaced Errors",{ {"Brand", type text}})
in
    #"Changed Type2"