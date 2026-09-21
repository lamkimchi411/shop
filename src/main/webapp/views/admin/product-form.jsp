<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="${product != null ? 'Cập Nhật Sản Phẩm' : 'Thêm Sản Phẩm Mới'} | Admin Cổ Việt Lâu" scope="request" />
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

    <!-- Main Content: Product Form -->
    <main class="admin-content">
        <div class="heritage-table-container" style="padding: 35px; max-width: 850px; margin: 0 auto;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; padding-bottom: 12px; border-bottom: 2px solid var(--gold-accent);">
                <h2 style="font-family: var(--font-heading); font-size: 1.5rem; color: var(--primary-red);">
                    <i class="fa-solid fa-pen-nib"></i> ${product != null ? 'CẬP NHẬT CỔ PHỤC' : 'THÊM MẪU CỔ PHỤC MỚI'}
                </h2>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn-pill-outline" style="font-size: 0.8rem;">
                    <i class="fa-solid fa-arrow-left"></i> Quay lại
                </a>
            </div>

            <form action="${pageContext.request.contextPath}/admin/products" method="post">
                <input type="hidden" name="action" value="${product != null ? 'update' : 'create'}" />
                <c:if test="${product != null}">
                    <input type="hidden" name="id" value="${product.id}" />
                </c:if>

                <div class="form-group-heritage">
                    <label for="name">Tên Mẫu Cổ Phục</label>
                    <div class="form-input-wrapper">
                        <i class="fa-solid fa-shirt"></i>
                        <input type="text" id="name" name="name" value="${product != null ? product.name : ''}" class="form-control-heritage" placeholder="Ví dụ: Áo Nhật Bình Lụa Gấm Triều Nguyễn..." required />
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group-heritage">
                        <label for="categoryId">Danh Mục Trang Phục</label>
                        <select id="categoryId" name="categoryId" class="form-control-heritage" style="padding-left: 16px;">
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" ${product != null && product.categoryId == c.id ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group-heritage">
                        <label for="quantity">Số Lượng Trong Kho</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-boxes-stacked"></i>
                            <input type="number" id="quantity" name="quantity" value="${product != null ? product.quantity : 10}" class="form-control-heritage" min="0" required />
                        </div>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group-heritage">
                        <label for="price">Giá Bán (VNĐ)</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-tag"></i>
                            <input type="number" id="price" name="price" value="${product != null ? product.price : 1500000}" class="form-control-heritage" step="10000" required />
                        </div>
                    </div>

                    <div class="form-group-heritage">
                        <label for="imageUrl">URL Hình Ảnh</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-image"></i>
                            <input type="url" id="imageUrl" name="imageUrl" value="${product != null ? product.imageUrl : ''}" class="form-control-heritage" placeholder="https://..." />
                        </div>
                    </div>
                </div>

                <div class="form-group-heritage">
                    <label for="description">Mô Tả Sản Phẩm &amp; Chất Liệu</label>
                    <textarea id="description" name="description" class="form-control-heritage" style="border-radius: var(--radius-md); height: 110px; padding: 12px 16px;" placeholder="Mô tả di sản, kỹ thuật may gấm lụa...">${product != null ? product.description : ''}</textarea>
                </div>

                <div style="display: flex; gap: 15px; margin-top: 25px;">
                    <button type="submit" class="btn-pill-red" style="flex: 1; padding: 13px; font-size: 0.95rem; justify-content: center;">
                        <i class="fa-solid fa-floppy-disk"></i> LƯU SẢN PHẨM
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn-pill-outline" style="text-align: center; justify-content: center;">
                        HỦY BỎ
                    </a>
                </div>
            </form>
        </div>
    </main>
</div>

<jsp:include page="/views/common/footer.jsp" />
