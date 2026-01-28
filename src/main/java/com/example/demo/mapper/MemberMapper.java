package com.example.demo.mapper;

import com.example.demo.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

import java.lang.reflect.Member;
import java.util.List;

// 인터페이스 (MyBatis)
@Mapper
public interface MemberMapper {
    int insertMember(MemberDto memberDto);

    // select 단계 1.
    // Mapper 인터페이스에 select 추가
    List<MemberDto> selectMemberList();

    MemberDto selectMemberById(Long id); // 이 부분이 CRUD select와 update 시에도 활용됨.

    // CRUD Update 단계 7-1.
    void updateMember(Member member);

    // CRUD Delete 단계 4.
    void deleteMember(Long id);
}
