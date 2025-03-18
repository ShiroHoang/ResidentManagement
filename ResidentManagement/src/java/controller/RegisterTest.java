/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author HP
 */
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;
import org.openqa.selenium.support.ui.Select;

public class RegisterTest {

    public static void main(String[] args) {
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        try {
            driver.get("http://localhost:9999/ResidentManagement/RegisterAccount"); // Change to actual URL
            driver.manage().window().maximize();

            // Switch to iframe if needed
            if (!driver.findElements(By.tagName("iframe")).isEmpty()) {
                driver.switchTo().frame(0); // Adjust based on your site
            }

            WebElement fullNameField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='Nhập họ và tên']")));
            fullNameField.sendKeys("Dương Đức Em");
            Thread.sleep(1000);

            WebElement emailField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='Nhập email']")));
            emailField.sendKeys("em@gmail.com");
            Thread.sleep(1000);

            WebElement phoneNumField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='Nhập số điện thoại']")));
            phoneNumField.sendKeys("0987654321");
            Thread.sleep(1000);

            WebElement addressField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='Nhập địa chỉ hiện tại']")));
            addressField.sendKeys("Long Biên, Hà Nội");
            Thread.sleep(1000);

            WebElement roleDropdown = wait.until(ExpectedConditions.elementToBeClickable(By.name("role")));
            Select selectRole = new Select(roleDropdown);
            selectRole.selectByVisibleText("Công an");
            Thread.sleep(1000);

            WebElement passwordField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='Nhập mật khẩu']")));
            passwordField.sendKeys("blackcat");
            Thread.sleep(1000);

            WebElement checkpassField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='Nhập lại mật khẩu']")));
            checkpassField.sendKeys("blackcat");
            Thread.sleep(1000);

            WebElement registerButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[contains(text(), 'Đăng kí')]")));
            registerButton.click();
            Thread.sleep(3000);

            WebElement backLink = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[contains(text(), 'Quay lại')]")));
            backLink.click();
            Thread.sleep(2000);

            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[contains(text(), 'Đăng nhập')]")));
            loginButton.click();
            Thread.sleep(2000);
            
            WebElement emailToLogin = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='EMAIL']")));
            emailToLogin.sendKeys("em@gmail.com");
            Thread.sleep(1000);

            WebElement passToLogin = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='MẬT KHẨU']")));
            passToLogin.sendKeys("blackcat");
            Thread.sleep(1000);
            
            WebElement logIn = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[contains(text(), 'ĐĂNG NHẬP')]")));
            logIn.click();
            Thread.sleep(2000);
            
            
            System.out.println("Login Successful!");
        } catch (Exception e) {
            System.out.println("Test failed: " + e.getMessage());
        } finally {
            driver.quit();
        }
    }
}
