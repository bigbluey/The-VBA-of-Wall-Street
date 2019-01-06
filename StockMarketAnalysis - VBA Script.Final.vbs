' Unit 2 | Assignment - The VBA of Wall Street
Sub StockMarketAnalysis():

    ' Loop / Iterate Through All Worksheets
    For Each ws In Worksheets

        ' Column Headers / Data Field Labels
        ws.Range("I1").Value = "Ticker"
        ws.Range("J1").Value = "Yearly Change"
        ws.Range("K1").Value = "Percent Change"
        ws.Range("L1").Value = "Total Stock Volume"
        ws.Range("O2").Value = "Greatest % Increase"
        ws.Range("O3").Value = "Greatest % Decrease"
        ws.Range("O4").Value = "Greatest Total Volume"
        ws.Range("P1").Value = "Ticker"
        ws.Range("Q1").Value = "Value"

        ' Set/Declare Initial Variables And Set Default/Baseline Variables
        Dim TickerName As String
        Dim LastRow As Long
        Dim TotalTickerVolume As Double
        TotalTickerVolume = 0
        Dim SummaryTableRow As Long
        SummaryTableRow = 2
        Dim YearlyOpen As Double
        Dim YearlyClose As Double
        Dim YearlyChange As Double
        Dim PreviousAmount As Long
        PreviousAmount = 2
        Dim PercentChange As Double
        Dim GreatestIncrease As Double
        GreatestIncrease = 0
        Dim GreatestDecrease As Double
        GreatestDecrease = 0
        Dim LastRowValue As Long
        Dim GreatestTotalVolume As Double
        GreatestTotalVolume = 0

        ' Determine the Last Row
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        For i = 2 To LastRow

            ' Add To Ticker Total Volume
            TotalTickerVolume = TotalTickerVolume + ws.Cells(i, 7).Value
            ' Check If We Are Still Within The Same Ticker Name If It Is Not...
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

' ### Easy ###

                ' Set Ticker Name
                TickerName = ws.Cells(i, 1).Value
                ' Print The Ticker Name In The Summary Table
                ws.Range("I" & SummaryTableRow).Value = TickerName
                ' Print The Ticker Total Amount To The Summary Table
                ws.Range("L" & SummaryTableRow).Value = TotalTickerVolume
                ' Reset Ticker Total
                TotalTickerVolume = 0

' ### Moderate ###

                ' Set Yearly Open, Yearly Close and Yearly Change Name
                YearlyOpen = ws.Range("C" & PreviousAmount)
                YearlyClose = ws.Range("F" & i)
                YearlyChange = YearlyClose - YearlyOpen
                ws.Range("J" & SummaryTableRow).Value = YearlyChange

                ' Determine Percent Change
                If YearlyOpen = 0 Then
                    PercentChange = 0
                Else
                    YearlyOpen = ws.Range("C" & PreviousAmount)
                    PercentChange = YearlyChange / YearlyOpen
                End If
                ' Format Double To Include % Symbol And Two Decimal Places
                ws.Range("K" & SummaryTableRow).NumberFormat = "0.00%"
                ws.Range("K" & SummaryTableRow).Value = PercentChange

                ' Conditional Formatting Highlight Positive (Green) / Negative (Red)
                If ws.Range("J" & SummaryTableRow).Value >= 0 Then
                    ws.Range("J" & SummaryTableRow).Interior.ColorIndex = 4
                Else
                    ws.Range("J" & SummaryTableRow).Interior.ColorIndex = 3
                End If
            
                ' Add One To The Summary Table Row
                SummaryTableRow = SummaryTableRow + 1
                PreviousAmount = i + 1
                End If
            Next i

' ### Hard ###

            ' Greatest % Increase, Greatest % Decrease and Greatest Total Volume
            LastRow = ws.Cells(Rows.Count, 11).End(xlUp).Row
        
            ' Start Loop For Final Results
            For i = 2 To LastRow
                If ws.Range("K" & i).Value > ws.Range("Q2").Value Then
                    ws.Range("Q2").Value = ws.Range("K" & i).Value
                    ws.Range("P2").Value = ws.Range("I" & i).Value
                End If

                If ws.Range("K" & i).Value < ws.Range("Q3").Value Then
                    ws.Range("Q3").Value = ws.Range("K" & i).Value
                    ws.Range("P3").Value = ws.Range("I" & i).Value
                End If

                If ws.Range("L" & i).Value > ws.Range("Q4").Value Then
                    ws.Range("Q4").Value = ws.Range("L" & i).Value
                    ws.Range("P4").Value = ws.Range("I" & i).Value
                End If

            Next i
        ' Format Double To Include % Symbol And Two Decimal Places
            ws.Range("Q2").NumberFormat = "0.00%"
            ws.Range("Q3").NumberFormat = "0.00%"
            
        ' Format Table Columns To Auto Fit
        ws.Columns("I:Q").AutoFit

    Next ws

End Sub