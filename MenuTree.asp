<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <link href="styles/MenuTree.css" rel="stylesheet" />
    <script type="text/javascript">
        // just a workaround for IE backwards compatibility, otherwise uncomment the ".navig li:hover > ul" element in the css
        jQuery(document).ready(function () {
            jQuery(".navig li li").each(function () {
                if (jQuery(this).find('ul').length > 0) {    
                    jQuery(this).children('a:first-child').css('background', '#000 url("/images/right-arrow.gif") no-repeat right');
                }
            });
            jQuery('.navig li').hover(
                function () {
                    jQuery(this).children("ul").css('display', 'block');
                },
                function () {
                    jQuery(this).children("ul").css('display', 'none');
                }
                );
        });
    </script>
</head>
<body>
<% 
    Dim menuTree()
    ReDim Preserve menuTree(2, 5)
    'First Row
    menuTree(0, 0) = "Parameters" 'Display Name
    menuTree(1, 0) = "" 'Link (Unclickable since it is a logical parent)
    menuTree(2, 0) = 0 'TreeLevel
    'Second Row
    menuTree(0, 1) = "Parameter Entry" 'Display Name
    menuTree(1, 1) = "/ParameterEntry.asp" 'Link
    menuTree(2, 1) = 1 'TreeLevel
    'Third Row
    menuTree(0, 2) = "Parameter Display" 'Display Name
    menuTree(1, 2) = "/ParameterDisplay.asp" 'Link
    menuTree(2, 2) = 1 'TreeLevel
    'Fourth Row
    menuTree(0, 3) = "Deal Entry" 'Display Name
    menuTree(1, 3) = "" 'Link
    menuTree(2, 3) = 0 'TreeLevel
    'Fifth Row
    menuTree(0, 4) = "Multiple Deal Entry" 'Display Name
    menuTree(1, 4) = "" 'Link (Unclickable since it is a logical parent)
    menuTree(2, 4) = 1 'TreeLevel
    'Sixth Row
    menuTree(0, 5) = "Forex Deal Entry" 'Display Name
    menuTree(1, 5) = "/ForexDealEntry.asp" 'Link
    menuTree(2, 5) = 2 'TreeLevel
    
    Dim rowMin, rowMax, colMin, colMax, rowIt, colIt, lastLevel, inx
    
    If IsArray(menuTree) Then
        
        rowMin = LBound(menuTree, 2)
        rowMax = UBound(menuTree, 2)
        colMin = LBound(menuTree, 1)
        colMax = UBound(menuTree, 1)

        Response.Write "<div class='navig'>"
        Response.Write "<ul>"

        lastLevel = 0

        For rowIt = rowMin To rowMax
            
            If menuTree(2, rowIt) > lastLevel Then
                Response.Write "<ul>"
            ElseIf menuTree(2, rowIt) < lastLevel Then
                For inx = menuTree(2, rowIt) + 1 To lastLevel
                    Response.Write "</ul><li>"
                Next
            End If
        
            Response.Write "<li><a href='"        

            If Len(menuTree(1, rowIt) & "") > 0 Then
                Response.Write menuTree(1, rowIt)
            Else
                Response.Write "#"
            End If

            Response.Write "'>" & menuTree(0, rowIt) & "</a>"

            If Len(menuTree(1, rowIt) & "") > 0 Then
                Response.Write "</li>"
            End If
            
            lastLevel = menuTree(2, rowIt)
        Next

        For inx = 1 To lastLevel
            Response.Write "</ul></li>"
        Next

        Response.Write "</ul>"
        Response.Write "</div>"

    End If           
%>
</body>
</html>
