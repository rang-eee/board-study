    <%-- ▼ 이건 page 지시자. : JSP 페이지 설정용 / JSP에서 꼭 있어야함 --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%-- ▼ 이건 추가로 붙이는 taglib 지시자. : JSTL <c:forEach> / <c:if> 같은 JSTL 태그 사용 가능하게 함. --%>
    <%--    JSP에서 로직 최소화 할 때 필요한 부분이고, page 지시자 대신 쓸 수 없음--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Member List</title>
    <%-- Bootstrap --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>
<body class="container mt-5">

<h2 class="mb-4">회원 목록</h2>

<div class="mb-3">
    <a href="/members/new" class="btn btn-primary">회원 등록</a>
</div>

<table class="table table-bordered table-hover">
    <thead class="table-light">
    <tr>
        <th>ID</th>
        <th>이름</th>
        <th>이메일</th>
        <th>관리</th>
    </tr>
    </thead>
    <tbody>
    <%-- CRUD : Update 단계 1. --%>
    <%-- 목록에서 "수정" 링크 만들기 --%>
    <c:forEach var="m" items="${list}">
        <tr>
            <td>${m.id}</td>
            <td>${m.name}</td>
            <td>${m.email}</td>
            <td>
                <a href="/members/edit?id=${m.id}" class="btn btn-sm btn-warning">수정</a>

                <form action="/members/delete" method="post" style="display: inline;">
                    <input type="hidden" name="id" value="${m.id}" />
                    <button type="submit"
                            class="btn btn-sm btn-danger"
                            onclick="return confirm('정말 삭제하시겠습니까?');">
                        삭제
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach> <%-- 👉 id를 들고 수정화면으로 이동   --%>
    </tbody>
</table>


<%--    *** ▼ 학습용 코드  --%>

    <%-- CRUD : Update 단계 1. --%>
    <%-- 목록에서 "수정" 링크 만들기 --%>
    <%--<c:forEach var="m" items="${list}">--%>
    <%--    <tr>--%>
    <%--        <td>${m.id}</td>--%>
    <%--        <td>${m.name}</td>--%>
    <%--        <td>${m.email}</td>--%>
    <%--        <td>--%>
    <%--            <a href="/members/edit?id=${m.id}">수정</a>--%>
    <%--        </td>--%>
    <%--    </tr>--%>
    <%--</c:forEach> &lt;%&ndash; 👉 id를 들고 수정화면으로 이동   &ndash;%&gt;--%>

<%-- ------- ▲ Update / ▼ Delete ----------------------------- --%>

    <%-- CRUD Delete 단계 1. --%>
    <%-- 목록에 삭제 버튼 추가 --%>
    <%--<c:forEach var="m" items="${list}">--%>
    <%--    <tr>--%>
    <%--        <td>${m.id}</td>--%>
    <%--        <td>${m.name}</td>--%>
    <%--        <td>${m.email}</td>--%>
    <%--        <td>--%>
    <%--            <a href="/members/edit?id=${m.id}">수정</a>--%>

    <%--            <form action="/members/delete" method="post" style="display: inline;">--%>
    <%--                <input type="hidden" name="id" value="${m.id}" />--%>
    <%--                <button type="submit"--%>
    <%--                        onclick="return confirm('정말 삭제하시겠습니까?');">--%>
    <%--                    삭제--%>
    <%--                </button>--%>
    <%--            </form>--%>
    <%--        </td>--%>
    <%--    </tr>--%>
    <%--</c:forEach>--%>
    <%-- 📌 포인트: 1. ❌GET으로 삭제 금지 / 2. ✅POST+confirm 필수 / 3. form inline 처리 --%>


</body>
</html>