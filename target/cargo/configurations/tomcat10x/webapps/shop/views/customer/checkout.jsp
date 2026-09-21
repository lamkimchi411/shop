<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Thanh Toán Đơn Hàng | Cổ Việt Lâu" scope="request" />
<c:set var="activePage" value="cart" scope="request" />

<jsp:include page="/views/common/header.jsp" />

<div class="container" style="max-width: 1100px;">
    <!-- Title Header -->
    <div class="heritage-title" style="margin-bottom: 35px;">
        <div style="font-size: 0.85rem; color: var(--gold-accent); text-transform: uppercase; letter-spacing: 3px; font-weight: 700; margin-bottom: 6px;">CHECKOUT</div>
        <h2>THANH TOÁN ĐƠN HÀNG</h2>
        <p>Vui lòng hoàn tất thông tin giao hàng và phương thức thanh toán</p>
    </div>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <div style="display: grid; grid-template-columns: 1.2fr 0.8fr; gap: 35px;">
            <!-- Customer Info & Payment Side -->
            <div style="background: var(--parchment-card); padding: 35px; border-radius: var(--radius-lg); border: 1px solid var(--parchment-border); box-shadow: var(--shadow-subtle);">
                <h3 style="font-family: var(--font-heading); font-size: 1.3rem; color: var(--primary-red); margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid var(--gold-accent);">
                    <i class="fa-solid fa-truck-ramp-box"></i> THÔNG TIN GIAO HÀNG &amp; MAY ĐO
                </h3>

                <div class="form-group-heritage">
                    <label for="fullname">Họ Và Tên Khách Hàng</label>
                    <div class="form-input-wrapper">
                        <i class="fa-solid fa-user"></i>
                        <input type="text" id="fullname" name="fullname" value="${sessionScope.account != null ? sessionScope.account.fullname : ''}" class="form-control-heritage" placeholder="Nguyễn Văn A..." required />
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 18px;">
                    <div class="form-group-heritage">
                        <label for="phone">Số Điện Thoại</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-phone"></i>
                            <input type="tel" id="phone" name="phone" value="${sessionScope.account != null ? sessionScope.account.phone : ''}" class="form-control-heritage" placeholder="0901234567" required />
                        </div>
                    </div>

                    <div class="form-group-heritage">
                        <label for="email">Email</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-envelope"></i>
                            <input type="email" id="email" name="email" value="${sessionScope.account != null ? sessionScope.account.email : ''}" class="form-control-heritage" placeholder="email@domain.com" />
                        </div>
                    </div>
                </div>

                <div class="form-group-heritage">
                    <label for="address">Địa Chỉ Nhận Hàng Chi Tiết</label>
                    <div class="form-input-wrapper">
                        <i class="fa-solid fa-location-dot"></i>
                        <input type="text" id="address" name="address" value="${sessionScope.account != null ? sessionScope.account.address : ''}" class="form-control-heritage" placeholder="Số nhà, Đường, Phường/Xã, Quận/Huyện, Tỉnh/TP..." required />
                    </div>
                </div>

                <div class="form-group-heritage">
                    <label for="note">Ghi Chú Chi Tiết Số Đo May Đo (Nếu Có)</label>
                    <textarea id="note" name="note" class="form-control-heritage" style="border-radius: var(--radius-md); height: 90px; padding: 12px 16px;" placeholder="Ví dụ: Chiều cao 165cm, Vòng 1: 85cm, Vòng 2: 68cm, Vòng 3: 92cm..."></textarea>
                </div>

                <!-- Payment Methods -->
                <h3 style="font-family: var(--font-heading); font-size: 1.3rem; color: var(--primary-red); margin-top: 30px; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid var(--gold-accent);">
                    <i class="fa-solid fa-wallet"></i> PHƯƠNG THỨC THANH TOÁN
                </h3>

                <div style="display: flex; flex-direction: column; gap: 14px;">
                    <label style="display: flex; align-items: center; gap: 14px; padding: 16px; border: 1.5px solid var(--border-color); border-radius: var(--radius-md); background: #ffffff; cursor: pointer;">
                        <input type="radio" name="paymentMethod" value="COD" checked style="accent-color: var(--primary-red);" />
                        <div>
                            <div style="font-weight: 700; color: var(--dark-wood);"><i class="fa-solid fa-hand-holding-dollar" style="color: var(--primary-red);"></i> Thanh toán khi nhận hàng (COD)</div>
                            <div style="font-size: 0.82rem; color: var(--text-muted);">Khách hàng kiểm tra sản phẩm trước khi thanh toán tiền mặt cho nhân viên giao hàng.</div>
                        </div>
                    </label>

                    <label style="display: flex; align-items: center; gap: 14px; padding: 16px; border: 1.5px solid var(--border-color); border-radius: var(--radius-md); background: #ffffff; cursor: pointer;">
                        <input type="radio" name="paymentMethod" value="BANK" style="accent-color: var(--primary-red);" />
                        <div>
                            <div style="font-weight: 700; color: var(--dark-wood);"><i class="fa-solid fa-qrcode" style="color: var(--gold-accent);"></i> Chuyển khoản ngân hàng (VietQR / MoMo)</div>
                            <div style="font-size: 0.82rem; color: var(--text-muted);">Quét mã QR chuyển khoản nhanh. Đơn hàng sẽ được xác nhận ngay sau khi nhận tiền.</div>
                        </div>
                    </label>
                </div>
            </div>

            <!-- Order Breakdown Side -->
            <div>
                <div style="background: var(--parchment-card); padding: 30px; border-radius: var(--radius-lg); border: 1px solid var(--parchment-border); box-shadow: var(--shadow-subtle); position: sticky; top: 100px;">
                    <h3 style="font-family: var(--font-heading); font-size: 1.25rem; color: var(--dark-wood); margin-bottom: 18px; padding-bottom: 10px; border-bottom: 2px solid var(--gold-accent);">
                        TỔNG ĐƠN HÀNG
                    </h3>

                    <div style="max-height: 260px; overflow-y: auto; margin-bottom: 20px; padding-right: 5px;">
                        <c:forEach var="item" items="${cart.items}">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px; padding-bottom: 10px; border-bottom: 1px dashed var(--parchment-border);">
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <img src="${item.product.imageUrl != null ? item.product.imageUrl : 'https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=400&q=80'}" alt="${item.product.name}" style="width: 45px; height: 55px; object-fit: cover; border-radius: 6px;" />
                                    <div>
                                        <div style="font-weight: 700; font-size: 0.9rem; color: var(--dark-wood);">${item.product.name}</div>
                                        <div style="font-size: 0.78rem; color: var(--text-muted);">Số lượng: x${item.quantity}</div>
                                    </div>
                                </div>
                                <div style="font-weight: 700; font-size: 0.9rem; color: var(--primary-red);">
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div style="border-top: 2px solid var(--parchment-border); padding-top: 16px; margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 0.9rem;">
                            <span>Tạm tính:</span>
                            <span style="font-weight: 700;"><fmt:formatNumber value="${cart.totalMoney}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 0.9rem;">
                            <span>Phí vận chuyển toàn quốc:</span>
                            <span style="font-weight: 700; color: #2e7d32;">MIỄN PHÍ</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--parchment-border); padding-top: 14px;">
                            <span style="font-size: 1.1rem; font-weight: 800; color: var(--dark-wood);">TỔNG CỘNG:</span>
                            <span style="font-size: 1.7rem; font-weight: 900; color: var(--primary-red); font-family: var(--font-heading);">
                                <fmt:formatNumber value="${cart.totalMoney}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                            </span>
                        </div>
                    </div>

                    <button type="submit" class="btn-pill-red" style="width: 100%; padding: 14px; font-size: 1rem; justify-content: center;">
                        <i class="fa-solid fa-circle-check"></i> XÁC NHẬN ĐẶT HÀNG
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/views/common/footer.jsp" />
