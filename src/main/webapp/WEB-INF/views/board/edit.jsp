<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/memo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">
    <style>
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



<%-- 플로팅 메모 UI --%>
<div id="memo-box">
    <div style="display: flex; justify-content: space-between; align-items: center">
        <strong>📝 메모</strong>
        <div>
            <button id="memo-toggle" class="closeBtn">🔼</button>
        </div>
    </div>
    <div id="memo-body" style="/* border: 2px solid red */ ">

        <textarea id="memo-text" style="max-width: 100%; min-height: 120px;" placeholder="메모 입력"></textarea>
        <%--        <button onclick="saveMemo()">저장</button>--%>
        <button id="memo-add">➕ 메모 추가</button>
        <%--        <button id="memo-save">저장</button>--%>
        <%--        <button id="memo-delete">삭제</button>--%>

        <ul id="memo-list"></ul>

        <%--        <div id="memo-status" style="color: gray;"></div>--%>
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

    // --------------------------- 🔷 DB 버전 올리기 🔷
    // 3-1️⃣ DB 열기 (요청)
    var request = indexedDB.open("memoDB", 2);
    // DB최초 생성 / 구조 변경 시
    request.onupgradeneeded = function (event) {
        memoDB = event.target.result;

        //onupgradeneeded 수정
        if (!memoDB.objectStoreNames.contains("memos")) {
            // memoDB.createObjectStore("memos", {
            //     keyPath: "page"
            // });
            var store = memoDB.createObjectStore("memos", {
                keyPath: "id",
                autoIncrement: true     // 이거 없으면 var memoData에 id: ~~값 넣어줘야함.
            });
            store.createIndex("page", "page", {unique: false});
            // page기준으로 목록 조회하려면 index 반드시 필요. ▲ 이거 없으면 store.index 바로 에러남
        }
    };
    // 3-2️⃣ DB 연결 성공
    request.onsuccess = function (event) {
        memoDB = event.target.result;
        loadMemoList();
        console.log("IndexedDb 연결 완료");
    };
    request.onerror = function () {
        console.error("IndexedDb 연결 실패");
    }; // 에러 처리 (학습용으로 꼭 추천)

    // 메모 추가 - 새 메모 만들기
    function addMemo() {
        var text = document.getElementById("memo-text").value.trim();
        if (text === "") return;

        var tx = memoDB.transaction("memos", "readwrite");
        var store = tx.objectStore("memos");

        // 여기서 add() 쓰는 이유
        // put() -> 덮어쓰기
        // add() -> 진짜 "추가"
        store.add({
            page: pageKey,
            content: text,
            createdAt: new Date().toLocaleString()
        });

        tx.oncomplete = function () {
            document.getElementById("memo-text").value = "";
            loadMemoList();
        }
    }

    // 3-3️⃣ 메모 불러오기
    function loadMemoList() {
        var listEl = document.getElementById("memo-list");
        listEl.innerHTML = "";

        var tx = memoDB.transaction("memos", "readonly");
        var store = tx.objectStore("memos");
        var index = store.index("page");

        var req = index.getAll(pageKey);
        // var getReq = store.get(pageKey);

        // getReq.onsuccess = function (event) {
        req.onsuccess = function () {
            var memos = req.result;
            // var li = document.createElement("li");

            // 템플릿 리터럴 제거. -> JSP EL 문법이랑 헷갈려 해서 충돌남. (Expression Language)
            <%--li.innerHTML = `--%>
            <%--    <div>${memo.content}</div>--%>
            <%--    <button onclick="deleteMemo(${memo.id})">삭제</button>--%>
            <%--`;--%>
            // var data = event.target.result;

            // 다시만들기
            for (var i = 0; i < memos.length; i++) {
                renderMemo(memos[i]);
                // var memo = memos[i];
                //
                // var li = document.createElement("li");
                //
                // var div = document.createElement("div");
                // div.innerText = memo.content;
                //
                // var btn = document.createElement("button");
                // btn.innerText = "삭제";
                // btn.onclick = function (id) {
                //     return function () {
                //         deleteMemo(id);
                //     };
                // }(memo.id);
                //
                // li.appendChild(div);
                // li.appendChild(btn);
                //
                // listEl.appendChild(li);
            }
        }
    }

    // 메모 렌더링
    function renderMemo(memo) {
        var listEl = document.getElementById("memo-list");

        var li = document.createElement("li");

        var content = document.createElement("div");
        content.innerText = memo.content;

        var actions = document.createElement("div");
        actions.className = "memo-actions";

        var editBtn = document.createElement("button");
        editBtn.innerText = "수정";
        editBtn.onclick = function () {
            editMemo(memo.id, memo.content);
        };

        var delBtn = document.createElement("button");
        delBtn.innerText = "삭제";
        delBtn.onclick = function () {
            deleteMemo(memo.id);
        };

        actions.appendChild(editBtn);
        actions.appendChild(delBtn);

        li.appendChild(content);
        li.appendChild(actions);

        listEl.appendChild(li);
    }

    // 메모 수정
    function editMemo(id, oldContent) {
        var newContent = prompt("메모 수정", oldContent);
        if (newContent === null) return;

        var tx = memoDB.transaction("memos", "readwrite");
        var store = tx.objectStore("memos");

        var req = store.get(id);

        req.onsuccess = function () {
            var data = req.result;
            data.content = newContent;
            store.put(data);
        };

        tx.oncomplete = function () {
            loadMemoList();
        };
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

        store.put(memoData); // add 또는 put   --- Create/Update (CRUD)
        // store.add(memoData);
        // store.get(pageKey); // --> Read (CRUD)
        // store.delete(pageKey); // --> delete  (CRUD)
    }

    // 메모 삭제
    function deleteMemo(id) {
        if (!confirm("삭제할까요?")) return;

        var tx = memoDB.transaction("memos", "readwrite");
        var store = tx.objectStore("memos");

        // store.delete(pageKey);
        store.delete(id);

        tx.oncomplete = function () {
            loadMemoList();
        };
    }

    // UI 이벤트 -- 메모 접기 & 펼치기
    window.addEventListener('DOMContentLoaded', function() {
        document.getElementById("memo-add").onclick = addMemo;

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
        // 이렇게 쓸 수도 있음
        // toggleBtn.onclick = function () {
        //     body.style.display = opened ? "none" : "block";
        //     toggleBtn.innerText = opened ? "🔽" : "🔼";
        //     opened = !opened;
        // };

        // 저장 & 불러오기
        // var memoSaveBtn = document.getElementById("memo-save");
        //
        // memoSaveBtn.addEventListener("click", function() {
        //     saveMemo();
        // })

        // 메모 삭제하기
        // var memoDeleteBtn = document.getElementById("memo-delete");
        //
        // memoDeleteBtn.addEventListener("click", function() {
        //     deleteMemo();
        // })
    })
</script>
</body>
</html>