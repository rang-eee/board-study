package com.example.demo.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
//@Getter
public class MemberDto {
    private Long id;
    private String name;
    private String email;
        // select 단계 3.
        // DTO에 createdAt 추가 _DataTransferObject?
    private LocalDateTime createdAt;


//private String title;
//private String content;
//private String writer;


//    @Builder
//    public Filedto(String title, String content, String writer){
//        this.title = title;
//        this.content = content;
//        this.writer = writer;
//    }

//    public void setPostId(Long postId) {
//        this.postId = posdId;
//    }
}
