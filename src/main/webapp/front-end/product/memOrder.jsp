<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.musclebeach.mem.model.MemVO" %>
<%@ page import="com.musclebeach.order.model.entity.OrderMaster" %>
<%@ page import="com.musclebeach.order.model.service.MasterService" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.musclebeach.common.util.ApplicationContextUtil" %>

<%
    ApplicationContext context = ApplicationContextUtil.getContext();
    MemVO memVO = (MemVO) request.getSession().getAttribute("memVO");
    MasterService orderSvc = context.getBean(MasterService.class);
    List<OrderMaster> list = orderSvc.getAllMasterByMem(memVO.getMemID());
    pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>我的訂單</title>

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- all css -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/front-end/product/resources/frontStage/lib/flaticon/font/flaticon.css"
          rel="stylesheet">
    <link href="<%=request.getContextPath()%>/front-end/product/resources/frontStage/css/style.min.css"
          rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <link href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/back-end/resources/css/listAll_dataTable.css" rel="stylesheet">

    <link href="https://kit.fontawesome.com/db0445c7fa.css" rel="stylesheet" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
            crossorigin="anonymous"></script>
    <style>
        table {
            border-collapse: collapse;
            width: 60%;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: lightgray;
        }

        input[type="number"] {
            width: 50px;
        }

        #total {
            font-weight: bold;
        }

        button {
            padding: 10px 20px;
            background-color: lightgray;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
    </style>
</head>

<body class="bg-white">

<!-- header -->
<%@include file="/front-end/common/header.jsp" %>


<!-- Start All Title Box -->
<div class="all-title-box">
    <div class="container">
        <div class="row">
            <div class="col-lg-12" style="padding-top: 100px;">
                <a href="<%=request.getContextPath()%>/front-end/product/shop.jsp"
                   class="btn btn-info mb-3">返回商城</a>
                <ul class="breadcrumb">
                    <h2>我的訂單</h2>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- End All Title Box -->

<!-- memOrderDetail Start -->
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row  mt-3">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">歷史訂單</h4>
                        <div class="table-responsive">
                            <table id="dataTables" class="table table-hover align-middle"
                                   class="display compact hover cell-border stripe table-hover"
                                   style="width: 100%; font-size: 12px">
                                <thead>
                                <tr>
                                    <th>編號</th>
                                    <th>姓名</th>
                                    <th>電話</th>
                                    <th>地址</th>
                                    <th>金額</th>
                                    <th>狀態</th>
                                    <th>下單時間</th>
                                    <th>訂單明細</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="orderVO" items="${list}">
                                    <tr>
                                        <td>${orderVO.orderID}</td>
                                        <td>${orderVO.orderRecName}</td>
                                        <td>${orderVO.orderRecPhone}</td>
                                        <td>${orderVO.orderAddress}</td>
                                        <td>${orderVO.totalPrice}</td>
                                        <td>
                                            <c:if test="${orderVO.orderStatus == 0}">
                                                <div>出貨中</div>
                                            </c:if>
                                            <c:if test="${orderVO.orderStatus == 1}">
                                                <div>配送中</div>
                                            </c:if>
                                            <c:if test="${orderVO.orderStatus == 2}">
                                                <div>訂單完成</div>
                                            </c:if>
                                            <c:if test="${orderVO.orderStatus == 3}">
                                                <div>訂單取消</div>
                                            </c:if>
                                        </td>
                                        <td>${orderVO.createTime}</td>
                                        <td>
                                            <FORM METHOD="post"
                                                  ACTION="<%=request.getContextPath()%>/front-end/order/view"
                                                  style="margin-bottom: 0px;">
                                                <button class="btn btn-outline-secondary" type="submit"
                                                        title="檢視明細"><i
                                                        class="fa-solid fa-eye"></i>
                                                </button>
                                                <input type="hidden" name="orderID"
                                                       value="${orderVO.orderID}">
                                                <input type="hidden" name="action"
                                                       value="getOne_For_Detail">
                                            </FORM>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <script>
                                $(document).ready(function () {
                                    $('#dataTables').DataTable({
                                        "aaSorting": [[6, "DESC"]],
                                        "language": {
                                            "processing": "處理中...",
                                            "loadingRecords": "載入中...",
                                            "paginate": {
                                                "first": "第一頁",
                                                "previous": "上一頁",
                                                "next": "下一頁",
                                                "last": "最後一頁"
                                            },
                                            "emptyTable": "目前沒有資料",
                                            "datetime": {
                                                "previous": "上一頁",
                                                "next": "下一頁",
                                                "hours": "時",
                                                "minutes": "分",
                                                "seconds": "秒",
                                                "amPm": [
                                                    "上午",
                                                    "下午"
                                                ],
                                                "unknown": "未知",
                                                "weekdays": [
                                                    "週日",
                                                    "週一",
                                                    "週二",
                                                    "週三",
                                                    "週四",
                                                    "週五",
                                                    "週六"
                                                ],
                                                "months": [
                                                    "一月",
                                                    "二月",
                                                    "三月",
                                                    "四月",
                                                    "五月",
                                                    "六月",
                                                    "七月",
                                                    "八月",
                                                    "九月",
                                                    "十月",
                                                    "十一月",
                                                    "十二月"
                                                ]
                                            },
                                            "searchBuilder": {
                                                "add": "新增條件",
                                                "condition": "條件",
                                                "deleteTitle": "刪除過濾條件",
                                                "button": {
                                                    "_": "複合查詢 (%d)",
                                                    "0": "複合查詢"
                                                },
                                                "clearAll": "清空",
                                                "conditions": {
                                                    "array": {
                                                        "contains": "含有",
                                                        "equals": "等於",
                                                        "empty": "空值",
                                                        "not": "不等於",
                                                        "notEmpty": "非空值",
                                                        "without": "不含"
                                                    },
                                                    "date": {
                                                        "after": "大於",
                                                        "before": "小於",
                                                        "between": "在其中",
                                                        "empty": "為空",
                                                        "equals": "等於",
                                                        "not": "不為",
                                                        "notBetween": "不在其中",
                                                        "notEmpty": "不為空"
                                                    },
                                                    "number": {
                                                        "between": "在其中",
                                                        "empty": "為空",
                                                        "equals": "等於",
                                                        "gt": "大於",
                                                        "gte": "大於等於",
                                                        "lt": "小於",
                                                        "lte": "小於等於",
                                                        "not": "不為",
                                                        "notBetween": "不在其中",
                                                        "notEmpty": "不為空"
                                                    },
                                                    "string": {
                                                        "contains": "含有",
                                                        "empty": "為空",
                                                        "endsWith": "字尾為",
                                                        "equals": "等於",
                                                        "not": "不為",
                                                        "notEmpty": "不為空",
                                                        "startsWith": "字首為",
                                                        "notContains": "不含",
                                                        "notStartsWith": "開頭不是",
                                                        "notEndsWith": "結尾不是"
                                                    }
                                                },
                                                "data": "欄位",
                                                "leftTitle": "群組條件",
                                                "logicAnd": "且",
                                                "logicOr": "或",
                                                "rightTitle": "取消群組",
                                                "title": {
                                                    "_": "複合查詢 (%d)",
                                                    "0": "複合查詢"
                                                },
                                                "value": "內容"
                                            },
                                            "editor": {
                                                "close": "關閉",
                                                "create": {
                                                    "button": "新增",
                                                    "title": "新增資料",
                                                    "submit": "送出新增"
                                                },
                                                "remove": {
                                                    "button": "刪除",
                                                    "title": "刪除資料",
                                                    "submit": "送出刪除",
                                                    "confirm": {
                                                        "_": "您確定要刪除您所選取的 %d 筆資料嗎？",
                                                        "1": "您確定要刪除您所選取的 1 筆資料嗎？"
                                                    }
                                                },
                                                "error": {
                                                    "system": "系統發生錯誤(更多資訊)"
                                                },
                                                "edit": {
                                                    "button": "修改",
                                                    "title": "修改資料",
                                                    "submit": "送出修改"
                                                },
                                                "multi": {
                                                    "title": "多重值",
                                                    "info": "您所選擇的多筆資料中，此欄位包含了不同的值。若您想要將它們都改為同一個值，可以在此輸入，要不然它們會保留各自原本的值。",
                                                    "restore": "復原",
                                                    "noMulti": "此輸入欄需單獨輸入，不容許多筆資料一起修改"
                                                }
                                            },
                                            "autoFill": {
                                                "cancel": "取消"
                                            },
                                            "buttons": {
                                                "copySuccess": {
                                                    "_": "複製了 %d 筆資料",
                                                    "1": "複製了 1 筆資料"
                                                },
                                                "copyTitle": "已經複製到剪貼簿",
                                                "excel": "Excel",
                                                "pdf": "PDF",
                                                "print": "列印",
                                                "copy": "複製",
                                                "colvis": "欄位顯示",
                                                "colvisRestore": "重置欄位顯示",
                                                "csv": "CSV",
                                                "pageLength": {
                                                    "-1": "顯示全部",
                                                    "_": "顯示 %d 筆"
                                                },
                                                "createState": "建立狀態",
                                                "removeAllStates": "移除所有狀態",
                                                "removeState": "移除",
                                                "renameState": "重新命名",
                                                "savedStates": "儲存狀態",
                                                "stateRestore": "狀態 %d",
                                                "updateState": "更新"
                                            },
                                            "searchPanes": {
                                                "collapse": {
                                                    "_": "搜尋面版 (%d)",
                                                    "0": "搜尋面版"
                                                },
                                                "emptyPanes": "沒搜尋面版",
                                                "loadMessage": "載入搜尋面版中...",
                                                "clearMessage": "清空",
                                                "count": "{total}",
                                                "countFiltered": "{shown} ({total})",
                                                "title": "過濾條件 - %d",
                                                "showMessage": "顯示全部",
                                                "collapseMessage": "摺疊全部"
                                            },
                                            "stateRestore": {
                                                "emptyError": "名稱不能空白。",
                                                "creationModal": {
                                                    "button": "建立",
                                                    "columns": {
                                                        "search": "欄位搜尋",
                                                        "visible": "欄位顯示"
                                                    },
                                                    "name": "名稱：",
                                                    "order": "排序",
                                                    "paging": "分頁",
                                                    "scroller": "卷軸位置",
                                                    "search": "搜尋",
                                                    "searchBuilder": "複合查詢",
                                                    "select": "選擇",
                                                    "title": "建立新狀態",
                                                    "toggleLabel": "包含："
                                                },
                                                "duplicateError": "此狀態名稱已經存在。",
                                                "emptyStates": "名稱不可空白。",
                                                "removeConfirm": "確定要移除 %s 嗎？",
                                                "removeError": "移除狀態失敗。",
                                                "removeJoiner": "和",
                                                "removeSubmit": "移除",
                                                "removeTitle": "移除狀態",
                                                "renameButton": "重新命名",
                                                "renameLabel": "%s 的新名稱：",
                                                "renameTitle": "重新命名狀態"
                                            },
                                            "select": {
                                                "columns": {
                                                    "_": "選擇了 %d 欄資料",
                                                    "1": "選擇了 1 欄資料"
                                                },
                                                "rows": {
                                                    "1": "選擇了 1 筆資料",
                                                    "_": "選擇了 %d 筆資料"
                                                },
                                                "cells": {
                                                    "1": "選擇了 1 格資料",
                                                    "_": "選擇了 %d 格資料"
                                                }
                                            },
                                            "zeroRecords": "沒有符合的資料",
                                            "aria": {
                                                "sortAscending": "：升冪排列",
                                                "sortDescending": "：降冪排列"
                                            },
                                            "info": "顯示第 _START_ 至 _END_ 筆結果，共 _TOTAL_ 筆",
                                            "infoEmpty": "顯示第 0 至 0 筆結果，共 0 筆",
                                            "infoFiltered": "(從 _MAX_ 筆結果中過濾)",
                                            "infoThousands": ",",
                                            "lengthMenu": "顯示 _MENU_ 筆結果",
                                            "search": "搜尋：",
                                            "searchPlaceholder": "請輸入關鍵字",
                                            "thousands": ","
                                        }
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<!-- memOrderDetail End -->


<!-- Footer -->
<%@include file="/front-end/common/footer.jsp" %>

<!-- Back to Top -->
<a href="#" class="btn btn-outline-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>


<!-- all js -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="<%=request.getContextPath()%>/front-end/product/resources/frontStage/lib/easing/easing.min.js"></script>
<script src="<%=request.getContextPath()%>/front-end/product/resources/frontStage/lib/waypoints/waypoints.min.js"></script>
<script src="<%=request.getContextPath()%>/front-end/product/resources/frontStage/mail/jqBootstrapValidation.min.js"></script>
<script src="<%=request.getContextPath()%>/front-end/product/resources/frontStage/mail/contact.js"></script>
<script src="<%=request.getContextPath()%>/front-end/product/resources/frontStage/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.2/axios.min.js"></script>
<script type="text/javascript" charset="utf8"
        src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>

<script src="https://kit.fontawesome.com/db0445c7fa.js" crossorigin="anonymous"></script>

</body>

</html>