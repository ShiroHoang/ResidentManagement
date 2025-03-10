import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class SeleniumLoginTest {
    public static void main(String[] args) {
        // Set up the ChromeDriver path (Ensure chromedriver is in the correct location)

        try {
            WebDriver driver = new ChromeDriver();

            // Open login page
            driver.get("https://huynq.site/ResidentManagement/login"); 

            // Find and fill in username and password fields
            WebElement usernameField = driver.findElement(By.id("username")); // Replace with actual ID
            WebElement passwordField = driver.findElement(By.id("password")); // Replace with actual ID
            usernameField.sendKeys("a@gmail.com");
            passwordField.sendKeys("123");

            // Find and click login button
            WebElement loginButton = driver.findElement(By.id("loginButton")); // Replace with actual ID
            loginButton.click();

            // Optional: Wait or validate successful login
            Thread.sleep(2000); // Not recommended for real use, use WebDriverWait

            // Close browser
            driver.quit();
        } catch (Exception e) {
            e.printStackTrace(); // Print errors for debugging
        }
    }
}
