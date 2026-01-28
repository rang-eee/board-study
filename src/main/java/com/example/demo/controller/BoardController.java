package com.example.demo.controller;

import com.example.demo.dto.BoardDto;
import com.example.demo.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.PostConstruct;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

    private final BoardService boardService;

    @PostConstruct
    public void init() {
        System.out.println(">>> BoardController 로딩됨 <<<");
    }

    // 화면 띄우는 컨트롤러 메소드 안에 조회로직이 있어야한다. (범규형님 confirm)

    // 목록 조회 + 상세 조회는 별도로 메소드 분리할 필요 없음
    @GetMapping("/list")
//    public String list(Model model) {
    public String list(
            @RequestParam(required = false) Long id,
            Model model
    ) {
        // 조회 로직
        List<BoardDto> list = boardService.getBoardList(); // 한 줄 추가
        model.addAttribute("list", list);
    //   ▲ 수정     model.addAttribute("list", boardService.getBoardList());

        if(id != null) {
            BoardDto board = boardService.getBoardById(id);
            model.addAttribute("board", board);
        } // 추가로 list.jsp에서 상세 영역 분기 필요.

        return "board/list";
    }

    // 상세 조회 -> /list 내부로 연결해준듯.
//    @GetMapping("/detail")
//    public String detail(@RequestParam Long id, Model model) {
//        BoardDto board = boardService.getBoardById(id);
//        model.addAttribute("board", board);
//    //   ▲ 수정     model.addAttribute("board", boardService.getBoardById(id));
//        return "board/detail";
//    }

    // 등록 화면
    @GetMapping("/new")
    public String insertForm() {
        return "board/insert";
    }

    // 등록 처리
    @PostMapping("/insert")
    public String insert(BoardDto boardDto) {
        System.out.println(">>> 게시글 등록 호출됨");
        boardService.insertBoard(boardDto);
        return "redirect:/board/list";
    }

    // 수정 화면
    @GetMapping("/edit")
    public String editForm(@RequestParam Long id, Model model) {
        BoardDto board = boardService.getBoardById(id); // 조회 포함
        model.addAttribute("board", board);
    //   ▲ 수정     model.addAttribute("board", boardService.getBoardById(id));
        return "board/edit";
    }

    // 수정 처리
    @PostMapping("/update")
    public String update(BoardDto boardDto) {
        boardService.updateBoard(boardDto);
        // 목록조회+상세조회 컨트롤러 메소드를 하나로 합치면서
        // detail 메소드를 안쓰고 있으므로
        return "redirect:/board/list?id=" + boardDto.getId();
//        return "redirect:/board/detail?id=" + boardDto.getId();
    }

    // 삭제 처리
    @PostMapping("/delete")
    public String delete(@RequestParam Long id) {
        boardService.deleteBoard(id);
        return "redirect:/board/list";
    }





}


