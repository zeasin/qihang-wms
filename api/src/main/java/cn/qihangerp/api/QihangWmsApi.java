package cn.qihangerp.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.client.RestTemplate;

@ComponentScan(basePackages={"cn.qihangerp"})
//@MapperScan("cn.qihangerp.sys.api.mapper")
@SpringBootApplication(scanBasePackages = {"cn.qihangerp.api"})
public class QihangWmsApi
{
    public static void main( String[] args )
    {
        System.out.println( "Hello qihang-wms!" );
        SpringApplication.run(QihangWmsApi.class, args);
    }

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
