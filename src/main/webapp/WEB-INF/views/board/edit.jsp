<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <%-- Bootstrap --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>

    <%-- CRUD Update 단계 4. --%>
    <%-- 수정 화면 JSP --%>
    <form action="/members/update" method="post">
        <input type="hidden" name="id" value="${member.id}" />
                <%-- 📌 id 꼭 hidden --%>
        이름:
        <input type="text" name="name" value="${member.name}" /><br/>

        이메일:
        <input type="text" name="email" value="${member.email}" /><br/>

        <button type="submit">수정</button>
    </form>


</body>
</html>