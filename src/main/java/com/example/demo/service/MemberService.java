package com.example.demo.service;

import com.example.demo.dto.MemberDto;
import com.example.demo.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.lang.reflect.Member;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberMapper memberMapper;

    public void insertMember(MemberDto memberDto) {
        memberMapper.insertMember(memberDto);
    }

    // select 단계 4.
    // Service에 select 추가
    public List<MemberDto> getMemberList() {
        return memberMapper.selectMemberList();
    }

    // CRUD Updtae 단계 6.
    public void updateMember(Member member) {
        memberMapper.updateMember(member);
    }
    // + 단건 조회용 메서드가 빠져있어서 추가. Controller에 있는 @GetMapping("/members/edit") 부분.
    public MemberDto getMemberById(Long id) {
        return memberMapper.selectMemberById(id);
    }

    // CRUD Delete 단계 3.
    public void deleteMember(Long id) {
        memberMapper.deleteMember(id);
    }
}
