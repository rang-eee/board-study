<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        label { display: block; margin-top: 10px; }
        input[type=text], textarea { width: 400px; padding: 4px; margin-top: 4px; }
        button, a { padding: 4px 8px; margin-top: 10px; text-decoration: none; }
        .btn-submit { background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        .btn-cancel { background-color: #f44336; color: white; border: none; cursor: pointer; }
    </style>
<%--    <title>Member Insert</title>--%>
    <%-- Bootstrap --%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
</head>
<body class="container">
<%--  등록화면 JSP  --%>
    <h2>글쓰기</h2>
<%--    <h2 class="mb-4">회원 등록</h2>--%>

    <form action="/board/insert" method="post">
<%--    <form action="/members/insert" method="post">--%>
        <div>
            <label>제목</label>
            <input type="text" name="title" required />
<%--            <label class="form-label">이름</label>--%>
<%--            <input type="text" name="name" class="form-control" required />--%>
        </div>

        <div>
            <label>작성자</label>
            <input type="text" name="writer" required />
<%--            <label class="form-label">이메일</label>--%>
<%--            <input type="email" name="email" class="form-control" required />--%>
        </div>

        <div>
            <label>내용</label>
            <textarea name="content" rows="5" required></textarea>
        </div>

        <br/>
        <button type="submit" class="btn-submit">등록</button>
        <a href="/board/list" class="btn-cancel">취소</a>
<%--        <button type="submit" class="btn btn-success">등록</button>--%>
<%--        <a href="/board/list" class="btn btn-secondary">취소</a>--%>
<%--        <a href="/members/list" class="btn btn-secondary">취소</a>--%>
    </form>

</body>
</html>