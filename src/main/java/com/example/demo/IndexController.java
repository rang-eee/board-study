package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class IndexController {

    // API ****
        //    @GetMapping("/")
        //    @ResponseBody
//    @RequestMapping(value = "/", method = RequestMethod.GET)
    @RequestMapping("/")
    public String index(Model model){
        model.addAttribute("title", "board test");
        return "/index";
    }
}
