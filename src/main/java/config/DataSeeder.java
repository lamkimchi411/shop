package config;

import com.github.javafaker.Faker;
import dao.*;
import model.*;

import java.util.*;

/**
 * DataSeeder - Công cụ tự động sinh và nạp dữ liệu bằng JavaFaker sử dụng DatabaseDao
 */
public class DataSeeder {

    private static final Faker faker = new Faker(new Locale("vi"));
    private static final Random random = new Random();

    public static void main(String[] args) {
        System.out.println("=================================================");
        System.out.println("🌱 BẮT ĐẦU SEED DỮ LIỆU BẰNG JAVA FAKER...");
        System.out.println("=================================================");

        seedCategories();
        List<User> customers = seedUsers();
        List<Product> products = seedProducts();
        seedOrders(customers, products);

        System.out.println("=================================================");
        System.out.println("✅ HOÀN TẤT SEED DỮ LIỆU THÀNH CÔNG!");
        System.out.println("=================================================");
    }

    private static void seedCategories() {
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        if (!categoryDao.findAll().isEmpty()) {
            System.out.println("ℹ️ Danh mục đã tồn tại, bỏ qua seed danh mục.");
            return;
        }

        Category[] cats = {
            new Category("Áo Dài Nữ", "Các mẫu Áo Dài truyền thống và cách tân dành cho phái đẹp, tôn vinh nét đẹp dịu dàng Việt Nam."),
            new Category("Áo Dài Nam", "Áo Dài Nam truyền thống, áo ngũ thân tay chẽn, mang phong thái uy nghi, sang trọng."),
            new Category("Cổ Phục Việt Nam", "Các dòng Cổ phục phục dựng chuẩn lịch sử: Áo Nhật Bình, Áo Ngũ Thân Lập Lĩnh, Áo Giao Lĩnh."),
            new Category("Áo Tứ Thân & Áo Bà Ba", "Trang phục truyền thống miền Bắc và miền Tây Nam Bộ, mộc mạc và giàu bản sắc văn hóa.")
        };

        for (Category c : cats) {
            categoryDao.insert(c);
        }
        System.out.println("✔️ Đã seed 4 Danh mục trang phục.");
    }

    private static List<User> seedUsers() {
        System.out.println("🌱 Đang seed tài khoản người dùng...");
        UserDao userDao = DatabaseDao.getInstance().getUserDao();

        if (userDao.findByUsername("admin") == null) {
            userDao.insert(new User("admin", "admin123", "Quản Trị Viên Hàng Đầu", "admin@coyeuviet.vn", "0901234567", "79 Hoàng Hoa Thám, Ba Đình, Hà Nội", "ADMIN"));
        }
        if (userDao.findByUsername("customer") == null) {
            userDao.insert(new User("customer", "123456", "Nguyễn Thị Hoa", "hoanguyen@gmail.com", "0987654321", "123 Nguyễn Huệ, Quận 1, TP. HCM", "CUSTOMER"));
        }

        for (int i = 1; i <= 15; i++) {
            String username = "user_faker_" + i;
            if (userDao.findByUsername(username) == null) {
                String fullname = faker.name().fullName();
                String email = "faker_" + i + "@gmail.com";
                String phone = "09" + faker.number().digits(8);
                String address = faker.address().streetAddress() + ", " + faker.address().cityName();

                User user = new User(username, "123456", fullname, email, phone, address, "CUSTOMER");
                userDao.insert(user);
            }
        }

        List<User> allUsers = userDao.findAll();
        System.out.println("✔️ Tổng số tài khoản hiện có trong CSDL: " + allUsers.size());
        return allUsers;
    }

    private static List<Product> seedProducts() {
        System.out.println("🌱 Đang seed danh sách trang phục Áo Dài & Cổ Phục...");
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();

        List<Category> categories = categoryDao.findAll();
        if (categories.isEmpty()) return new ArrayList<>();

        int catAoDaiNu = categories.get(0).getId();
        int catAoDaiNam = categories.size() > 1 ? categories.get(1).getId() : catAoDaiNu;
        int catCoPhuc = categories.size() > 2 ? categories.get(2).getId() : catAoDaiNu;
        int catTuThan = categories.size() > 3 ? categories.get(3).getId() : catAoDaiNu;

        Object[][] sampleAttires = {
            {"Áo Dài Lụa Tơ Tằm Thêu Hoa Sen", 2500000.0, 15, "static/images/aodai-sen.jpg", "Áo dài nữ chất liệu lụa tơ tằm Bảo Lộc thêu thủ công hoa sen tinh tế, mang vẻ đẹp thanh cao truyền thống.", catAoDaiNu},
            {"Áo Dài Gấm Đỏ Họa Tiết Chim Phượng", 1850000.0, 20, "static/images/aodai-phuong.jpg", "Áo dài gấm thượng hạng sắc đỏ rực rỡ, may chuẩn dáng truyền thống 4 tà mềm mại phù hợp dịp lễ tết và cưới hỏi.", catAoDaiNu},
            {"Áo Dài Nhung Đỏ Đô Cổ Tàu Truyền Thống", 2100000.0, 12, "static/images/aodai-nhung.jpg", "Chất liệu nhung tuyết cao cấp màu đỏ đô sang trọng, đường cắt may tỉ mỉ tôn dáng người mặc.", catAoDaiNu},
            {"Áo Dài Cách Tân Lụa Tơ Tằm Dáng Xòe", 1450000.0, 25, "static/images/aodai-cachtan.jpg", "Mẫu áo dài cách tân hiện đại trẻ trung, kết hợp chân váy tơ mỏng 2 lớp nhẹ nhàng nữ tính.", catAoDaiNu},
            {"Áo Dài Cưới Gấm Hoàng Gia Thêu Rồng Phụng", 4200000.0, 8, "static/images/aodai-cuoi.jpg", "Bộ áo dài cưới uyên ương song hỷ may gấm tơ tằm thêu tay tỉ mỉ từng chi tiết, lộng lẫy trong ngày trọng đại.", catAoDaiNu},

            {"Áo Ngũ Thân Nam Tay Chẽn Hoàng Gia", 3200000.0, 10, "static/images/aonguthan-nam.jpg", "Cổ phục Áo Ngũ Thân nam chất liệu gấm tơ tằm, đường khâu thủ công tinh xảo, thể hiện nét khí phách nam nhi Việt.", catAoDaiNam},
            {"Áo Dài Nam Trắng Thêu Rồng Mây", 2200000.0, 14, "static/images/aodai-rong.jpg", "Áo dài nam phong cách tân cổ điển, gam màu trắng thanh lịch thêu họa tiết Rồng mây khí chất.", catAoDaiNam},
            {"Áo Ngũ Thân Nam Tay Thụi Sắc Xanh Chàm", 2800000.0, 11, "static/images/nguthan-xanh.jpg", "Cổ phục nam áo ngũ thân lập lĩnh tay thụi truyền thống, dệt gấm hoa văn chữ Thọ ý nghĩa phong thủy.", catAoDaiNam},
            {"Áo Dài Nam Gấm Đen Họa Tiết Trống Đồng", 2600000.0, 18, "static/images/aodai-trongdong.jpg", "Áo dài nam gấm đen uy nghi thêu biểu tượng Trống Đồng Đông Sơn đậm đà lòng tự hào dân tộc.", catAoDaiNam},

            {"Áo Nhật Bình Triều Nguyễn (Sắc Tím Cung Đình)", 4500000.0, 8, "static/images/nhatbinh-tim.jpg", "Cổ phục Áo Nhật Bình may chuẩn phom dáng thời Nguyễn, hoa văn may thêu dải cổ tay và ngực áo vô cùng lộng lẫy.", catCoPhuc},
            {"Áo Giao Lĩnh Cổ Phục Việt Nam", 2900000.0, 9, "static/images/giaolinh.jpg", "Cổ phục Áo Giao Lĩnh cổ chéo kết hợp dải xiêm thắt lưng, chất liệu lụa cao cấp tự nhiên.", catCoPhuc},
            {"Áo Đối Khâm Triều Lý - Trần", 3600000.0, 7, "static/images/doikham.jpg", "Cổ phục Áo Đối Khâm phục dựng thời Lý Trần, chất liệu tơ tằm dệt tay hoa văn mây sóng thanh thoát.", catCoPhuc},
            {"Áo Nhật Bình Sắc Đỏ Hoàng Mới May", 4800000.0, 6, "static/images/nhatbinh-do.jpg", "Áo Nhật Bình quý tộc sắc đỏ rực rỡ, kèm kim khánh và nón quai thao chụp ảnh cổ phong ấn tượng.", catCoPhuc},

            {"Áo Tứ Thân Kinh Bắc Kèm Yếm Thắm", 1650000.0, 12, "static/images/tuthan-kinhbac.jpg", "Bộ Áo Tứ Thân truyền thống xứ Kinh Bắc gồm áo khoác ngoài, áo yếm lụa đỏ, nón lá chao và khăn mỏ quạ.", catTuThan},
            {"Áo Bà Ba Nam Bộ Lụa Nam Tuyền", 850000.0, 25, "static/images/baba-nambo.jpg", "Bộ áo bà ba chất liệu lụa Nam Tuyền mềm mát, kèm khăn truyền thống đậm đà bản sắc Nam Bộ.", catTuThan},
            {"Áo Bà Ba Nữ Họa Tiết Hoa Mai Lụa Tơ", 950000.0, 22, "static/images/baba-hoamai.jpg", "Bộ áo bà ba nữ màu vàng nhạt may lụa gấm thêu hoa mai dịu dàng thanh lịch duyên dáng.", catTuThan}
        };

        List<Product> existingProducts = productDao.findAll();
        if (existingProducts.size() < sampleAttires.length) {
            for (Object[] item : sampleAttires) {
                String name = (String) item[0];
                double price = (Double) item[1];
                int quantity = (Integer) item[2];
                String image = (String) item[3];
                String desc = (String) item[4];
                int catId = (Integer) item[5];

                boolean exists = existingProducts.stream().anyMatch(p -> p.getName().equalsIgnoreCase(name));
                if (!exists) {
                    productDao.insert(new Product(name, price, quantity, image, desc, catId));
                }
            }
        }

        List<Product> allProducts = productDao.findAll();
        System.out.println("✔️ Tổng số sản phẩm Áo dài & Cổ phục hiện có: " + allProducts.size());
        return allProducts;
    }

    private static void seedOrders(List<User> users, List<Product> products) {
        if (users.isEmpty() || products.isEmpty()) return;
        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();

        System.out.println("🌱 Đang seed danh sách đơn hàng...");
        String[] statuses = {"PENDING", "PROCESSING", "SHIPPED", "COMPLETED"};

        for (int i = 0; i < 10; i++) {
            User randomUser = users.get(random.nextInt(users.size()));
            if (randomUser.isAdmin()) continue;

            int itemCount = random.nextInt(3) + 1;
            double totalMoney = 0;
            List<OrderDetail> details = new ArrayList<>();

            for (int j = 0; j < itemCount; j++) {
                Product randomProduct = products.get(random.nextInt(products.size()));
                int qty = random.nextInt(2) + 1;
                double price = randomProduct.getPrice();

                totalMoney += price * qty;
                details.add(new OrderDetail(randomProduct.getId(), price, qty));
            }

            Order order = new Order();
            order.setUserId(randomUser.getId());
            order.setTotalMoney(totalMoney);
            order.setShippingAddress(randomUser.getAddress() != null && !randomUser.getAddress().isEmpty() 
                    ? randomUser.getAddress() : faker.address().fullAddress());
            order.setStatus(statuses[random.nextInt(statuses.length)]);
            order.setDetails(details);

            orderDao.insert(order);
        }

        System.out.println("✔️ Đã seed 10 Đơn hàng mẫu kèm chi tiết.");
    }
}
