'Create Excel App Instance & Open Xlsm File
Set objExcelApp = CreateObject("Excel.Application")
objExcelApp.Visible = True
objExcelApp.DisplayAlerts = False

'Define Macro File & Path
sFilePathXlsm = "D:\Users\npham.exo\OneDrive - Radiant Global Logistics\Desktop\scripts\Refresh.xlsm"
Set iWb = objExcelApp.Workbooks.Open(sFilePathXlsm)

'1. Run 1st Macro in another Excel
sMacroToRun = "'" & sFilePathXlsm & "'!RefreshAllWorkbooks"
objExcelApp.Run sMacroToRun

'Save & Close file
iWb.Save
iWb.Close
objExcelApp.DisplayAlerts = True
objExcelApp.Quit