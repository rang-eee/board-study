<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        label { display: block; margin-top: 10px; }
        input[type=text], textarea { width: 400px; padding: 4px; margin-top: 4px; }
        button, a { padding: 4px 8px; margin-top: 10px; text-decoration: none; }
        .btn-submit { background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        .btn-cancel { background-color: #f44336; color: white; border: none; cursor: pointer; }
    </style>
    <%-- Bootstrap --%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
</head>
<body>
<h2>글 수정</h2>
    <%-- CRUD Update 단계 4. --%>
    <%-- 수정 화면 JSP --%>
    <form action="/board/update" method="post">
        <input type="hidden" name="id" value="${board.id}" />
                <%-- 📌 id 꼭 hidden --%>
        <label>제목</label>
        <input type="text" name="title" value="${board.title}" required />

        <label>내용</label>
        <textarea name="content" rows="5" required>${board.content}</textarea>

        <br/>
        <button type="submit" class="btn-submit">수정</button>
                <%-- ▼ detail 없애고 목록조회/상세조회 합쳤으니까 --%>
        <a href="/board/list?id=${board.id}" class="btn-cancel">취소</a>
                <%-- ▲ 이렇게 list로 수정 --%>
<%--        <a href="/board/detail?id=${board.id}" class="btn-cancel">취소</a>--%>
    </form>
<%--    <form action="/members/update" method="post">--%>
<%--        <input type="hidden" name="id" value="${member.id}" />--%>
<%--                &lt;%&ndash; 📌 id 꼭 hidden &ndash;%&gt;--%>
<%--        이름:--%>
<%--        <input type="text" name="name" value="${member.name}" /><br/>--%>

<%--        이메일:--%>
<%--        <input type="text" name="email" value="${member.email}" /><br/>--%>

<%--        <button type="submit">수정</button>--%>
<%--    </form>--%>


</body>
</html>