package com.example.demo.mapper;

import com.example.demo.dto.BoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

//@Mapper
public interface BoardMapper {
    List<BoardDto> selectBoardList();
    BoardDto selectBoardById(Long id);
    void insertBoard(BoardDto boardDto);
    void updateBoard(BoardDto boardDto);
    void deleteBoard(Long id);
}
