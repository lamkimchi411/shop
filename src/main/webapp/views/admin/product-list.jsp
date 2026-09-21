<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Quản Lý Sản Phẩm | Admin Cổ Việt Lâu" scope="request" />
<c:set var="adminPage" value="products" scope="request" />

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
            <li><a href="${pageContext.request.contextPath}/admin/products" class="active"><i class="fa-solid fa-shirt"></i> Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice"></i> Đơn hàng</a></li>
        </ul>
    </aside>

    <!-- Main Content: QUẢN LÝ SẢN PHẨM (Image 2 Bottom Right Style) -->
    <main class="admin-content">
        <div class="heritage-table-container" style="padding: 28px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 22px;">
                <h2 style="font-family: var(--font-heading); font-size: 1.5rem; color: var(--dark-wood);">
                    <i class="fa-solid fa-shirt" style="color: var(--primary-red);"></i> QUẢN LÝ SẢN PHẨM
                </h2>
                <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn-pill-red" style="padding: 9px 20px; font-size: 0.85rem;">
                    <i class="fa-solid fa-plus"></i> THÊM SẢN PHẨM MỚI
                </a>
            </div>

            <table class="heritage-table">
                <thead>
                    <tr>
                        <th style="width: 90px;">Product ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th style="text-align: center; width: 90px;">Stock</th>
                        <th style="text-align: right; width: 140px;">Price</th>
                        <th style="text-align: center; width: 120px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${products != null && !products.isEmpty()}">
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td><strong>#${p.id}</strong></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 12px;">
                                            <img src="${p.imageUrl != null ? p.imageUrl : 'https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=400&q=80'}" alt="${p.name}" style="width: 45px; height: 55px; object-fit: cover; border-radius: 6px;" />
                                            <div style="font-weight: 700; color: var(--dark-wood);">${p.name}</div>
                                        </div>
                                    </td>
                                    <td>${p.categoryName != null ? p.categoryName : 'Cổ Phục'}</td>
                                    <td style="text-align: center; font-weight: 700; color: ${p.quantity <= 10 ? 'var(--primary-red)' : 'var(--dark-wood)'};">
                                        ${p.quantity}
                                    </td>
                                    <td style="text-align: right; font-weight: 800; color: var(--primary-red);">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}" class="btn-action-icon btn-action-edit" title="Sửa">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}" class="btn-action-icon btn-action-delete" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Mock Rows matching Image 2 Bottom Right -->
                            <tr>
                                <td><strong>#1</strong></td>
                                <td>Áo Giao Lĩnh Lụa Gấm Kin</td>
                                <td>Category</td>
                                <td style="text-align: center; font-weight: 700;">10</td>
                                <td style="text-align: right; font-weight: 800; color: var(--primary-red);">1,500,000 VNĐ</td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-trash-can"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#2</strong></td>
                                <td>Áo Ngũ Thân Kim</td>
                                <td>Category</td>
                                <td style="text-align: center; font-weight: 700;">10</td>
                                <td style="text-align: right; font-weight: 800; color: var(--primary-red);">1,500,000 VNĐ</td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-trash-can"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#3</strong></td>
                                <td>Áo Ngũ Thân</td>
                                <td>Category</td>
                                <td style="text-align: center; font-weight: 700;">10</td>
                                <td style="text-align: right; font-weight: 800; color: var(--primary-red);">1,500,000 VNĐ</td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-trash-can"></i></button>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </main>
</div>

<jsp:include page="/views/common/footer.jsp" />
