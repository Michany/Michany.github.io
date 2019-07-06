var date = $('#txtShareholdingDate').val() //"2019/06/30"
var date_num = date.replace(/\//g,'')
// 用JQuery修改日期
//$('#txtShareholdingDate').val(date)
// 用JQuery点击Search按钮
//$('#btnSearch').click()
// 用JQuery查找网页中的mutualmarket-result元素，然后展开其下的tboday, tr, td标签元素，获取第i个子元素，得到一个表单元格；再展开div元素，
// 修改td:nth-child(3)中的数字即可
var arr1 = $('#mutualmarket-result tbody tr td:nth-child(1) div:nth-child(2)').map(function(){return $(this).text()}).get()
var arr2 = $('#mutualmarket-result tbody tr td:nth-child(2) div:nth-child(2)').map(function(){return $(this).text()}).get()
var arr3 = $('#mutualmarket-result tbody tr td:nth-child(3) div:nth-child(2)').map(function(){return $(this).text()}).get()
var arr4 = $('#mutualmarket-result tbody tr td:nth-child(4) div:nth-child(2)').map(function(){return $(this).text()}).get()
// 将四个数组存成一个二维数组arr，然后转置一下
var arr = new Array(arr1, arr2, arr3, arr4)
var newArray = arr[0].map(function(col, i) {
      return arr.map(function(row) {
      return row[i];
      })
});
var csvRows = [];
for(var i=0, l=newArray.length; i<l; ++i){
    csvRows.push(newArray[i].join('|'));
}
var csvString = csvRows.join("\n");
// 保存到csv文件,文件名为 "日期.csv"
if (window.navigator.msSaveOrOpenBlob) {
    var blob = new Blob([csvString]);
    window.navigator.msSaveOrOpenBlob(blob, date_num+'.csv');
} else {
var csvString = csvRows.join("\n");
var a         = document.createElement('a');
a.href        = 'data:attachment/csv,' +  encodeURIComponent(csvString);
a.target      = '_blank';
a.download    = date_num+'.csv';
document.body.appendChild(a);
a.click();
}

