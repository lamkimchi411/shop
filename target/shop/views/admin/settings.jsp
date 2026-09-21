<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="Cài Đặt Banner & Giao Diện - Admin Panel" scope="request" />
<c:set var="adminPage" value="settings" scope="request" />

<jsp:include page="/views/common/admin-header.jsp" />

<div class="admin-layout">
    <!-- Admin Sidebar -->
    <aside class="admin-sidebar">
        <div style="font-family: var(--font-heading); font-size: 1.15rem; color: var(--gold-accent); margin-bottom: 25px; padding-bottom: 10px; border-bottom: 1px solid rgba(197, 160, 89, 0.3); letter-spacing: 1px;">
            <i class="fa-solid fa-sliders"></i> QUẢN TRỊ VIỆN
        </div>
        <ul class="admin-sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-house"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users"></i> Người dùng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list-ul"></i> Danh mục</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-shirt"></i> Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice"></i> Đơn hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/settings" class="active"><i class="fa-solid fa-gear"></i> Cài đặt Banner</a></li>
        </ul>
    </aside>

    <!-- Main Settings Form Content -->
    <main class="admin-content">
        <div style="margin-bottom: 25px;">
            <h1 style="font-family: var(--font-heading); font-size: 1.8rem; color: var(--primary-red);">
                <i class="fa-solid fa-sliders"></i> CÀI ĐẶT BANNER STAGE (GIAO DIỆN 3 PHẦN NỔI)
            </h1>
            <p style="color: var(--text-muted); font-size: 0.9rem;">Tùy chỉnh hình ảnh Nền Trái (2/3), Nền Phải (1/3), Ảnh Nổi Ở Giữa và Tiêu Đề Trang Chủ</p>
        </div>

        <form action="${pageContext.request.contextPath}/admin/settings" method="post" enctype="multipart/form-data">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                
                <!-- Left Column: Image Settings -->
                <div class="dashboard-card">
                    <div class="dashboard-card-title">
                        <i class="fa-solid fa-image" style="color: var(--primary-red);"></i> HÌNH ẢNH NỀN STAGE (LAYOUT 3 PHẦN)
                    </div>

                    <!-- Nền Trái 2/3 -->
                    <div class="form-group-heritage">
                        <label>1. Nền Trái (Chiếm 2/3 Bố Cục):</label>
                        <div class="form-input-wrapper" style="margin-bottom: 8px;">
                            <i class="fa-solid fa-link"></i>
                            <input type="text" name="hero_bg_left" value="${settings['hero_bg_left']}" class="form-control-heritage" placeholder="URL Ảnh Nền Trái (https://...)" />
                        </div>
                        <input type="file" name="hero_bg_left_file" accept="image/*" style="font-size: 0.82rem; color: var(--text-muted);" />
                        <div style="margin-top: 10px; height: 110px; border-radius: 8px; overflow: hidden; border: 1px solid var(--parchment-border);">
                            <img src="${settings['hero_bg_left']}" alt="Nền Trái Preview" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.src='https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=800&q=80'" />
                        </div>
                    </div>

                    <!-- Nền Phải 1/3 -->
                    <div class="form-group-heritage" style="margin-top: 25px;">
                        <label>2. Nền Phải (Chiếm 1/3 Cách Nền Trái 70px):</label>
                        <div class="form-input-wrapper" style="margin-bottom: 8px;">
                            <i class="fa-solid fa-link"></i>
                            <input type="text" name="hero_bg_right" value="${settings['hero_bg_right']}" class="form-control-heritage" placeholder="URL Ảnh Nền Phải (https://...)" />
                        </div>
                        <input type="file" name="hero_bg_right_file" accept="image/*" style="font-size: 0.82rem; color: var(--text-muted);" />
                        <div style="margin-top: 10px; height: 110px; border-radius: 8px; overflow: hidden; border: 1px solid var(--parchment-border);">
                            <img src="${settings['hero_bg_right']}" alt="Nền Phải Preview" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.src='https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=800&q=80'" />
                        </div>
                    </div>

                    <!-- Ảnh Nổi Ở Giữa -->
                    <div class="form-group-heritage" style="margin-top: 25px;">
                        <label>3. Ảnh/Khung Nổi Ở Giữa (Đè Lên Ranh Giới 2 Nền):</label>
                        <div class="form-input-wrapper" style="margin-bottom: 8px;">
                            <i class="fa-solid fa-link"></i>
                            <input type="text" name="hero_floating_img" value="${settings['hero_floating_img']}" class="form-control-heritage" placeholder="URL Ảnh Nổi Ở Giữa (https://...)" />
                        </div>
                        <input type="file" name="hero_floating_img_file" accept="image/*" style="font-size: 0.82rem; color: var(--text-muted);" />
                        <div style="margin-top: 10px; height: 130px; border-radius: 8px; overflow: hidden; border: 1px solid var(--gold-accent);">
                            <img src="${settings['hero_floating_img']}" alt="Ảnh Nổi Preview" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.src='https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&w=800&q=80'" />
                        </div>
                    </div>
                </div>

                <!-- Right Column: Text Settings & Actions -->
                <div style="display: flex; flex-direction: column; gap: 25px;">
                    <div class="dashboard-card">
                        <div class="dashboard-card-title">
                            <i class="fa-solid fa-pen-nib" style="color: var(--primary-red);"></i> TIÊU ĐỀ BANNER TRANG CHỦ
                        </div>

                        <div class="form-group-heritage">
                            <label>Tiêu Đề Đại Tự (Hero Title):</label>
                            <input type="text" name="hero_title" value="${settings['hero_title']}" class="form-control-heritage" placeholder="HỒN THIÊNG NGHÌN NĂM..." style="padding-left: 16px;" required />
                        </div>

                        <div class="form-group-heritage">
                            <label>Dòng Phụ Tiêu Đề (Hero Subtitle):</label>
                            <textarea name="hero_subtitle" class="form-control-heritage" style="height: 100px; padding: 14px; border-radius: var(--radius-md);" placeholder="VẺ ĐẸP HUYỀN BÍ, SANG TRỌNG CỦA CỔ PHỤC VIỆT...">${settings['hero_subtitle']}</textarea>
                        </div>
                    </div>

                    <div class="dashboard-card" style="background: #fffdf9;">
                        <h4 style="font-family: var(--font-heading); color: var(--gold-accent); margin-bottom: 12px; font-size: 1rem;">
                            <i class="fa-solid fa-lightbulb"></i> HƯỚNG DẪN CẤU HÌNH BANNER STAGE:
                        </h4>
                        <ul style="padding-left: 20px; font-size: 0.85rem; color: var(--text-muted); line-height: 1.6;">
                            <li>Bố cục Stage được chia làm 3 phần: Nền trái chiếm 2/3 (66.666%), Nền phải chiếm 1/3 cách 70px.</li>
                            <li>Lớp khung ảnh nổi (floating) tăng chiều cao tối đa, căn giữa và đè trực tiếp lên ranh giới giữa 2 lớp nền.</li>
                            <li>Bạn có thể chọn dán URL ảnh trực tiếp hoặc tải tệp ảnh từ máy tính lên.</li>
                        </ul>

                        <div style="margin-top: 25px;">
                            <button type="submit" class="btn-pill-red" style="width: 100%; padding: 14px; font-size: 0.95rem; justify-content: center;">
                                <i class="fa-solid fa-floppy-disk"></i> LƯU CẤU HÌNH BANNER
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </main>
</div>
