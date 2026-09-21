<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Quản Lý Đơn Hàng | Admin Cổ Việt Lâu" scope="request" />
<c:set var="adminPage" value="orders" scope="request" />

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
            <li><a href="${pageContext.request.contextPath}/admin/orders" class="active"><i class="fa-solid fa-file-invoice"></i> Đơn hàng</a></li>
        </ul>
    </aside>

    <!-- Main Content: QUẢN LÝ ĐƠN HÀNG -->
    <main class="admin-content">
        <c:if test="${selectedOrder != null}">
            <section class="heritage-table-container" style="padding: 28px; margin-bottom: 28px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                    <h2 style="font-family: var(--font-heading); font-size: 1.4rem; color: var(--primary-red); margin: 0;">
                        <i class="fa-solid fa-receipt"></i> CHI TIẾT ĐƠN HÀNG #${selectedOrder.id}
                    </h2>
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn-pill-outline" style="padding: 7px 14px;">Đóng</a>
                </div>
                <p><strong>Khách hàng:</strong> ${selectedOrder.userName} &nbsp; | &nbsp; <strong>Địa chỉ giao:</strong> ${selectedOrder.shippingAddress}</p>
                <table class="heritage-table">
                    <thead><tr><th>Sản phẩm</th><th style="width: 120px; text-align: center;">Số lượng</th><th style="width: 160px; text-align: right;">Đơn giá</th></tr></thead>
                    <tbody>
                        <c:forEach var="detail" items="${selectedOrder.details}">
                            <tr>
                                <td>${detail.productName}</td>
                                <td style="text-align: center;">${detail.quantity}</td>
                                <td style="text-align: right;"><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
        </c:if>
        <div class="heritage-table-container" style="padding: 28px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 22px;">
                <h2 style="font-family: var(--font-heading); font-size: 1.5rem; color: var(--dark-wood);">
                    <i class="fa-solid fa-file-invoice-dollar" style="color: var(--primary-red);"></i> QUẢN LÝ ĐƠN HÀNG MAY ĐO
                </h2>
                <div style="font-size: 0.9rem; color: var(--text-muted);">
                    Tổng số đơn: <strong>${orders != null ? orders.size() : 0}</strong>
                </div>
            </div>

            <table class="heritage-table">
                <thead>
                    <tr>
                        <th style="width: 80px;">Mã Đơn</th>
                        <th>Khách Hàng &amp; SĐT</th>
                        <th>Ngày Đặt</th>
                        <th style="text-align: right; width: 140px;">Tổng Tiền</th>
                        <th style="width: 170px;">Trạng Thái</th>
                        <th style="text-align: center; width: 140px;">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td><strong>#${o.id}</strong></td>
                            <td>
                                <div style="font-weight: 700; color: var(--dark-wood);">${o.userName}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted);"><i class="fa-solid fa-phone"></i> ${o.phone}</div>
                            </td>
                            <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td style="text-align: right; font-weight: 800; color: var(--primary-red);">
                                <fmt:formatNumber value="${o.totalMoney}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: inline-block; width: 100%;">
                                    <input type="hidden" name="action" value="updateStatus" />
                                    <input type="hidden" name="id" value="${o.id}" />
                                    <select name="status" class="form-control-heritage" style="padding: 4px 8px; font-size: 0.8rem;" onchange="this.form.submit();">
                                        <option value="PENDING" ${o.status == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                                        <option value="PROCESSING" ${o.status == 'PROCESSING' ? 'selected' : ''}>Đang may</option>
                                        <option value="SHIPPED" ${o.status == 'SHIPPED' ? 'selected' : ''}>Đang giao</option>
                                        <option value="COMPLETED" ${o.status == 'COMPLETED' ? 'selected' : ''}>Hoàn tất</option>
                                        <option value="CANCELLED" ${o.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                                    </select>
                                </form>
                            </td>
                            <td style="text-align: center;">
                                <a href="${pageContext.request.contextPath}/admin/orders?id=${o.id}" class="btn-pill-outline" style="padding: 4px 12px; font-size: 0.78rem;">
                                    Chi tiết
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<jsp:include page="/views/common/footer.jsp" />
