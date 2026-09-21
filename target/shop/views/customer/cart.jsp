<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Giỏ Hàng Của Bạn | Cổ Việt Lâu" scope="request" />
<c:set var="activePage" value="cart" scope="request" />

<jsp:include page="/views/common/header.jsp" />

<div class="container" style="max-width: 1100px;">
    <!-- Title Header (Image 2 Top Right Style) -->
    <div class="heritage-title" style="margin-bottom: 35px;">
        <div style="font-size: 0.85rem; color: var(--gold-accent); text-transform: uppercase; letter-spacing: 3px; font-weight: 700; margin-bottom: 6px;">YOUR CART</div>
        <h2>GIỎ HÀNG CỦA BẠN</h2>
        <p>Kiểm tra các mẫu cổ phục di sản đã chọn trước khi tiến hành đặt may &amp; thanh toán</p>
    </div>

    <c:choose>
        <c:when test="${cart != null && cart.items != null && !cart.items.isEmpty()}">
            <!-- Heritage Cart Table -->
            <div class="heritage-table-container">
                <table class="heritage-table">
                    <thead>
                        <tr>
                            <th style="width: 100px;">Product</th>
                            <th>Name</th>
                            <th style="text-align: center; width: 140px;">Qty</th>
                            <th style="text-align: right; width: 140px;">Price</th>
                            <th style="text-align: right; width: 150px;">Total</th>
                            <th style="text-align: center; width: 80px;">Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart.items}">
                            <tr>
                                <td>
                                    <img src="${item.product.imageUrl != null ? item.product.imageUrl : 'https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=400&q=80'}" alt="${item.product.name}" style="width: 70px; height: 85px; object-fit: cover; border-radius: 8px; border: 1px solid var(--parchment-border);" />
                                </td>
                                <td>
                                    <div style="font-family: var(--font-heading); font-size: 1.1rem; font-weight: 700; color: var(--dark-wood);">${item.product.name}</div>
                                    <div style="font-size: 0.8rem; color: var(--gold-accent); margin-top: 4px;">Chất liệu: Lụa Gấm Cung Đình</div>
                                </td>
                                <td style="text-align: center;">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline-flex;">
                                        <input type="hidden" name="action" value="update" />
                                        <input type="hidden" name="productId" value="${item.product.id}" />
                                        <div class="qty-control">
                                            <button type="submit" class="qty-btn" onclick="this.form.quantity.value = Math.max(1, parseInt(this.form.quantity.value) - 1);">-</button>
                                            <input type="number" name="quantity" value="${item.quantity}" class="qty-input" readonly />
                                            <button type="submit" class="qty-btn" onclick="this.form.quantity.value = parseInt(this.form.quantity.value) + 1;">+</button>
                                        </div>
                                    </form>
                                </td>
                                <td style="text-align: right; font-weight: 600; color: var(--text-dark);">
                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                </td>
                                <td style="text-align: right; font-weight: 800; color: var(--primary-red); font-size: 1.1rem;">
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                </td>
                                <td style="text-align: center;">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="remove" />
                                        <input type="hidden" name="productId" value="${item.product.id}" />
                                        <button type="submit" class="btn-action-icon btn-action-delete" title="Xóa khỏi giỏ">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Total Summary & Action Bar (Image 2 Top Right Style) -->
            <div style="display: flex; justify-content: space-between; align-items: center; background: var(--parchment-card); padding: 25px 30px; border-radius: var(--radius-md); border: 1px solid var(--parchment-border); box-shadow: var(--shadow-subtle);">
                <a href="${pageContext.request.contextPath}/products" class="btn-pill-outline">
                    <i class="fa-solid fa-arrow-left"></i> TIẾP TỤC CHỌN ĐỒ
                </a>

                <div style="display: flex; align-items: center; gap: 25px;">
                    <div style="text-align: right;">
                        <span style="font-size: 1.1rem; font-weight: 700; color: var(--dark-wood);">Thành tiền: </span>
                        <span style="font-size: 1.8rem; font-weight: 900; color: var(--primary-red); font-family: var(--font-heading);">
                            <fmt:formatNumber value="${cart.totalMoney}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                        </span>
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout" class="btn-pill-red" style="padding: 14px 32px; font-size: 1rem;">
                        TIẾN HÀNH THANH TOÁN <i class="fa-solid fa-credit-card"></i>
                    </a>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Empty Cart State -->
            <div style="text-align: center; padding: 70px 20px; background: var(--parchment-card); border-radius: var(--radius-lg); border: 1px solid var(--parchment-border); box-shadow: var(--shadow-subtle);">
                <i class="fa-solid fa-bag-shopping" style="font-size: 4rem; color: var(--gold-accent); margin-bottom: 20px;"></i>
                <h3 style="font-family: var(--font-heading); font-size: 1.6rem; color: var(--dark-wood); margin-bottom: 10px;">GIỎ HÀNG CỦA BẠN ĐANG TRỐNG</h3>
                <p style="color: var(--text-muted); margin-bottom: 25px;">Hãy khám phá Bộ sưu tập di sản Cổ Việt Lâu để chọn mẫu cổ phục ưng ý nhất.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn-pill-red" style="padding: 12px 30px;">
                    KHÁM PHÁ BỘ SƯU TẬP <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/views/common/footer.jsp" />
