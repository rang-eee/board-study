<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 상세</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        table { border-collapse: collapse; width: 600px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; width: 120px; }
        a, button { margin-right: 4px; text-decoration: none; }
        .btn { padding: 4px 8px; border-radius: 4px; cursor: pointer; }
        .btn-edit { background-color: #4CAF50; color: white; }
        .btn-delete { background-color: #f44336; color: white; }
        .btn-list { background-color: #2196F3; color: white; }
    </style>
</head>
<body>
<h2>게시글 상세</h2>

<div style="margin-bottom: 10px;">
    <a href="/board/list" class="btn btn-list">목록</a>
    <a href="/board/edit?id=${board.id}" class="btn btn-edit">수정</a>
    <form action="/board/delete" method="post" style="display:inline;">
        <input type="hidden" name="id" value="${board.id}" />
        <button type="submit" class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">
            삭제
        </button>
    </form>
</div>

<table>
    <tr><th>ID</th><td>${board.id}</td></tr>
    <tr><th>제목</th><td>${board.title}</td></tr>
    <tr><th>작성자</th><td>${board.writer}</td></tr>
    <tr><th>내용</th><td>${board.content}</td></tr>
    <tr><th>작성일</th><td>${board.createdAt}</td></tr>
</table>
</body>
</html>