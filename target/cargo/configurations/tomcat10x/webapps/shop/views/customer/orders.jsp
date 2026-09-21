<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Lịch Sử Đơn Hàng | Cổ Yêu Việt" scope="request" />
<c:set var="activePage" value="orders" scope="request" />

<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <div style="margin-bottom: 30px;">
        <h1 style="font-family: var(--font-heading); color: var(--primary-red); font-size: 2.2rem;">LỊCH SỬ ĐƠN HÀNG</h1>
        <p style="color: var(--text-muted);">Theo dõi tiến độ các đơn hàng trang phục truyền thống của bạn</p>
    </div>

    <c:choose>
        <c:when test="${orders != null && !orders.isEmpty()}">
            <div style="display: flex; flex-direction: column; gap: 24px;">
                <c:forEach var="order" items="${orders}">
                    <div style="background-color: #ffffff; border-radius: var(--radius-md); padding: 24px; border: 1px solid var(--border-color); box-shadow: var(--shadow-subtle);">
                        
                        <!-- Order Header -->
                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-color); padding-bottom: 14px; margin-bottom: 16px; flex-wrap: wrap; gap: 10px;">
                            <div>
                                <strong style="font-size: 1.1rem; color: var(--dark-wood);">Mã đơn hàng: #${order.id}</strong>
                                <span style="color: var(--text-muted); font-size: 0.85rem; margin-left: 12px;">
                                    <i class="fa-regular fa-clock"></i> Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>

                            <div>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}"><span class="badge badge-pending"><i class="fa-solid fa-hourglass-start"></i> Đang chờ duyệt</span></c:when>
                                    <c:when test="${order.status == 'PROCESSING'}"><span class="badge badge-processing"><i class="fa-solid fa-gear"></i> Đang may / Đóng gói</span></c:when>
                                    <c:when test="${order.status == 'SHIPPED'}"><span class="badge badge-shipped"><i class="fa-solid fa-truck-fast"></i> Đang giao hàng</span></c:when>
                                    <c:when test="${order.status == 'COMPLETED'}"><span class="badge badge-completed"><i class="fa-solid fa-circle-check"></i> Đã giao thành công</span></c:when>
                                    <c:otherwise><span class="badge badge-cancelled"><i class="fa-solid fa-ban"></i> Đã hủy</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Order Details Items -->
                        <div style="display: flex; flex-direction: column; gap: 12px; margin-bottom: 16px;">
                            <c:forEach var="dt" items="${order.details}">
                                <div style="display: flex; align-items: center; justify-content: space-between; background-color: #faf7f2; padding: 12px 16px; border-radius: var(--radius-sm);">
                                    <div style="display: flex; align-items: center; gap: 14px;">
                                        <img src="${pageContext.request.contextPath}/${dt.productImage}" alt="${dt.productName}" 
                                             style="width: 48px; height: 60px; object-fit: cover; border-radius: 4px;"
                                             onerror="this.src='https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=150&q=80'">
                                        <div>
                                            <div style="font-weight: 700; font-size: 0.9rem; color: var(--dark-wood);">${dt.productName}</div>
                                            <div style="font-size: 0.8rem; color: var(--text-muted); margin-top: 2px;">
                                                Số lượng: ${dt.quantity} x <fmt:formatNumber value="${dt.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div style="font-weight: 700; font-size: 0.95rem; color: var(--primary-red);">
                                        <fmt:formatNumber value="${dt.subtotal}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Order Footer -->
                        <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border-color); padding-top: 14px; font-size: 0.9rem;">
                            <div>
                                <i class="fa-solid fa-location-dot" style="color: var(--gold-accent);"></i> Giao tới: <strong>${order.shippingAddress}</strong>
                            </div>
                            <div style="font-size: 1.1rem; font-weight: 700;">
                                Tổng tiền: <span style="color: var(--primary-red); font-size: 1.3rem; font-weight: 800;"><fmt:formatNumber value="${order.totalMoney}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/></span>
                            </div>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:when>
        
        <c:otherwise>
            <div style="text-align: center; padding: 80px 20px; background: #ffffff; border-radius: var(--radius-md); border: 1px solid var(--border-color);">
                <i class="fa-solid fa-receipt fa-5x" style="color: #e0d8cf; margin-bottom: 20px;"></i>
                <h3 style="font-family: var(--font-heading); color: var(--text-dark); font-size: 1.6rem; margin-bottom: 10px;">Bạn chưa có đơn hàng nào</h3>
                <p style="color: var(--text-muted); margin-bottom: 24px;">Khám phá các sản phẩm Áo dài &amp; Cổ phục phong phú của chúng tôi!</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-primary" style="padding: 12px 30px;">
                    Xem Sản Phẩm
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/views/common/footer.jsp" />
