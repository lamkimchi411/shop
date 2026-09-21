<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Bộ Sưu Tập Di Sản | Cổ Việt Lâu" scope="request" />
<c:set var="activePage" value="products" scope="request" />

<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <!-- Header Title Banner (Image 2 Style) -->
    <div class="heritage-title" style="margin-bottom: 30px;">
        <div style="font-size: 0.85rem; color: var(--gold-accent); text-transform: uppercase; letter-spacing: 3px; font-weight: 700; margin-bottom: 6px;">HERITAGE COLLECTION</div>
        <h2>BỘ SƯU TẬP DI SẢN</h2>
        <p>Danh mục cổ phục Việt Nam may đo tinh xảo với lụa gấm truyền thống</p>
    </div>

    <!-- Catalog Wrapper with Sidebar (Image 2 Style) -->
    <div class="catalog-wrapper">
        <!-- Sidebar Category Filters -->
        <aside class="catalog-sidebar">
            <h3 class="sidebar-title">CATEGORY:</h3>
            <ul class="category-filter-list">
                <li>
                    <a href="${pageContext.request.contextPath}/products" class="${selectedCatId == null ? 'active' : ''}">
                        <span>Tất Cả Sản Phẩm</span>
                    </a>
                </li>
                <c:forEach var="c" items="${categories}">
                    <li>
                        <a href="${pageContext.request.contextPath}/products?catId=${c.id}" class="${selectedCatId == c.id ? 'active' : ''}">
                            <span>${c.name}</span>
                            <i class="fa-solid fa-chevron-right" style="font-size: 0.75rem;"></i>
                        </a>
                    </li>
                </c:forEach>
            </ul>

            <!-- Search Filter Box -->
            <div style="margin-top: 30px; border-top: 1px solid var(--parchment-border); padding-top: 20px;">
                <h4 style="font-family: var(--font-heading); font-size: 0.95rem; color: var(--dark-wood); margin-bottom: 12px; font-weight: 700;">TÌM KIẾM CỔ PHỤC:</h4>
                <form action="${pageContext.request.contextPath}/products" method="get">
                    <div class="form-input-wrapper">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" name="keyword" value="${param.keyword}" class="form-control-heritage" placeholder="Tên áo, chất liệu..." style="padding-top: 10px; padding-bottom: 10px;" />
                    </div>
                    <button type="submit" class="btn-pill-gold" style="width: 100%; margin-top: 12px; justify-content: center;">TÌM KIẾM</button>
                </form>
            </div>
        </aside>

        <!-- Main Product Grid -->
        <main>
            <!-- Sort & Results Header -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; background: var(--parchment-card); padding: 14px 20px; border-radius: var(--radius-md); border: 1px solid var(--parchment-border);">
                <div style="font-size: 0.9rem; font-weight: 600; color: var(--text-muted);">
                    Hiển thị <strong>${products != null ? products.size() : 0}</strong> mẫu cổ phục di sản
                </div>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <label style="font-size: 0.85rem; font-weight: 700; color: var(--dark-wood);">SẮP XẾP:</label>
                    <select class="form-control-heritage" style="padding: 6px 14px 6px 14px; width: auto; font-size: 0.85rem;" onchange="location = this.value;">
                        <option value="${pageContext.request.contextPath}/products">Mặc định</option>
                        <option value="${pageContext.request.contextPath}/products?sort=asc">Giá từ thấp đến cao</option>
                        <option value="${pageContext.request.contextPath}/products?sort=desc">Giá từ cao đến thấp</option>
                    </select>
                </div>
            </div>

            <!-- Product Cards Grid (Matching Image 2 Product Grid) -->
            <div class="collection-grid" style="grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));">
                <c:forEach var="p" items="${products}">
                    <div class="collection-card">
                        <div class="collection-img-box" style="height: 300px;">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" aria-label="Xem chi tiết ${p.name}">
                                <img src="${p.imageUrl != null ? p.imageUrl : 'https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=800&q=80'}" alt="${p.name}" />
                            </a>
                        </div>
                        <div class="collection-body" style="padding: 16px;">
                            <div style="font-size: 0.72rem; color: var(--gold-accent); text-transform: uppercase; font-weight: 700; margin-bottom: 4px;">${p.categoryName != null ? p.categoryName : 'CỔ PHỤC'}</div>
                            <h3 class="collection-name" style="font-size: 1.05rem; min-height: 2.6rem;"><a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" style="color: inherit; text-decoration: none;">${p.name}</a></h3>
                            <div class="collection-price" style="font-size: 1.15rem; margin-bottom: 14px;">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </div>
                            <div style="display: flex; gap: 8px; margin-top: auto;">
                                <a href="${pageContext.request.contextPath}/checkout?productId=${p.id}" class="btn-pill-red" style="width: 100%; font-size: 0.75rem; padding: 8px 10px; justify-content: center;">
                                    MUA NGAY
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
