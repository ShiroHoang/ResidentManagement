package Test;

import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;


public class LoginTest {
    public static void main(String[] args) {
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        try {
            driver.get("https://huynq.site/ResidentManagement/login"); // Change to actual URL
            driver.manage().window().maximize();

            // Switch to iframe if needed
            if (!driver.findElements(By.tagName("iframe")).isEmpty()) {
                driver.switchTo().frame(0); // Adjust based on your site
            }

            // Locate email field using XPath (change placeholder text if needed)
            WebElement emailField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='EMAIL']")));
            emailField.sendKeys("a@gmail.com");
            Thread.sleep(3000);
            // Locate password field
            WebElement passwordField = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//input[@placeholder='MẬT KHẨU']")));
            passwordField.sendKeys("123");
            Thread.sleep(3000);
            // Click login button
            WebElement loginButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//button[contains(text(), 'ĐĂNG NHẬP')]")));
            loginButton.click();

            System.out.println("Login Successful!");
        } catch (Exception e) {
            System.out.println("Test failed: " + e.getMessage());
        } finally {
            driver.quit();
        }
    }
}