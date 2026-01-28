package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.example.demo.mapper") // 이거 어쩌다가 왜 넣었을까...?
	// ▲ 지우면 안된다네? -- XML 기반 MyBatis 사용 중이면 반드시 필요함 / 또는 Mapper 인터페이스에 @Mapper
		// 근데 Mapper 인터페이스에 @Mapper 있으니까 여기서 주석처리 할거임.
			// 근데 계속 콘솔에서 이부분 안보여서 다시 추가함 : Mapped "{[/board/list],methods=[GET]}"
public class DemoApplication {

	public static void main(String[] args) {

		SpringApplication.run(DemoApplication.class, args);

	}

}
