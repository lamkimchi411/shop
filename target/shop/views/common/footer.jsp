<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <!-- Footer Section (Image 1 & 2 Style) -->
    <footer class="site-footer">
        <div class="footer-inner-grid">
            <div style="display: flex; gap: 15px; align-items: flex-start;">
                <div style="width: 85px; height: 85px; border-radius: 8px; overflow: hidden; border: 1.5px solid var(--gold-accent); flex-shrink: 0; box-shadow: 0 4px 12px rgba(0,0,0,0.35);">
                    <img src="https://images.unsplash.com/photo-1548625361-18da827a5d3e?auto=format&fit=crop&w=300&q=80" alt="Bản đồ Cố Đô Huế" style="width: 100%; height: 100%; object-fit: cover;" />
                </div>
                <div>
                    <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                        <div class="stamp-seal-logo" style="width: 34px; height: 34px; font-size: 0.72rem;">CỔ<br/>VIỆT</div>
                        <div>
                            <div style="font-family: var(--font-heading); font-size: 1.15rem; color: var(--gold-accent); font-weight: 800;">CỔ VIỆT LÂU</div>
                            <div style="font-size: 0.62rem; color: #a59684; text-transform: uppercase; letter-spacing: 1.5px;">DẤU ẤN DI SẢN TRƯỜNG TỒN</div>
                        </div>
                    </div>
                    <p style="font-size: 0.8rem; line-height: 1.4; color: #b0a494;">Cổ Việt Lâu chuyên may đo &amp; tôn vinh các dòng cổ phục Việt Nam truyền thống: Áo Nhật Bình, Áo Giao Lĩnh, Áo Ngũ Thân, Áo Dài Tơ Tằm.</p>
                </div>
            </div>
            
            <div>
                <h5>HUẾ</h5>
                <p><i class="fa-solid fa-location-dot" style="color: var(--gold-accent);"></i> Áo Huế</p>
                <p>Áo Nhật Bình</p>
                <p>Giao Lĩnh</p>
                <p>Ngũ Thân</p>
            </div>

            <div>
                <h5>LIÊN HỆ</h5>
                <p><i class="fa-solid fa-phone" style="color: var(--gold-accent);"></i> 0901.234.567</p>
                <p><i class="fa-solid fa-envelope" style="color: var(--gold-accent);"></i> contact@covietlau.vn</p>
                <div style="display: flex; gap: 12px; font-size: 1.1rem; color: var(--gold-accent); margin-top: 10px;">
                    <a href="#"><i class="fa-brands fa-facebook"></i></a>
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#"><i class="fa-brands fa-tiktok"></i></a>
                </div>
            </div>

            <div>
                <h5>ĐĂNG KÝ NHẬN TIN</h5>
                <p>Nhận thông báo bộ sưu tập cổ phục mới nhất.</p>
                <div style="display: flex; gap: 6px; margin-top: 10px;">
                    <input type="email" placeholder="Email của bạn..." style="padding: 8px 14px; border-radius: 50px; border: 1px solid var(--border-color); background: #231512; color: #ffffff; width: 100%; font-size: 0.8rem;" />
                    <button class="btn-pill-red" style="padding: 8px 14px;"><i class="fa-solid fa-paper-plane"></i></button>
                </div>
            </div>
        </div>

        <div class="footer-bottom-bar">
            <p>&copy; 2026 CỔ VIỆT LÂU ALL RIGHTS RESERVED. TRANG PHỤC TRUYỀN THỐNG VIỆT NAM.</p>
        </div>
    </footer>
</div> <!-- Close page-frame -->

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            if (!img.classList.contains('no-animate')) {
                img.classList.add('animate-on-scroll');
            }
        });

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('is-visible');
                    observer.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -30px 0px'
        });

        document.querySelectorAll('.animate-on-scroll').forEach(el => observer.observe(el));

        // Thông báo thành công/thất bại tự ẩn sau 3 giây.
        document.querySelectorAll('.alert-heritage').forEach(alert => {
            window.setTimeout(() => {
                alert.classList.add('is-dismissing');
                window.setTimeout(() => {
                    const wrapper = alert.parentElement;
                    if (wrapper && wrapper.classList.contains('container')) {
                        wrapper.remove();
                    } else {
                        alert.remove();
                    }
                }, 350);
            }, 3000);
        });

        document.querySelectorAll('.password-toggle').forEach(button => {
            button.addEventListener('click', () => {
                const input = document.getElementById(button.dataset.target);
                if (!input) return;
                const visible = input.type === 'text';
                input.type = visible ? 'password' : 'text';
                button.setAttribute('aria-label', visible ? 'Hiện mật khẩu' : 'Ẩn mật khẩu');
                button.querySelector('i').className = visible ? 'fa-solid fa-eye' : 'fa-solid fa-eye-slash';
            });
        });

        const imageFile = document.getElementById('imageFile');
        const imageUrl = document.getElementById('imageUrl');
        const uploadStatus = document.getElementById('uploadStatus');
        if (imageFile && imageUrl && uploadStatus) {
            imageFile.addEventListener('change', async () => {
                if (!imageFile.files.length) return;
                uploadStatus.textContent = 'Đang tải ảnh lên…';
                const data = new FormData();
                data.append('action', 'upload');
                data.append('imageFile', imageFile.files[0]);
                try {
                    const response = await fetch('${pageContext.request.contextPath}/admin/products?action=upload', { method: 'POST', body: data });
                    const result = await response.json();
                    if (!response.ok || !result.success) throw new Error(result.message || 'Máy chủ không thể lưu ảnh.');
                    imageUrl.value = result.url;
                    imageFile.value = '';
                    uploadStatus.textContent = 'Tải ảnh thành công. URL đã được điền tự động.';
                    uploadStatus.style.color = 'var(--success-green, #155724)';
                } catch (error) {
                    uploadStatus.textContent = 'Tải ảnh thất bại: ' + error.message;
                    uploadStatus.style.color = 'var(--primary-red)';
                }
            });
        }
    });
</script>
</body>
</html>
