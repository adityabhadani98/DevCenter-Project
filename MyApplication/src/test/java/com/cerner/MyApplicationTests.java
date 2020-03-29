package com.cerner;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest(classes = MyApplication.class)
class MyApplicationTests {

	/**
	 * Context loads.
	 * Purpose of the test: To check whether the main method is loaded when application starts.
	 * When: Application is started then it should check whether its loaded or not.
	 * Then: Application should load successfully.
	 */
	@Test
	void contextLoads() {
		MyApplication.main(new String[] {});
	}
}