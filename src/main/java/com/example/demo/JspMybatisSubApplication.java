//package com.example.demo;
//
//
//import org.mybatis.spring.annotation.MapperScan;
//import org.springframework.boot.autoconfigure.SpringBootApplication;
//import org.springframework.context.annotation.Bean;
//
//@SpringBootApplication
//// Mapper 인터페이스를 변경할 수 없도록 설정
//@MapperScan(value={"com.example.demo.mapper"})
//public class JspMybatisSubApplication {
//
//    public static void main(String[] args) {
//        SpringApplication.run(JspMybatisSubApplication.class, args);
//    }
//
//    /* SqlSessionFactory 설정 */
//
//    @Bean
//    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
//        {
//
//            SqlSessionFactoryBean sessionFactory = new  SqlSessionFactoryBean();
//
//            sessionFactory.setDataSource(dataSource);
//            return sessionFactory.getObject();
//        }
//
////    @Override
////    public boolean equals(Object obj) {
////        return super.equals(obj);
////    }
//}
