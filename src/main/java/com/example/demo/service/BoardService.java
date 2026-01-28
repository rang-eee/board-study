package com.example.demo.service;

import com.example.demo.dto.BoardDto;
import com.example.demo.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;

    public List<BoardDto> getBoardList() {
        return boardMapper.selectBoardList();
    }

    public BoardDto getBoardById(Long id) {
        return boardMapper.selectBoardById(id);
    }

    public void insertBoard(BoardDto boardDto) {
        boardMapper.insertBoard(boardDto);
    }

    public void updateBoard(BoardDto boardDto) {
        boardMapper.updateBoard(boardDto);
    }

    public void deleteBoard(Long id) {
        boardMapper.deleteBoard(id);
    }
}
