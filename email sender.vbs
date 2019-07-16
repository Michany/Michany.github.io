Sub CopyEmailAddressOneByOne()

Set Wb = ThisWorkbook
Set Ws = Wb.Sheets(1)

' 获取整个表格的行数和列数
col_count = Wb.Sheets(1).UsedRange.Columns.Count
row_count = Wb.Sheets(1).UsedRange.Rows.Count - 1

' 获取当前单元格的行数和列数
curCol = ActiveCell.Column
curRow = ActiveCell.Row

' 选中Email这一列的第一个格子
emailAddList = ActiveCell.Text
If emailAddList <> "" Or emailAddList <> "0" Then '如果邮箱地址不为空
    Debug.Print "已添加收件人：" & emailAddList
    
    ' 查看分析师姓名是否有CFA结尾
    analyst = ThisWorkbook.Sheets(1).Cells(curRow, 9).Text
    iloc = InStr(1, analyst, ",")
    If iloc > 0 Then
        analyst = Mid(analyst, 1, iloc - 1)
    End If
    Debug.Print "已添加抄送人：", analyst
    
    ' 在邮件主题处添加公司名称
    Space_pos = InStr(ThisWorkbook.Sheets(1).Cells(curRow, 4).Text, " ")
    receiver1 = Mid(ThisWorkbook.Sheets(1).Cells(curRow, 4).Text, 1, Space_pos - 1)
    
    template = Range("V1").Text
    
    Set OutlookApp = CreateObject("outlook.Application")
    Set NewMailFromTemplate = OutlookApp.createItemfromtemplate(template)
    
    With NewMailFromTemplate
    .To = emailAddList
    .cc = analyst
    .Subject = "Hi " & receiver1 & " - " & .Subject
    .HTMLBody = Replace(.HTMLBody, "xx", receiver1)
    .display
    End With
    'Call UseOutlookTemplate(emailAddList, analyst, companyName, receiver1, template)
    
End If

' 向下移动一格。如果下一个格子address为空，就一直向下移动，直到找到非空的格子
ActiveCell.Offset(1, 0).Activate
While (ActiveCell.Text = "" Or ActiveCell.Text = "0") And ActiveCell.Row < row_count + 1
    companyName = Cells(ActiveCell.Row, 6).Text
    alarm = MsgBox(companyName & "：该公司邮箱缺失。" & _
                Chr(10) & "将自动跳到下一个公司", vbCritical, "目标公司邮箱缺失 （请手动发送）")
    ActiveCell.Offset(1, 0).Activate
Wend
End Sub


Sub FilePicker()

'新建一个对话框对象

Set FileDialogObject = Application.FileDialog(msoFileDialogFilePicker)

'配置对话框

With FileDialogObject

    .Title = "请选择邮件模板"

    .InitialFileName = ThisWorkbook.Path

    .AllowMultiSelect = False

End With

'显示对话框

FileDialogObject.Show

'获取选择对话框选择的文件

Set template_paths = FileDialogObject.SelectedItems

If template_paths.Count > 0 Then
    Debug.Print template_paths(1)
    alarm = MsgBox("邮件模板选定成功！文件地址：" & Chr(10) & _
                template_paths(1) & Chr(10) & "程序将自动获取Email所在的列，并选中第一条记录", vbOKOnly, "邮件模板")
    Range("V1").Value = template_paths(1)
Else
    alarm = MsgBox("未选择模板！请再次点击选择模板。", vbCritical, "邮件模板")
End If

' 获取Email所在列，并且锁定第一条记录
Set Wb = ThisWorkbook
For i = 1 To Wb.Sheets(1).UsedRange.Columns.Count
    If Cells(1, i).Text = "Email" Or Cells(2, i).Text = "email" Then
        Cells(2, i).Select
        Exit For
    End If
Next

End Sub



Public Function IsChinese(str As String)
str = "[\u4e00-\u9fa5]"

End Function
