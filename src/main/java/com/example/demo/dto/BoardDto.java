package com.example.demo.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data // lombok 문법 : Getter + Setter + toString + equals --> 보통 @Getter / @Setter 동시에 대신함.
public class BoardDto {
    private Long id;
    private String title;
    private String content;
    private String writer;
    private LocalDateTime createdAt;
}
