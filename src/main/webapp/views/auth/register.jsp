<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="Đăng Ký Thành Viên | Cổ Việt Lâu" scope="request" />
<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <div class="auth-container" style="max-width: 1000px;">
        <!-- Form Side -->
        <div class="auth-form-side" style="padding: 40px 45px;">
            <div class="auth-header">
                <div class="stamp-seal-logo" style="margin: 0 auto 10px;">CỔ<br/>VIỆT</div>
                <h2>ĐĂNG KÝ THÀNH VIÊN</h2>
                <p style="color: var(--text-muted); font-size: 0.88rem; margin-top: 6px;">Tham gia cộng đồng lưu giữ &amp; tôn vinh di sản Cổ Phục Việt</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert-heritage alert-heritage-error">
                    <i class="fa-solid fa-circle-exclamation"></i> <c:out value="${error}" />
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 18px;">
                    <div class="form-group-heritage">
                        <label for="username">Tên Tài Khoản</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-user-tag"></i>
                            <input type="text" id="username" name="username" class="form-control-heritage" placeholder="Username..." value="<c:out value='${username}' />" required minlength="3" maxlength="50" pattern="[A-Za-z0-9_]+" autocomplete="username" />
                        </div>
                    </div>

                    <div class="form-group-heritage">
                        <label for="fullname">Họ Và Tên</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-user"></i>
                            <input type="text" id="fullname" name="fullname" class="form-control-heritage" placeholder="Nguyễn Văn A..." value="<c:out value='${fullname}' />" required maxlength="100" autocomplete="name" />
                        </div>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 18px;">
                    <div class="form-group-heritage">
                        <label for="email">Địa Chỉ Email</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-envelope"></i>
                            <input type="email" id="email" name="email" class="form-control-heritage" placeholder="email@domain.com" value="<c:out value='${email}' />" required maxlength="100" autocomplete="email" />
                        </div>
                    </div>

                    <div class="form-group-heritage">
                        <label for="phone">Số Điện Thoại</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-phone"></i>
                            <input type="tel" id="phone" name="phone" class="form-control-heritage" placeholder="0901234567" value="<c:out value='${phone}' />" maxlength="20" autocomplete="tel" />
                        </div>
                    </div>
                </div>

                <div class="form-group-heritage">
                    <label for="address">Địa Chỉ Nhận Hàng / May Đo</label>
                    <div class="form-input-wrapper">
                        <i class="fa-solid fa-location-dot"></i>
                        <input type="text" id="address" name="address" class="form-control-heritage" placeholder="Số nhà, Đường, Quận/Huyện, Tỉnh/TP..." value="<c:out value='${address}' />" autocomplete="street-address" />
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 18px;">
                    <div class="form-group-heritage">
                        <label for="password">Mật Khẩu</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-lock"></i>
                            <input type="password" id="password" name="password" class="form-control-heritage" placeholder="Ít nhất 6 ký tự" required minlength="6" autocomplete="new-password" />
                        </div>
                    </div>

                    <div class="form-group-heritage">
                        <label for="confirmPassword">Xác Nhận Mật Khẩu</label>
                        <div class="form-input-wrapper">
                            <i class="fa-solid fa-shield-halved"></i>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control-heritage" placeholder="••••••••" required minlength="6" autocomplete="new-password" />
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-pill-red" style="width: 100%; padding: 13px; margin-top: 10px;">
                    <i class="fa-solid fa-user-plus"></i> ĐĂNG KÝ THÀNH VIÊN
                </button>

                <div style="text-align: center; margin-top: 20px; font-size: 0.88rem; color: var(--text-muted);">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" style="color: var(--primary-red); font-weight: 700; text-decoration: underline;">Đăng nhập</a>
                </div>
            </form>
        </div>

        <!-- Loom Line Art Side (Image 2 Top Left Style) -->
        <div class="auth-graphic-side">
            <svg class="loom-graphic" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M40 160 L160 160 M50 160 L50 60 M150 160 L150 60" stroke="#8b0000" stroke-width="4" stroke-linecap="round"/>
                <path d="M30 60 L170 60 M40 80 L160 80 M40 120 L160 120" stroke="#c5a059" stroke-width="3" stroke-linecap="round"/>
                <line x1="65" y1="60" x2="65" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <line x1="85" y1="60" x2="85" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <line x1="105" y1="60" x2="105" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <line x1="125" y1="60" x2="125" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <path d="M70 100 Q100 85 130 100 Q100 115 70 100 Z" fill="#8b0000" stroke="#c5a059" stroke-width="1.5"/>
                <circle cx="100" cy="100" r="3" fill="#e5cd98"/>
                <path d="M30 40 Q40 30 50 40 Q60 30 70 40" stroke="#c5a059" stroke-width="2" stroke-linecap="round" fill="none"/>
                <path d="M130 40 Q140 30 150 40 Q160 30 170 40" stroke="#c5a059" stroke-width="2" stroke-linecap="round" fill="none"/>
            </svg>

            <h3 style="font-family: var(--font-heading); color: var(--primary-red); font-size: 1.3rem; margin-bottom: 8px;">GIA NHẬP CỔ VIỆT LÂU</h3>
            <p style="font-size: 0.85rem; color: var(--text-muted); line-height: 1.5; max-width: 280px;">Trở thành khách hàng thân thiết để nhận các đặc quyền may đo cao cấp và ưu đãi bộ sưu tập di sản độc quyền.</p>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
