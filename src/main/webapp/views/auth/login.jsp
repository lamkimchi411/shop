<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="Đăng Nhập Thành Viên | Cổ Việt Lâu" scope="request" />
<jsp:include page="/views/common/header.jsp" />

<div class="container">
    <div class="auth-container">
        <!-- Form Side -->
        <div class="auth-form-side">
            <div class="auth-header">
                <div class="stamp-seal-logo" style="margin: 0 auto 10px;">CỔ<br/>VIỆT</div>
                <h2>ĐĂNG NHẬP THÀNH VIÊN</h2>
                <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 6px;">Chào mừng bạn trở lại với di sản Cổ Việt Lâu</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert-heritage alert-heritage-error">
                    <i class="fa-solid fa-circle-exclamation"></i> <c:out value="${error}" />
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group-heritage">
                    <label for="username">Tên Đăng Nhập / Email</label>
                    <div class="form-input-wrapper">
                        <i class="fa-solid fa-user"></i>
                        <input type="text" id="username" name="username" class="form-control-heritage" placeholder="Nhập username hoặc email..." value="<c:out value='${username}' />" required autofocus autocomplete="username" />
                    </div>
                </div>

                <div class="form-group-heritage">
                    <label for="password">Mật Khẩu</label>
                    <div class="form-input-wrapper">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control-heritage" placeholder="••••••••" required autocomplete="current-password" />
                    </div>
                </div>

                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; font-size: 0.88rem;">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: var(--text-dark);">
                        <input type="checkbox" name="remember" style="accent-color: var(--primary-red);" /> Ghi nhớ đăng nhập
                    </label>
                    <a href="#" style="color: var(--primary-red); font-weight: 600;">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn-pill-red" style="width: 100%; padding: 12px;">
                    <i class="fa-solid fa-right-to-bracket"></i> ĐĂNG NHẬP
                </button>

                <div style="text-align: center; margin-top: 25px; font-size: 0.9rem; color: var(--text-muted);">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" style="color: var(--primary-red); font-weight: 700; text-decoration: underline;">Đăng ký ngay</a>
                </div>
            </form>
        </div>

        <!-- Loom Line Art Side (Image 2 Style) -->
        <div class="auth-graphic-side">
            <!-- Inline SVG Loom Craft Graphic -->
            <svg class="loom-graphic" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
                <!-- Loom Frame Structure -->
                <path d="M40 160 L160 160 M50 160 L50 60 M150 160 L150 60" stroke="#8b0000" stroke-width="4" stroke-linecap="round"/>
                <path d="M30 60 L170 60 M40 80 L160 80 M40 120 L160 120" stroke="#c5a059" stroke-width="3" stroke-linecap="round"/>
                <!-- Vertical Silk Threads -->
                <line x1="65" y1="60" x2="65" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <line x1="85" y1="60" x2="85" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <line x1="105" y1="60" x2="105" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <line x1="125" y1="60" x2="125" y2="160" stroke="#8b0000" stroke-width="1.5" stroke-dasharray="3,3"/>
                <!-- Shuttle Boat (Thoi dệt) -->
                <path d="M70 100 Q100 85 130 100 Q100 115 70 100 Z" fill="#8b0000" stroke="#c5a059" stroke-width="1.5"/>
                <circle cx="100" cy="100" r="3" fill="#e5cd98"/>
                <!-- Traditional Cloud Details -->
                <path d="M30 40 Q40 30 50 40 Q60 30 70 40" stroke="#c5a059" stroke-width="2" stroke-linecap="round" fill="none"/>
                <path d="M130 40 Q140 30 150 40 Q160 30 170 40" stroke="#c5a059" stroke-width="2" stroke-linecap="round" fill="none"/>
            </svg>

            <h3 style="font-family: var(--font-heading); color: var(--primary-red); font-size: 1.3rem; margin-bottom: 8px;">TINH HOA NGHỆ THUẬT DỆT LỤA</h3>
            <p style="font-size: 0.85rem; color: var(--text-muted); line-height: 1.5; max-width: 280px;">Tận hưởng trải nghiệm may đo &amp; mua sắm trang phục cổ truyền Việt Nam độc bản</p>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />
