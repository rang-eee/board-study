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

    Hello Worldasd!
    <div class="container">
    <%--    <form action="/WEB-INF/views/save.jsp" method="POST">--%>
        <form action="/add" method="POST">
            <div class="form-group">
                <label for="subject">제목</label>
                <input type="text" placeholder="제목입력">
            </div>
            <input name="title">
            <input name="content">
            <input name="writer">
<%--            username=: <input type="text" name="username"/>--%>
<%--            age: <input type="text" name="age" />--%>
            <button type="submit">전송</button>
        </form>
<!--    action="/URL"과 method="POST"를 기입하면 전송버튼 눌렀을 때 특정 /URL로 POST요청을 날림   -->

    </div>

</body>
</html>