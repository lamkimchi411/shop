<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Cổ Việt Lâu | Dấu Ấn Di Sản Trường Tồn"}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css?v=3.5">
</head>
<body>
<div class="page-frame">
    <!-- Top Bar -->
    <div class="top-bar">
        <div><i class="fa-solid fa-gem"></i> CỔ VIỆT LÂU - TÔN VINH DI SẢN CỔ PHỤC VIỆT NAM</div>
        <div><i class="fa-solid fa-phone"></i> Hotline May Đo: 0901.234.567 | Cung Đình Huế</div>
    </div>

    <!-- Main Navigation Header (Image 1 Style) -->
    <header class="main-header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/home" class="brand-wrapper">
                <div class="stamp-seal-logo">
                    CỔ<br/>VIỆT
                </div>
                <div>
                    <div class="brand-title">CỔ VIỆT LÂU</div>
                    <div class="brand-subtitle">DẤU ẤN DI SẢN TRƯỜNG TỒN</div>
                </div>
            </a>

            <div class="nav-wrapper">
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/home" class="${activePage == 'home' ? 'active' : ''}">HOME</a></li>
                    <li><a href="${pageContext.request.contextPath}/products" class="${activePage == 'products' ? 'active' : ''}">COLLECTION</a></li>
                    <li><a href="${pageContext.request.contextPath}/products" class="${activePage == 'heritage' ? 'active' : ''}">HERITAGE</a></li>
                    <li><a href="${pageContext.request.contextPath}/products" class="${activePage == 'journey' ? 'active' : ''}">JOURNEY</a></li>
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <li><a href="${pageContext.request.contextPath}/orders" class="${activePage == 'orders' ? 'active' : ''}">ACCOUNT</a></li>
                            <c:if test="${sessionScope.account.role == 'ADMIN'}">
                                <li><a href="${pageContext.request.contextPath}/admin/dashboard" style="color: var(--primary-red);"><i class="fa-solid fa-shield-halved"></i> ADMIN</a></li>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/login" class="${activePage == 'login' ? 'active' : ''}">ACCOUNT</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>

                <!-- Sub-nav under Collection matching Image 1 -->
                <ul class="sub-nav-links">
                    <li><a href="${pageContext.request.contextPath}/products?catId=1">Áo Dài</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?catId=3">Áo Nhật Bình</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?catId=3">Giao Lĩnh</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?catId=2">Ngũ Thân</a></li>
                </ul>
            </div>

            <div class="header-actions">
                <!-- Cart Button matching Image 1 -->
                <a href="${pageContext.request.contextPath}/cart" class="cart-icon-btn" title="Giỏ hàng">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <c:if test="${sessionScope.cartCount != null && sessionScope.cartCount > 0}">
                        <span class="cart-badge">${sessionScope.cartCount}</span>
                    </c:if>
                </a>

                <div style="display: flex; align-items: center; gap: 8px;">
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <span style="font-weight: 700; font-size: 0.85rem;"><i class="fa-regular fa-circle-user"></i> ${sessionScope.account.fullname}</span>
                            <a href="${pageContext.request.contextPath}/logout" class="btn-pill-outline" style="padding: 5px 14px; font-size: 0.78rem;">Đăng xuất</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn-pill-outline">Đăng Nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn-pill-red">Đăng Ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </header>

    <!-- Global Messages -->
    <c:if test="${sessionScope.successMsg != null}">
        <div class="container" style="padding-top: 15px; padding-bottom: 0;">
            <div class="alert-heritage alert-heritage-success">
                <i class="fa-solid fa-circle-check"></i> ${sessionScope.successMsg}
            </div>
        </div>
        <c:remove var="successMsg" scope="session"/>
    </c:if>

    <c:if test="${sessionScope.errorMsg != null}">
        <div class="container" style="padding-top: 15px; padding-bottom: 0;">
            <div class="alert-heritage alert-heritage-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${sessionScope.errorMsg}
            </div>
        </div>
        <c:remove var="errorMsg" scope="session"/>
    </c:if>
