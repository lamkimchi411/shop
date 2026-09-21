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
        <c:if test="${editUser != null}">
            <section class="heritage-table-container" style="padding: 28px; margin-bottom: 28px;">
                <div style="display: flex; justify-content: space-between; align-items: center; gap: 16px; margin-bottom: 20px;">
                    <h2 style="font-family: var(--font-heading); font-size: 1.5rem; color: var(--primary-red); margin: 0;">
                        <i class="fa-solid fa-user-pen"></i> CHỈNH SỬA NGƯỜI DÙNG #${editUser.id}
                    </h2>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn-pill-outline" style="padding: 8px 16px;">Hủy</a>
                </div>

                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" value="${editUser.id}" />
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 18px;">
                        <div class="form-group-heritage">
                            <label for="username">Tên đăng nhập</label>
                            <input id="username" name="username" type="text" value="${editUser.username}" class="form-control-heritage" minlength="3" maxlength="50" required />
                        </div>
                        <div class="form-group-heritage">
                            <label for="fullname">Họ và tên</label>
                            <input id="fullname" name="fullname" type="text" value="${editUser.fullname}" class="form-control-heritage" required />
                        </div>
                        <div class="form-group-heritage">
                            <label for="email">Email</label>
                            <input id="email" name="email" type="email" value="${editUser.email}" class="form-control-heritage" required />
                        </div>
                        <div class="form-group-heritage">
                            <label for="phone">Số điện thoại</label>
                            <input id="phone" name="phone" type="tel" value="${editUser.phone}" class="form-control-heritage" />
                        </div>
                        <div class="form-group-heritage">
                            <label for="role">Vai trò</label>
                            <select id="role" name="role" class="form-control-heritage">
                                <option value="CUSTOMER" ${editUser.role == 'CUSTOMER' ? 'selected' : ''}>CUSTOMER</option>
                                <option value="ADMIN" ${editUser.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                            </select>
                        </div>
                        <div class="form-group-heritage">
                            <label for="address">Địa chỉ</label>
                            <input id="address" name="address" type="text" value="${editUser.address}" class="form-control-heritage" />
                        </div>
                        <div class="form-group-heritage">
                            <label for="newPassword">Mật khẩu mới <small style="font-weight: 400; color: var(--text-muted);">(để trống nếu không đổi)</small></label>
                            <div class="form-input-wrapper">
                                <i class="fa-solid fa-lock"></i>
                                <input id="newPassword" name="newPassword" type="password" class="form-control-heritage" minlength="6" autocomplete="new-password" />
                                <button type="button" class="password-toggle" data-target="newPassword" aria-label="Hiện mật khẩu"><i class="fa-solid fa-eye"></i></button>
                            </div>
                        </div>
                        <div class="form-group-heritage">
                            <label for="confirmPassword">Xác nhận mật khẩu mới</label>
                            <div class="form-input-wrapper">
                                <i class="fa-solid fa-lock"></i>
                                <input id="confirmPassword" name="confirmPassword" type="password" class="form-control-heritage" minlength="6" autocomplete="new-password" />
                                <button type="button" class="password-toggle" data-target="confirmPassword" aria-label="Hiện mật khẩu"><i class="fa-solid fa-eye"></i></button>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn-pill-red" style="padding: 12px 28px; margin-top: 18px;">
                        <i class="fa-solid fa-floppy-disk"></i> LƯU THAY ĐỔI
                    </button>
                </form>
            </section>
        </c:if>

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
                        <th style="width: 130px;">Vai trò</th>
                        <th style="width: 110px;">Trạng thái</th>
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
                                    <td>
                                        <span class="badge ${u.active ? 'badge-completed' : 'badge-cancelled'}">
                                            ${u.active ? 'Hoạt động' : 'Đã khóa'}
                                        </span>
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${u.id}" class="btn-action-icon btn-action-edit" title="Chỉnh sửa người dùng">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="toggleActive" />
                                            <input type="hidden" name="id" value="${u.id}" />
                                            <input type="hidden" name="active" value="${!u.active}" />
                                            <button type="submit" class="btn-action-icon btn-action-delete" title="${u.active ? 'Khóa tài khoản' : 'Mở khóa tài khoản'}" onclick="return confirm('${u.active ? 'Khóa' : 'Mở khóa'} tài khoản #${u.id}?');">
                                                <i class="fa-solid ${u.active ? 'fa-user-slash' : 'fa-user-check'}"></i>
                                            </button>
                                        </form>
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
