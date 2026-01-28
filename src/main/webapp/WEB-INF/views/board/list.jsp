    <%-- ▼ 이건 page 지시자. : JSP 페이지 설정용 / JSP에서 꼭 있어야함 --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%-- ▼ 이건 추가로 붙이는 taglib 지시자. : JSTL <c:forEach> / <c:if> 같은 JSTL 태그 사용 가능하게 함. --%>
    <%--    JSP에서 로직 최소화 할 때 필요한 부분이고, page 지시자 대신 쓸 수 없음--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        table { border-collapse: collapse; width: 700px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
        a, button { margin-right: 4px; text-decoration: none; }
        .btn { padding: 4px 8px; border-radius: 4px; cursor: pointer; }
        .btn-edit { background-color: #4CAF50; color: white; }
        .btn-delete { background-color: #f44336; color: white; }
        .btn-new { background-color: #2196F3; color: white; margin-bottom: 10px; display: inline-block; }

        /* float-MEMO-UI-style */
        #memo-box {
            position: fixed;
            right: 20px;
            /*top: 100px;*/
            bottom: 100px;
            width: 220px;
            background: #fffbe6;
            border: 1px solid #ddd;
            padding: 10px;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
        }

        #memo-box textarea {
            width: 100%;
            height: 120px;
        }

        #memo-box button {
            width: 100%;
            margin-top: 5px;
        }

    </style>
<%--    <title>Member List</title>--%>
    <%-- Bootstrap --%>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">--%>
</head>
<body class="container">
<h2>게시판 목록</h2>
<%--<h2 class="mb-4">회원 목록</h2>--%>

<div>
    <a href="/board/new" class="btn btn-new">글쓰기</a>
<%--    <a href="/members/new" class="btn btn-primary">회원 등록</a>--%>
</div>

    <%-- ▼ 일반 목록조회 테이블--%>
<table>
<%--<table class="table table-bordered table-hover">--%>
    <thead>
<%--    <thead class="table-light">--%>
    <tr>
        <th>ID</th>
<%--    <th>이름</th>--%>
<%--    <th>이메일</th>--%>
        <th>제목</th>
        <th>작성자</th>
        <th>관리</th>
    </tr>
    </thead>
    <tbody>
    <%-- CRUD : Update 단계 1. --%>
    <%-- 목록에서 "수정" 링크 만들기 --%>
    <c:forEach var="b" items="${list}">
<%--    <c:forEach var="m" items="${list}">--%>
        <tr>
<%--            <td>${m.id}</td>--%>
<%--            <td>${m.name}</td>--%>
<%--            <td>${m.email}</td>--%>
            <td>${b.id}</td>
            <td><a href="/board/list?id=${b.id}">${b.title}</a></td>
                            <%-- detail 안쓰니까 list    --%>
<%--            <td><a href="/board/detail?id=${b.id}">${b.title}</a></td>--%>
            <td>${b.writer}</td>
            <td>
<%--                <a href="/members/edit?id=${m.id}" class="btn btn-sm btn-warning">수정</a>--%>
<%--                <form action="/members/delete" method="post" style="display: inline;">--%>
<%--                    <input type="hidden" name="id" value="${m.id}" />--%>
<%--                    <button type="submit"--%>
<%--                            class="btn btn-sm btn-danger"--%>
<%--                            onclick="return confirm('정말 삭제하시겠습니까?');">--%>
<%--                        삭제--%>
<%--                    </button>--%>
<%--                </form>--%>
                <a href="/board/edit?id=${b.id}" class="btn btn-edit">수정</a>
                <form action="/board/delete" method="post" style="display: inline;">
                    <input type="hidden" name="id" value="${b.id}" />
                    <button type="submit" class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">
                        삭제
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach> <%-- 👉 id를 들고 수정화면으로 이동   --%>

    </tbody>
</table>


<%-- ▼ 상세 목록조회 테이블 --%>
<c:if test="${not empty board}">
    <hr/>
    <h3>게시글 상세</h3>

    <table border="1" cellpadding="5">
        <tr><th>ID</th><td>${board.id}</td></tr>
        <tr><th>제목</th><td>${board.title}</td></tr>
        <tr><th>작성자</th><td>${board.writer}</td></tr>
        <tr><th>내용</th><td>${board.content}</td></tr>
        <tr><th>작성일</th><td>${board.createdAt}</td></tr>
    </table>
</c:if>


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



<%-- 플로팅 메모 UI --%>
<div id="memo-box">
    <div style="display: flex; justify-content: space-between; align-items: center">
        <h4>📝 메모</h4>
        <div>
            <button id="memo-toggle" class="closeBtn">🔼</button>
        </div>
    </div>
    <div id="memo-body" style="border: 2px solid red">
        <textarea id="memo-text" style="max-width: 100%; min-height: 120px;" placeholder="클릭해서 메모 입력"></textarea>
<%--        <button onclick="saveMemo()">저장</button>--%>
        <button id="memo-save">저장</button>

        <div id="memo-status" style="color: gray;"></div>
    </div>
</div>

<%-- 3️⃣ IndexedDB JS --%>
<script>
    // var memoDB;
    // var memoDB;
    //     예: /board/list
    var memoDB = null;
    // var pageKey = location.pathname + location.search;  // <-- /board/list 뒤에 ?id=1(=글 상세조회) 값이 달라질때마다 메모Data가 달라지는 현상
    var pageKey = location.pathname;
    //     예: /board/edit?id=3  ➡️ 페이지별 메모 분리됨.

    // list 페이지에서는 query string (?id=n) 무시
    if (location.pathname === "/board/list") {
        pageKey = "/board/list";
    } else {
        pageKey = location.pathname + location.search;
    }

    // 메모 접기 & 펼치기
    window.addEventListener('DOMContentLoaded', function() {
        var toggleBtn = document.getElementById('memo-toggle');
        var memoBody = document.getElementById('memo-body');
        var opened = true;

        console.log(toggleBtn);
        toggleBtn.addEventListener("click", function() {
            console.log("클릭함");
            if (opened) {
                memoBody.classList.add('opened');
                memoBody.style.display = "none";
                toggleBtn.innerText = "🔽";
                console.log("열림");
            } else {
                memoBody.classList.remove('opened');
                memoBody.style.display = "block";
                toggleBtn.innerText = "🔼";
                console.log("닫힘");
            }
            opened = !opened;
        })

        // 저장 & 불러오기
        var memoSaveBtn = document.getElementById("memo-save");

        memoSaveBtn.addEventListener("click", function() {
            saveMemo();
        })
    })


    // 3-1️⃣ DB 열기 (요청)
    var request = indexedDB.open("memoDB", 1);
    // DB최초 생성 / 구조 변경 시
    request.onupgradeneeded = function (event) {
        memoDB = event.target.result;

        if (!memoDB.objectStoreNames.contains("memos")) {
            memoDB.createObjectStore("memos", {
                keyPath: "page"
            });
        }
    };
    // 3-2️⃣ DB 연결 성공
    request.onsuccess = function (event) {
        memoDB = event.target.result;
        loadMemo();
        console.log("IndexedDb 연결 완료");
    };
    request.onerror = function (event) {
        console.error("IndexedDb 연결 실패");
    }; // 에러 처리 (학습용으로 꼭 추천)

    // 3-3️⃣ 메모 불러오기
    function loadMemo() {
        if (!memoDB) return;

        var tx = memoDB.transaction("memos", "readonly");
        var store = tx.objectStore("memos");

        var getReq = store.get(pageKey);

        getReq.onsuccess = function (event) {
            var data = event.target.result;
            if (data) {
                document.getElementById("memo-text").value = data.content;
            }
        }
    }
    // 3-4️⃣ 메모 저장
    function saveMemo() {
        if (!memoDB) return;

        var tx = memoDB.transaction("memos", "readwrite");
        var store = tx.objectStore("memos");

        var memoData = {
            page: pageKey,
            content: document.getElementById("memo-text").value,
            updateAt: new Date().toLocaleString()
        };

        store.put(memoData);

        tx.complete = function () {
            document.getElementById("memo-status").innerText = "저장 완료";
        }
    }
</script>
</body>
</html>