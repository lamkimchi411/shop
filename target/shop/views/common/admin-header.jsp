<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Admin Panel | Cổ Việt Lâu"}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css?v=3.7">
</head>
<body style="background-color: var(--parchment-bg);">
    <!-- Admin Topbar (Image 2 Style) -->
    <div class="admin-topbar">
        <div style="font-family: var(--font-heading); font-size: 1.1rem; letter-spacing: 1px; color: var(--gold-accent); display: flex; align-items: center; gap: 10px;">
            <div class="stamp-seal-logo" style="width: 32px; height: 32px; font-size: 0.75rem;">CỔ</div>
            ADMIN PANEL - CỔ VIỆT LÂU
        </div>
        <div style="display: flex; align-items: center; gap: 20px; font-size: 0.9rem;">
            <span><i class="fa-solid fa-bell" style="color: var(--gold-accent); margin-right: 15px; cursor: pointer;"></i></span>
            <span><i class="fa-solid fa-circle-user" style="color: var(--gold-accent);"></i> Xin chào, <strong>${sessionScope.account.fullname != null ? sessionScope.account.fullname : 'Quản Trị Viên'}</strong></span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-pill-outline" style="padding: 4px 14px; font-size: 0.8rem; border-color: var(--gold-accent); color: var(--gold-accent);">Đăng xuất</a>
        </div>
    </div>

    <!-- Main Navigation Header for Admin -->
    <header class="main-header" style="border-bottom: 2px solid var(--primary-red);">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="brand-wrapper">
                <i class="fa-solid fa-gauge-high fa-2x" style="color: var(--primary-red);"></i>
                <div>
                    <div class="brand-title">ADMIN PANEL</div>
                    <div class="brand-subtitle">QUẢN LÝ HỆ THỐNG CỔ PHỤC</div>
                </div>
            </a>

            <nav>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="${adminPage == 'dashboard' ? 'active' : ''}"><i class="fa-solid fa-chart-line"></i> Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users" class="${adminPage == 'users' ? 'active' : ''}"><i class="fa-solid fa-users"></i> Người Dùng</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/categories" class="${adminPage == 'categories' ? 'active' : ''}"><i class="fa-solid fa-layer-group"></i> Danh Mục</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/products" class="${adminPage == 'products' ? 'active' : ''}"><i class="fa-solid fa-shirt"></i> Sản Phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/orders" class="${adminPage == 'orders' ? 'active' : ''}"><i class="fa-solid fa-file-invoice-dollar"></i> Đơn Hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/settings" class="${adminPage == 'settings' ? 'active' : ''}"><i class="fa-solid fa-gear"></i> Cài Đặt Banner</a></li>
                </ul>
            </nav>

            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/home" class="btn-pill-outline" target="_blank" style="font-size: 0.82rem;">
                    <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Trang Web
                </a>
            </div>
        </div>
    </header>

    <!-- Global Admin Alert Messages -->
    <c:if test="${sessionScope.successMsg != null}">
        <div class="container" style="padding-top: 20px; padding-bottom: 0;">
            <div class="alert-heritage alert-heritage-success">
                <i class="fa-solid fa-circle-check"></i> ${sessionScope.successMsg}
            </div>
        </div>
        <c:remove var="successMsg" scope="session"/>
    </c:if>

    <c:if test="${sessionScope.errorMsg != null}">
        <div class="container" style="padding-top: 20px; padding-bottom: 0;">
            <div class="alert-heritage alert-heritage-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${sessionScope.errorMsg}
            </div>
        </div>
        <c:remove var="errorMsg" scope="session"/>
    </c:if>
