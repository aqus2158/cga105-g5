<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.empAccess.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>員工權限管理</title>
<link href="css/index.css" rel="stylesheet" />
<link href="css/flaticon.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
<style type="text/css"></style>
<style>
label.spotlight {
	background-color: gray;
	padding: 2px 5px;
	border-radius: 5px;
	color: white;
}
</style>

</head>
<body>
	<%@ include file="../header_sidebar.jsp"%>
	<div class="tab-content" id="v-pills-tabContent" style="width: 100%; height: calc(100vh - 70px);">
		<!-- ============================================ 首頁 ============================================ -->
		<div class="tab-pane fade" id="v-pills-home" role="tabpanel"
			aria-labelledby="v-pills-home-tab" tabindex="0"></div>
		<!-- ========================================= 員工管理 ========================================= -->
		<div class="tab-pane fade show active p-3 container"
			id="v-pills-employee" role="tabpanel"
			aria-labelledby="v-pills-employee-tab" tabindex="0"
			style="display: flex; flex-direction: column; align-items: center">

			<div class="row">
				<div>
					<div>
						<h2>
							個別權限查詢&nbsp;<br>
							<div class="d-inline">
								<a class="col-2 btn btn-warning"
									href="<%=request.getContextPath()%>/back-end/empAccess/select_page1.jsp"
									role="button">回權限查詢頁</a>
							</div>
						</h2>
						<hr>
						<jsp:useBean id="accessFunctionSvc" scope="page"
							class="com.accessFunction.model.AccessFunctionService" />
						<h3>${accessFunctionSvc.getOneFunction(param.fID).fName}</h3>
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col" class="col-1">編號</th>
									<th scope="col" class="col-2">姓名</th>
									<th scope="col" class="col-12">權限</th>
								</tr>
							</thead>
							<tbody>
								<jsp:useBean id="empSvc" scope="page"
									class="com.emp.model.EmpService" />
								<jsp:useBean id="empAccessService" scope="page"
									class="com.empAccess.model.EmpAccessService" />
								<c:forEach var="empVO"
									items="${empSvc.getFunctionEmp(param.fID)}">
									<tr>
										<th>${empVO.empID}</th>

										<td>${empVO.empName}</td>
										<td class="function"><c:forEach var="accessFunctionVO"
												items="${accessFunctionSvc.all}" varStatus="nextLine">
												<input type="checkbox" name="function${nextLine.count}"
													${empAccessService.getOneAccess(empVO.empID,accessFunctionVO.fID).fID == accessFunctionVO.fID ? 'checked':''}
													disabled />
												<label for="function${nextLine.count}"
													${empAccessService.getOneAccess(empVO.empID,accessFunctionVO.fID).fID == accessFunctionVO.fID ? 'class=spotlight':''}>${accessFunctionVO.fName}</label>
							${nextLine.count%10 == 0 ? '<br>':''}
						</c:forEach></td>
									</tr>
								</c:forEach></tbody>
						</table>
					</div>
				</div>
			</div>


		</div>

		<!-- ========================================= 會員管理 ========================================= -->
		<div class="tab-pane fade" id="v-pills-shop" role="tabpanel"
			aria-labelledby="v-pills-shop-tab" tabindex="0"></div>
		<!-- ========================================= 商城管理 ========================================= -->
		<div class="tab-pane fade" id="v-pills-shop" role="tabpanel"
			aria-labelledby="v-pills-shop-tab" tabindex="0"></div>
		<!-- ========================================= 教練管理 ========================================= -->
		<div class="tab-pane fade" id="v-pills-coach" role="tabpanel"
			aria-labelledby="v-pills-coach-tab" tabindex="0"></div>
		<!-- ========================================= 課程管理 ========================================= -->
		<div class="tab-pane fade" id="v-pills-class" role="tabpanel"
			aria-labelledby="v-pills-class-tab" tabindex="0"></div>
		<!-- ========================================= 場地管理 ========================================= -->
		<div class="tab-pane fade" id="v-pills-room" role="tabpanel"
			aria-labelledby="v-pills-room-tab" tabindex="0"></div>
		<!-- ========================================= 論壇管理 ========================================= -->
		<div class="tab-pane fade" id="v-pills-article" role="tabpanel"
			aria-labelledby="v-pills-article-tab" tabindex="0"></div>
		<!-- ========================================= 客服管理 ========================================= -->
		<div class="tab-pane fade" id="v-pills-service" role="tabpanel"
			aria-labelledby="v-pills-service-tab" tabindex="0"></div>
	</div>
	</main>
	<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>

	<script
		src="https://cdn.bootcss.com/moment.js/2.18.1/moment-with-locales.min.js"></script>

	<script
		src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/sidebars.js"></script>
	<script>
	$(function() {
		$("#toEmployee").addClass("active");
		$("#toEmployee").attr("aria-selected", "true");
	})
	</script>
</body>
</html>






