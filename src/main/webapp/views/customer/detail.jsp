<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="${product.name} | Cổ Việt Lâu" scope="request" />
<c:set var="activePage" value="products" scope="request" />

<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <!-- Breadcrumb -->
    <div style="font-size: 0.88rem; color: var(--text-muted); margin-bottom: 25px;">
        <a href="${pageContext.request.contextPath}/home" style="color: var(--dark-wood);">Trang chủ</a> / 
        <a href="${pageContext.request.contextPath}/products" style="color: var(--dark-wood);">Bộ sưu tập di sản</a> / 
        <span style="color: var(--primary-red); font-weight: 700;">${product.name}</span>
    </div>

    <!-- Product Detail Layout -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 45px; background: var(--parchment-card); padding: 40px; border-radius: var(--radius-lg); border: 1px solid var(--parchment-border); box-shadow: var(--shadow-ma-mi);">
        <!-- Image Gallery Side -->
        <div>
            <div style="height: 480px; border-radius: var(--radius-md); overflow: hidden; border: 1px solid var(--parchment-border); background: #eee7da; position: relative;">
                <img src="${product.imageUrl != null ? product.imageUrl : 'https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=800&q=80'}" alt="${product.name}" style="width: 100%; height: 100%; object-fit: cover;" />
                <span class="material-badge" style="position: absolute; top: 16px; left: 16px; font-size: 0.8rem; padding: 6px 14px;">DI SẢN MAY ĐO</span>
            </div>
        </div>

        <!-- Info & Order Action Side -->
        <div style="display: flex; flex-direction: column;">
            <div style="font-size: 0.8rem; color: var(--gold-accent); text-transform: uppercase; letter-spacing: 2px; font-weight: 700; margin-bottom: 8px;">CỔ PHỤC TRIỀU NGUYỄN</div>
            <h1 style="font-family: var(--font-heading); font-size: 2.3rem; color: var(--dark-wood); margin-bottom: 12px; line-height: 1.2;">${product.name}</h1>
            
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--primary-red); margin-bottom: 20px;">
                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
            </div>

            <div style="border-top: 1px solid var(--parchment-border); border-bottom: 1px solid var(--parchment-border); padding: 20px 0; margin-bottom: 25px;">
                <h4 style="font-weight: 700; font-size: 0.95rem; color: var(--dark-wood); margin-bottom: 8px;">MÔ TẢ DI SẢN &amp; CHẤT LIỆU:</h4>
                <p style="font-size: 0.92rem; color: var(--text-muted); line-height: 1.6;">
                    ${product.description != null && !product.description.isEmpty() ? product.description : 'Sản phẩm được thêu dệt tỉ mỉ từ gấm lụa cao cấp với đường kim mũi chỉ chuẩn mực của các nghệ nhân cung đình Huế. Áo mang đậm nét đẹp uy nghi, cổ điển và sang trọng.'}
                </p>
                <div style="margin-top: 12px; font-size: 0.85rem; color: var(--dark-wood); display: flex; gap: 20px;">
                    <span><i class="fa-solid fa-gem" style="color: var(--gold-accent);"></i> 100% Tơ tằm gấm</span>
                    <span><i class="fa-solid fa-scissors" style="color: var(--gold-accent);"></i> May đo theo yêu cầu</span>
                </div>
            </div>

            <!-- Size Selector & Buy Now Form -->
            <form action="${pageContext.request.contextPath}/checkout" method="get">
                <input type="hidden" name="productId" value="${product.id}" />

                <div style="margin-bottom: 20px;">
                    <label style="display: block; font-weight: 700; font-size: 0.88rem; margin-bottom: 10px; color: var(--dark-wood);">CHỌN KÍCH THƯỚC MAY ĐO:</label>
                    <div style="display: flex; gap: 10px;">
                        <label class="btn-pill-outline" style="padding: 8px 18px; font-size: 0.85rem; cursor: pointer;">
                            <input type="radio" name="size" value="S" checked style="accent-color: var(--primary-red);" /> Size S
                        </label>
                        <label class="btn-pill-outline" style="padding: 8px 18px; font-size: 0.85rem; cursor: pointer;">
                            <input type="radio" name="size" value="M" style="accent-color: var(--primary-red);" /> Size M
                        </label>
                        <label class="btn-pill-outline" style="padding: 8px 18px; font-size: 0.85rem; cursor: pointer;">
                            <input type="radio" name="size" value="L" style="accent-color: var(--primary-red);" /> Size L
                        </label>
                        <label class="btn-pill-outline" style="padding: 8px 18px; font-size: 0.85rem; cursor: pointer;">
                            <input type="radio" name="size" value="CUSTOM" style="accent-color: var(--primary-red);" /> May Theo Số Đo
                        </label>
                    </div>
                </div>

                <div style="display: flex; align-items: center; gap: 20px; margin-bottom: 30px;">
                    <div class="qty-control">
                        <button type="button" class="qty-btn" onclick="let input = this.nextElementSibling; if(input.value > 1) input.value--;">-</button>
                        <input type="number" name="quantity" value="1" min="1" class="qty-input" />
                        <button type="button" class="qty-btn" onclick="let input = this.previousElementSibling; input.value++;">+</button>
                    </div>

                    <button type="submit" class="btn-pill-red" style="flex: 1; padding: 14px; font-size: 1rem; justify-content: center;">
                        <i class="fa-solid fa-bag-shopping"></i> MUA NGAY
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
