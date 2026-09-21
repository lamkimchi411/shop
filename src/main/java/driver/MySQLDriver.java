package driver;

import java.sql.Connection;
import java.sql.DriverManager;

// Import tĩnh các hằng số DB_URL, USER, PASS từ lớp Constants để sử dụng trực tiếp
import static util.Constants.*;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG: SINGLETON DESIGN PATTERN
 * Lớp MySQLDriver đóng vai trò là một "Quản lý kết nối JDBC" duy nhất trong toàn bộ ứng dụng.
 * 
 * Mục đích Singleton Pattern:
 * 1. Đảm bảo chỉ có DUY NHẤT một thể hiện (instance) của lớp MySQLDriver được tồn tại trong bộ nhớ RAM.
 * 2. Ngăn chặn việc khởi tạo nhiều đối tượng driver gây lãng phí tài nguyên hệ thống.
 * 3. Cung cấp một điểm truy cập toàn cục (Global Access Point) thông qua hàm `getInstance()`.
 */
public class MySQLDriver {

    // 1. Biến static giữ thể hiện duy nhất của đối tượng MySQLDriver
    private static MySQLDriver instance;

    // 2. Private Constructor: Ngăn không cho các lớp bên ngoài khởi tạo bằng từ khóa `new MySQLDriver()`
    private MySQLDriver() {
    }

    /**
     * Phương thức static toàn cục để truy cập thể hiện duy nhất của MySQLDriver.
     * Nguyên lý Lazy Initialization (Khởi tạo lười):
     * - Nếu `instance` chưa được tạo (null), tiến hành khởi tạo mới.
     * - Nếu đã được tạo rồi, trả về ngay thể hiện đang có.
     *
     * @return thể hiện duy nhất MySQLDriver
     */
    public static MySQLDriver getInstance() {
        if (instance == null) {
            instance = new MySQLDriver();
        }
        return instance;
    }

    /**
     * Phương thức mở và trả về một đối tượng java.sql.Connection kết nối tới CSDL MySQL.
     * 
     * Nguyên lý hoạt động từng dòng:
     * Dòng 1: Khởi tạo biến connection = null.
     * Dòng 2: Gọi `Class.forName("com.mysql.cj.jdbc.Driver")` để nạp class JDBC Driver của MySQL vào JVM.
     * Dòng 3: Gọi `DriverManager.getConnection(DB_URL, USER, PASS)` gửi yêu cầu kết nối tới MySQL Server dựa trên cấu hình chuỗi URL định dạng String.format.
     * Dòng 4: Nếu gặp lỗi kết nối (sai pass, mysql chưa bật...), bắt ngoại lệ (Catch) và in thông báo lỗi ra log.
     * Dòng 5: Trả về đối tượng Connection cho DAO sử dụng thực thi các câu lệnh SQL.
     *
     * @return Đối tượng java.sql.Connection kết nối CSDL
     */
    public Connection getConnection() {
        Connection conn = null; // Khởi tạo con trỏ kết nối ban đầu
        try {
            // Nạp Driver JDBC của MySQL 8.x vào bộ nhớ JVM
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Yêu cầu DriverManager kết nối tới CSDL MySQL bằng URL, User và Password từ Constants
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (Exception e) {
            // Bắt và in lỗi ra màn hình Console nếu kết nối thất bại
            System.err.println("⚠️ Lỗi kết nối MySQLDriver: " + e.getMessage());
        }
        return conn; // Trả về đối tượng kết nối
    }
}
