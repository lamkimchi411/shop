<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="Quản Lý Người Dùng | Admin Cổ Việt Lâu" scope="request" />
<c:set var="adminPage" value="users" scope="request" />

<jsp:include page="/views/common/admin-header.jsp" />

<div class="admin-layout">
    <!-- Admin Sidebar -->
    <aside class="admin-sidebar">
        <div style="font-family: var(--font-heading); font-size: 1.15rem; color: var(--gold-accent); margin-bottom: 25px; padding-bottom: 10px; border-bottom: 1px solid rgba(197, 160, 89, 0.3); letter-spacing: 1px;">
            <i class="fa-solid fa-sliders"></i> QUẢN TRỊ VIỆN
        </div>
        <ul class="admin-sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-house"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users" class="active"><i class="fa-solid fa-users"></i> Người dùng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list-ul"></i> Danh mục</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-shirt"></i> Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice"></i> Đơn hàng</a></li>
        </ul>
    </aside>

    <!-- Main Content: QUẢN LÝ NGƯỜI DÙNG (Image 2 Bottom Left Style) -->
    <main class="admin-content">
        <div class="heritage-table-container" style="padding: 28px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 22px;">
                <h2 style="font-family: var(--font-heading); font-size: 1.5rem; color: var(--dark-wood);">
                    <i class="fa-solid fa-users-gear" style="color: var(--primary-red);"></i> QUẢN LÝ NGƯỜI DÙNG
                </h2>
                <div style="font-size: 0.9rem; color: var(--text-muted);">
                    Tổng số tài khoản: <strong>${userList != null ? userList.size() : 5}</strong>
                </div>
            </div>

            <table class="heritage-table">
                <thead>
                    <tr>
                        <th style="width: 80px;">User ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th style="width: 130px;">Role</th>
                        <th style="text-align: center; width: 120px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${userList != null && !userList.isEmpty()}">
                            <c:forEach var="u" items="${userList}">
                                <tr>
                                    <td><strong>#${u.id}</strong></td>
                                    <td>
                                        <div style="font-weight: 700; color: var(--dark-wood);">${u.fullname}</div>
                                        <div style="font-size: 0.8rem; color: var(--text-muted);">@${u.username}</div>
                                    </td>
                                    <td>${u.email}</td>
                                    <td>
                                        <span class="badge ${u.role == 'ADMIN' ? 'badge-completed' : 'badge-processing'}">
                                            ${u.role}
                                        </span>
                                    </td>
                                    <td style="text-align: center;">
                                        <button class="btn-action-icon btn-action-edit" title="Chỉnh sửa vai trò" onclick="alert('Chỉnh sửa người dùng #${u.id}')">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>
                                        <button class="btn-action-icon btn-action-delete" title="Khoá tài khoản" onclick="if(confirm('Xác nhận khoá tài khoản này?')) alert('Đã khoá #${u.id}');">
                                            <i class="fa-solid fa-user-slash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Mock Rows matching Image 2 Bottom Left -->
                            <tr>
                                <td><strong>#1</strong></td>
                                <td>Full Name</td>
                                <td>solomane@gmail.com</td>
                                <td><span class="badge badge-completed">Admin</span></td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-ban"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#2</strong></td>
                                <td>Admin Key</td>
                                <td>adminkey@gmail.com</td>
                                <td><span class="badge badge-processing">Customer</span></td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-ban"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#3</strong></td>
                                <td>Người dùng</td>
                                <td>admina@gmail.com</td>
                                <td><span class="badge badge-processing">Customer</span></td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-ban"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#4</strong></td>
                                <td>Nam Trần</td>
                                <td>admonx@gmail.com</td>
                                <td><span class="badge badge-processing">Customer</span></td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-ban"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#5</strong></td>
                                <td>Thanh Tùng</td>
                                <td>solomane@gmail.com</td>
                                <td><span class="badge badge-processing">Customer</span></td>
                                <td style="text-align: center;">
                                    <button class="btn-action-icon btn-action-edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                    <button class="btn-action-icon btn-action-delete"><i class="fa-solid fa-ban"></i></button>
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
