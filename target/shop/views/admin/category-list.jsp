<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="Quản Lý Danh Mục | Admin Cổ Việt Lâu" scope="request" />
<c:set var="adminPage" value="categories" scope="request" />

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
            <li><a href="${pageContext.request.contextPath}/admin/categories" class="active"><i class="fa-solid fa-list-ul"></i> Danh mục</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-shirt"></i> Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice"></i> Đơn hàng</a></li>
        </ul>
    </aside>

    <!-- Main Content: QUẢN LÝ DANH MỤC -->
    <main class="admin-content">
        <div style="display: grid; grid-template-columns: 0.9fr 1.1fr; gap: 30px;">
            <!-- Form Thêm/Sửa Category -->
            <div class="heritage-table-container" style="padding: 28px;">
                <h3 style="font-family: var(--font-heading); font-size: 1.3rem; color: var(--primary-red); margin-bottom: 18px; padding-bottom: 10px; border-bottom: 2px solid var(--gold-accent);">
                    <i class="fa-solid fa-folder-plus"></i> ${editCategory != null ? 'CẬP NHẬT DANH MỤC' : 'THÊM DANH MỤC MỚI'}
                </h3>

                <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                    <input type="hidden" name="action" value="${editCategory != null ? 'update' : 'create'}" />
                    <c:if test="${editCategory != null}">
                        <input type="hidden" name="id" value="${editCategory.id}" />
                    </c:if>

                    <div class="form-group-heritage">
                        <label for="name">Tên Danh Mục Trang Phục</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-layer-group"></i>
                            <input type="text" id="name" name="name" value="${editCategory != null ? editCategory.name : ''}" class="form-control-heritage" placeholder="Ví dụ: Áo Nhật Bình Cung Đình..." required />
                        </div>
                    </div>

                    <div class="form-group-heritage">
                        <label for="description">Mô Tả Danh Mục</label>
                        <textarea id="description" name="description" class="form-control-heritage" style="border-radius: var(--radius-md); height: 100px; padding: 12px 16px;" placeholder="Giới thiệu về dòng trang phục di sản này...">${editCategory != null ? editCategory.description : ''}</textarea>
                    </div>

                    <button type="submit" class="btn-pill-red" style="width: 100%; padding: 12px; margin-top: 10px;">
                        <i class="fa-solid fa-floppy-disk"></i> LƯU DANH MỤC
                    </button>
                </form>
            </div>

            <!-- Table Danh Sách Category -->
            <div class="heritage-table-container" style="padding: 28px;">
                <h3 style="font-family: var(--font-heading); font-size: 1.3rem; color: var(--dark-wood); margin-bottom: 18px;">
                    <i class="fa-solid fa-list"></i> DANH SÁCH DANH MỤC
                </h3>

                <table class="heritage-table">
                    <thead>
                        <tr>
                            <th style="width: 70px;">ID</th>
                            <th>Tên Danh Mục</th>
                            <th style="text-align: center; width: 110px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${categories}">
                            <tr>
                                <td><strong>#${c.id}</strong></td>
                                <td>
                                    <div style="font-weight: 700; color: var(--dark-wood);">${c.name}</div>
                                    <div style="font-size: 0.8rem; color: var(--text-muted);">${c.description}</div>
                                </td>
                                <td style="text-align: center;">
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${c.id}" class="btn-action-icon btn-action-edit" title="Sửa">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.id}" class="btn-action-icon btn-action-delete" title="Xóa" onclick="return confirm('Xóa danh mục này?');">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<jsp:include page="/views/common/footer.jsp" />
