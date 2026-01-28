<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Member Insert</title>
    <%-- Bootstrap --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body class="container mt-5">

<%--  등록화면 JSP  --%>
    <h2 class="mb-4">회원 등록</h2>

    <form action="/members/insert" method="post">

        <div class="mb-3">
            <label class="form-label">이름</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">이메일</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success">등록</button>
        <a href="/members/list" class="btn btn-secondary">취소</a>
    </form>

</body>
</html>