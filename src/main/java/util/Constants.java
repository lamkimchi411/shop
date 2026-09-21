package util;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG:
 * Lớp Constants đóng vai trò chứa toàn bộ các hằng số cấu hình hệ thống (Database, Pagination, Limit).
 * Giúp tránh việc "hardcode" (viết cứng) chuỗi hoặc số ở nhiều nơi, dễ dàng bảo trì và thay đổi cấu hình từ một nơi duy nhất.
 */
public class Constants {

    // Lấy thông tin cấu hình từ Biến Môi Trường (System.getenv) nếu có, nếu không thì dùng giá trị mặc định "localhost"
    // Vai trò: Linh hoạt khi triển khai trên môi trường Docker/Server thực tế mà không cần sửa code.
    public static final String HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";

    // Cổng kết nối MySQL mặc định là 3306
    public static final String PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";

    // Tên Cơ Sở Dữ Liệu MySQL của ứng dụng
    public static final String DB_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "aodai_shop";

    // Tài khoản đăng nhập MySQL (mặc định của XAMPP/MySQL Local thường là root)
    public static final String USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";

    // Mật khẩu đăng nhập MySQL
    public static final String PASS = System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "123456";

    /**
     * NGUYÊN LÝ HOẠT ĐỘNG:
     * Định dạng Chuỗi Kết Nối JDBC (JDBC Connection String) bằng String.format() theo đúng yêu cầu người dùng.
     * %s thứ 1: HOST (ví dụ: localhost)
     * %s thứ 2: PORT (ví dụ: 3306)
     * %s thứ 3: DB_NAME (ví dụ: aodai_shop)
     *
     * Các tham số bổ sung:
     * - useUnicode=true & characterEncoding=UTF-8: Đảm bảo đọc/ghi tiếng Việt có dấu không bị lỗi font (???).
     * - useSSL=false: Tắt SSL khi kết nối MySQL local để tăng tốc độ và tránh lỗi chứng chỉ.
     * - allowPublicKeyRetrieval=true: Cho phép JDBC tương thích với cơ chế xác thực MySQL 8.0+.
     * - serverTimezone=UTC: Đồng bộ múi giờ tránh lỗi lệch giờ giữa Server và Database.
     */
    public static final String DB_URL = String.format(
            "jdbc:mysql://%s:%s/%s?useUnicode=true&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
            HOST, PORT, DB_NAME
    );

    // Hằng số giới hạn số lượng sản phẩm hiển thị trên một trang (phân trang hoặc hiển thị tin mới/nổi bật)
    public static final int NUMBER_LIMIT = 8;
}
