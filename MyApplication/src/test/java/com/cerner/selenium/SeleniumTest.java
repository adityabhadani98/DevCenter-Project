/**
 * 
 */
package com.cerner.selenium;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.cerner.MyApplication;

/**
 * @author AB078404
 *
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = MyApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class SeleniumTest {
	
	WebElement element;
	static WebDriver driver;
	@BeforeEach 
	public void BrowserOpen() 
	{ 
		System.setProperty("webdriver.chrome.driver", "C:\\Users\\ab078404\\Documents\\backup_app\\MyApplication\\chromedriver.exe");
		driver= new ChromeDriver() ;     
	}
	
	@Test
	public void validUserCredentials() throws InterruptedException{
		driver.get("http://localhost:8080/login");
		driver.findElement(By.id("myInput1")).sendKeys("1");  // sending ID
  		driver.findElement(By.id("myInput2")).sendKeys("yes"); // Sending password
		driver.findElement(By.id("myOutput1")).click();
		Thread.sleep(2000);
		driver.findElement(By.id("myInput3")).click();
		Thread.sleep(2000);
		assertEquals("http://localhost:8080/login-user",driver.getCurrentUrl());
		driver.quit();
	}
	
	@Test
	public void InvalidUserCredentials() throws InterruptedException{
		driver.get("http://localhost:8080/login");
		driver.findElement(By.id("myInput1")).sendKeys("11");  // sending ID
  		driver.findElement(By.id("myInput2")).sendKeys("duaa"); // Sending password
		driver.findElement(By.id("myOutput1")).click();
		Thread.sleep(2000);
		String actual_msg=driver.findElement(By.id("myInput3")).getText();
		String expect_msg="Invalid Userid or Password";
		assertEquals(actual_msg,expect_msg);
		driver.quit();
	}
	
	@Test
	public void EmptyUserCredentials() throws InterruptedException{
		driver.get("http://localhost:8080/login");
		driver.findElement(By.id("myInput1")).sendKeys("");  // sending ID
  		driver.findElement(By.id("myInput2")).sendKeys("yes"); // Sending password
		driver.findElement(By.id("myOutput1")).click();
		Thread.sleep(2000);
		driver.findElement(By.id("myInput3")).click();
		Thread.sleep(2000);
		assertEquals("http://localhost:8080/login",driver.getCurrentUrl());  // empty field so redirects into the same url
		driver.quit();
	}  
}
