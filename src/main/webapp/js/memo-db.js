// 공통 JS, 👉 모든 JSP에 공통 포함
// <script> -- JavaScript

// let memoDB;
var memoDB; // 정석 문법으로 작성 시작 (❎축약 문법❌)

// 1) DB 열기 요청
var request = indexedDB.open("memoDB", 1); // 1은 버전 (구조 바뀌면 숫자 올릴수도있음)
// const request = indexedDB.open("memoDB", 1);

// 2) DB최초 생성 / 구조 변경 시
request.onupgradeneeded = function (event) {
    memoDB = event.target.result;
    if (!memoDB.objectStoreNames.contains("memos")) {
        memoDB.createObjectStore("memos", {
            keyPath: "page"
        });
    }
}; // 🔍 여기서 일어나는 일
// ● DB가 처음 생성되거나
// ● 버전이 올라갔을 때만 실행됨
// ● 테이블 같은 개념인 objectStore 생성

// 3) DB 연결 성공 시
request.onsuccess = function (event) {
    memoDB = event.target.result;
    loadMemo();
    console.log("IndexedDb 연결 완료");
};

// 4) 에러 처리 (학습용으로 꼭 추천)
request.onerror = function (event) {
    console.error("IndexedDb 연결 실패");
};