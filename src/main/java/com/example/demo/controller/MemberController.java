package com.example.demo.controller;


import com.example.demo.dto.MemberDto;
import com.example.demo.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Member;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/members")
public class MemberController {

    private final MemberService memberService;

//    @PostMapping
    @PostMapping("/test")
//    public String insertTest(@RequestBody MemberDto memberDto) {
    public String insertTest() {
//        memberService.insertMember(memberDto);
// return "insert success, id = " + memberDto.getId();
        // ▼ 테스트 시 주석 풀어서 활성화
        MemberDto dto = new MemberDto();
        dto.setName("백엔드테스트");
        dto.setEmail("test@backend.com");

        memberService.insertMember(dto);

        return "insert sucess, id = " + dto.getId();
    }

    // @GetMapping으로 insert 하는 건
    //👉 테스트 끝나면 반드시 제거하거나
    //👉 @PostMapping으로만 유지
    //
    //실서비스에서는
    //❌ GET = 데이터 변경
    //❌ 매우 위험
    @GetMapping("/test")
    public String inserTestGet() {
        return insertTest();
    }


//    ---------------------------------------------------------------------


    // select 단계 5.
    // Controller에 목록 조회 추가
        // 오류 1번 남. List<DTO>반환 -> Jackson 사용 -> 충돌나서 터짐
    @GetMapping("/list")
    public List<MemberDto> memberList() {
        return memberService.getMemberList();
    }
    // String 반환 -> Jackson 안 씀 -> 정상
    //    @GetMapping("/list")
    //    public String testString() {
    //        return "ok";
    //    }


//    ---------------------------------------------------------------------


// CRUD Update 단계 2.
// 수정 화면 요청 (Controller - GET)
    @GetMapping("/members/edit")
    public String editForm(@RequestParam Long id, Model model) {
        MemberDto member = memberService.getMemberById(id);
        model.addAttribute("member", member);
        return "member/edit";
    } // ▲ 여기서 하는 일 : id받기 / 기존데이터조회 / 화면에전달
// CRUD Update 단계 5.
// 수정 처리 (Controller - POST)
    @PostMapping("/members/update")
    public String update(Member member) {
        memberService.updateMember(member);
        return "redirect:/members/list";
    } // 👉 PRG 패턴 : 새로고침해도 중복 update 방지


//    ---------------------------------------------------------------------


    // CRUD Delete 단계 2.
    // DELETE 처리
    @PostMapping("/members/delete")
    public String delete(@RequestParam Long id) {
        memberService.deleteMember(id);
        return "redirect:/members/list";
    } // 👉 PRG 패턴 유지


    // CRUD 이후 등록화면 요청 만들기 3. (마크업 단계)
    @GetMapping("/members/new")
    public String insertForm() {
        return "member/insert";
    }
    // Controller 등록 처리 (이미 있던 거 재확인.... 후 작성?)
    @PostMapping("/members/insert")
    public String insert(MemberDto memberDto) {
        memberService.insertMember(memberDto);
        return "redirect:/members/list";
    }
}
