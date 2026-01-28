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

        /* float-MEMO-UI-style */
        #memo-box {
            position: fixed;
            right: 20px;
            top: 100px;
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