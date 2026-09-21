<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Cổ Việt Lâu | Dấu Ấn Di Sản Trường Tồn" scope="request" />
<c:set var="activePage" value="home" scope="request" />

<jsp:include page="/views/common/header.jsp" />

<!-- Bố Cục 3 Phần Stage (Nền Trái 2/3, Nền Phải Cách 70px, Ảnh Nổi Ở Giữa Đè Lên Ranh Giới) -->
<section class="stage">
    <!-- Nền trái — chiếm 2/3 -->
    <div class="bg-left" style="background-image: url('${settings['hero_bg_left'] != null ? settings['hero_bg_left'] : 'https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=1600&q=80'}');"></div>

    <!-- Nền phải — cách nền trái 70px -->
    <div class="bg-right" style="background-image: url('${settings['hero_bg_right'] != null ? settings['hero_bg_right'] : 'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=800&q=80'}');"></div>

    <!-- Lớp ảnh nổi ở giữa đè lên ranh giới 2 nền (Tăng chiều cao nổi bật) -->
    <div class="floating">
        <div style="font-size: 0.85rem; color: var(--gold-accent); text-transform: uppercase; letter-spacing: 3px; font-weight: 700; margin-bottom: 12px;">CỔ VIỆT LÂU &bull; DẤU ẤN DI SẢN TRƯỜNG TỒN</div>
        <h1 class="hero-title-red">${settings['hero_title'] != null ? settings['hero_title'] : 'HỒN THIÊNG NGHÌN NĂM'}</h1>
        <p class="hero-sub-text">${settings['hero_subtitle'] != null ? settings['hero_subtitle'] : 'VẺ ĐẸP HUYỀN BÍ, SANG TRỌNG CỦA CỔ PHỤC VIỆT'}</p>
        <div>
            <a href="${pageContext.request.contextPath}/products" class="btn-pill-red" style="padding: 14px 38px; font-size: 0.95rem;">
                KHÁM PHÁ CÁC BỘ SƯU TẬP
            </a>
        </div>
    </div>
</section>

<div class="container">
    <!-- Heritage Collection 1: Vẻ Đẹp Huyền Bí Đêm Cung Đình (Image 1 Style) -->
    <section style="margin-bottom: 60px;">
        <div class="section-header-center">
            <div class="sub-tag">THE HERITAGE COLLECTION</div>
            <h2>VẺ ĐẸP HUYỀN BÍ ĐÊM CUNG ĐÌNH</h2>
        </div>

        <div class="product-card-grid" style="grid-template-columns: repeat(2, minmax(280px, 420px)); justify-content: center; gap: 35px;">
            <div class="product-card-item">
                <div class="product-card-img" style="height: 380px;">
                    <img src="https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=800&q=80" alt="Áo Giao Lĩnh" />
                </div>
                <div class="product-card-body">
                    <h3 class="product-card-title">ÁO GIAO LĨNH</h3>
                    <a href="${pageContext.request.contextPath}/products?catId=3" class="btn-pill-outline" style="align-self: center; margin-top: 8px;">
                        XEM BỘ SƯU TẬP
                    </a>
                </div>
            </div>

            <div class="product-card-item">
                <div class="product-card-img" style="height: 380px;">
                    <img src="https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&w=800&q=80" alt="Áo Ngũ Thân" />
                </div>
                <div class="product-card-body">
                    <h3 class="product-card-title">ÁO NGỦ THÂN</h3>
                    <a href="${pageContext.request.contextPath}/products?catId=2" class="btn-pill-outline" style="align-self: center; margin-top: 8px;">
                        XEM BỘ SƯU TẬP
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Heritage Collection 2: Vẻ Đẹp Cổ Điển Cung Đình Ban Ngày (Image 1 Style) -->
    <section style="margin-bottom: 60px;">
        <div class="section-header-center">
            <div class="sub-tag">THE HERITAGE COLLECTION</div>
            <h2>VẺ ĐẸP CỔ ĐIỂN CUNG ĐÌNH BAN NGÀY</h2>
        </div>

        <div class="product-card-grid" style="grid-template-columns: repeat(3, minmax(240px, 1fr));">
            <div class="product-card-item">
                <div class="product-card-img" style="height: 360px;">
                    <img src="https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=800&q=80" alt="Áo Giao Lĩnh Cung Đình" />
                </div>
                <div class="product-card-body">
                    <h3 class="product-card-title">ÁO GIAO LĨNH</h3>
                </div>
            </div>

            <div class="product-card-item">
                <div class="product-card-img" style="height: 360px;">
                    <img src="https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=800&q=80" alt="Áo Ngũ Thân Nam Nữ" />
                </div>
                <div class="product-card-body">
                    <h3 class="product-card-title">ÁO NGŨ THÂN</h3>
                </div>
            </div>

            <div class="product-card-item">
                <div class="product-card-img" style="height: 360px;">
                    <img src="https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&w=800&q=80" alt="Áo Nhật Bình" />
                </div>
                <div class="product-card-body">
                    <h3 class="product-card-title">ÁO NHẬT BÌNH</h3>
                </div>
            </div>
        </div>
    </section>

    <!-- Material Section: CHẤT LIỆU DI SẢN (Image 1 Style) -->
    <section style="margin-bottom: 40px;">
        <div class="section-header-center">
            <h2>CHẤT LIỆU DI SẢN</h2>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 6px;">Artisan silk và gấm thêu dệt tỉ mỉ bởi nghệ nhân làng nghề truyền thống lâu đời</p>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
            <div style="position: relative; height: 260px; border-radius: var(--radius-md); overflow: hidden; border: 1px solid var(--parchment-border); box-shadow: var(--shadow-card);">
                <img src="https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?auto=format&fit=crop&w=800&q=80" alt="Artisan Silk va Gam" style="width: 100%; height: 100%; object-fit: cover;" />
                <div style="position: absolute; inset: 0; background: linear-gradient(0deg, rgba(28, 16, 14, 0.85) 0%, transparent 60%); display: flex; align-items: flex-end; padding: 20px; color: #ffffff;">
                    <div>
                        <span style="background: var(--primary-red); color: #ffffff; padding: 3px 10px; border-radius: 4px; font-size: 0.72rem; font-weight: 700; text-transform: uppercase;">ARTISAN SILK VÀ GẤM</span>
                        <h3 style="font-family: var(--font-heading); font-size: 1.3rem; margin-top: 6px;">ARTISAN SILK GẤM</h3>
                    </div>
                </div>
            </div>

            <div style="position: relative; height: 260px; border-radius: var(--radius-md); overflow: hidden; border: 1px solid var(--parchment-border); box-shadow: var(--shadow-card);">
                <img src="https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=800&q=80" alt="Chat Lieu Đoan Gam" style="width: 100%; height: 100%; object-fit: cover;" />
                <div style="position: absolute; inset: 0; background: linear-gradient(0deg, rgba(28, 16, 14, 0.85) 0%, transparent 60%); display: flex; align-items: flex-end; padding: 20px; color: #ffffff;">
                    <div>
                        <span style="background: var(--primary-red); color: #ffffff; padding: 3px 10px; border-radius: 4px; font-size: 0.72rem; font-weight: 700; text-transform: uppercase;">CHẤT LIỆU GẤM</span>
                        <h3 style="font-family: var(--font-heading); font-size: 1.3rem; margin-top: 6px;">CHẤT LIỆU DI SẢN</h3>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="/views/common/footer.jsp" />
