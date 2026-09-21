<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Admin Panel - Cổ Việt Lâu" scope="request" />
<c:set var="adminPage" value="dashboard" scope="request" />

<jsp:include page="/views/common/admin-header.jsp" />

<div class="admin-layout">
    <!-- Admin Sidebar (Image 2 Style) -->
    <aside class="admin-sidebar">
        <div style="font-family: var(--font-heading); font-size: 1.15rem; color: var(--gold-accent); margin-bottom: 25px; padding-bottom: 10px; border-bottom: 1px solid rgba(197, 160, 89, 0.3); letter-spacing: 1px;">
            <i class="fa-solid fa-sliders"></i> QUẢN TRỊ VIỆN
        </div>
        <ul class="admin-sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fa-solid fa-house"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users"></i> Người dùng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list-ul"></i> Danh mục</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-shirt"></i> Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-file-invoice"></i> Đơn hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/settings"><i class="fa-solid fa-gear"></i> Cài đặt Banner</a></li>
        </ul>
    </aside>

    <!-- Main Dashboard Content (Image 2 Style) -->
    <main class="admin-content">
        <!-- Dashboard Charts Row (Image 2 Style) -->
        <div class="dashboard-grid">
            <!-- Revenue Line Chart: THỐNG KÊ DOANH THU -->
            <div class="dashboard-card">
                <div class="dashboard-card-title">
                    <i class="fa-solid fa-chart-line" style="color: var(--primary-red);"></i> THỐNG KÊ DOANH THU
                </div>

                <div class="chart-wrapper">
                    <!-- SVG Interactive Line Chart matching Image 2 -->
                    <svg class="chart-svg" viewBox="0 0 500 200" preserveAspectRatio="none">
                        <!-- Background Grid Lines -->
                        <line x1="40" y1="20" x2="480" y2="20" stroke="#ded6c8" stroke-dasharray="2,2"/>
                        <line x1="40" y1="60" x2="480" y2="60" stroke="#ded6c8" stroke-dasharray="2,2"/>
                        <line x1="40" y1="100" x2="480" y2="100" stroke="#ded6c8" stroke-dasharray="2,2"/>
                        <line x1="40" y1="140" x2="480" y2="140" stroke="#ded6c8" stroke-dasharray="2,2"/>
                        <line x1="40" y1="180" x2="480" y2="180" stroke="#ded6c8"/>

                        <!-- Axis Labels -->
                        <text x="15" y="25" font-size="10" fill="#6e635f">70</text>
                        <text x="15" y="65" font-size="10" fill="#6e635f">50</text>
                        <text x="15" y="105" font-size="10" fill="#6e635f">30</text>
                        <text x="15" y="145" font-size="10" fill="#6e635f">10</text>

                        <!-- Line 1: Primary Red Line (Thực tế) -->
                        <polyline fill="none" stroke="#8b0000" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"
                            points="40,165 75,120 110,135 145,100 180,125 215,105 250,90 285,110 320,80 355,95 390,55 425,70 460,40" />

                        <!-- Line 2: Gold Secondary Line (Mục tiêu) -->
                        <polyline fill="none" stroke="#c5a059" stroke-width="2.5" stroke-dasharray="4,3" stroke-linecap="round" stroke-linejoin="round"
                            points="40,180 75,145 110,120 145,130 180,110 215,140 250,115 285,150 320,105 355,120 390,85 425,100 460,60" />

                        <!-- Data Nodes (Dots) -->
                        <circle cx="40" cy="165" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="75" cy="120" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="110" cy="135" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="145" cy="100" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="180" cy="125" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="215" cy="105" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="250" cy="90" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="285" cy="110" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="320" cy="80" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="355" cy="95" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="390" cy="55" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="425" cy="70" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                        <circle cx="460" cy="40" r="4" fill="#c5a059" stroke="#8b0000" stroke-width="2"/>
                    </svg>
                </div>

                <div style="display: flex; justify-content: space-between; font-size: 0.78rem; color: #6e635f; padding-left: 35px; padding-right: 15px; margin-top: 6px;">
                    <span>Jan</span><span>Feb</span><span>Mar</span><span>Apr</span><span>May</span><span>Jun</span><span>Jul</span><span>Aug</span><span>Sep</span><span>Oct</span><span>Nov</span><span>Dec</span>
                </div>
            </div>

            <!-- Order Pie/Donut Chart: ĐƠN HÀNG MỚI (Image 2 Style) -->
            <div class="dashboard-card">
                <div class="dashboard-card-title">
                    <i class="fa-solid fa-chart-pie" style="color: var(--gold-accent);"></i> ĐƠN HÀNG MỚI
                </div>

                <div style="display: flex; align-items: center; justify-content: center; gap: 20px; height: 210px;">
                    <!-- SVG Pie/Donut Chart matching Image 2 -->
                    <svg viewBox="0 0 160 160" style="width: 150px; height: 150px;">
                        <!-- Segment 1: Completed (Red) -->
                        <path d="M80,80 L80,10 A70,70 0 0,1 145,100 Z" fill="#8b0000" />
                        <!-- Segment 2: Processing (Gold) -->
                        <path d="M80,80 L145,100 A70,70 0 0,1 40,145 Z" fill="#c5a059" />
                        <!-- Segment 3: Shipped (Cream/Beige) -->
                        <path d="M80,80 L40,145 A70,70 0 0,1 15,60 Z" fill="#e5cd98" />
                        <!-- Segment 4: Cancelled (Dark Red) -->
                        <path d="M80,80 L15,60 A70,70 0 0,1 80,10 Z" fill="#4a0000" />
                        <!-- Inner Circle -->
                        <circle cx="80" cy="80" r="38" fill="#fcf8f2" />
                        <text x="80" y="85" text-anchor="middle" font-weight="bold" font-size="14" fill="#221815">${totalOrders}</text>
                    </svg>

                    <!-- Chart Legend matching Image 2 -->
                    <div style="font-size: 0.82rem; display: flex; flex-direction: column; gap: 8px;">
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <span style="width: 12px; height: 12px; background: #8b0000; border-radius: 2px;"></span> Đã thanh toán
                        </div>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <span style="width: 12px; height: 12px; background: #c5a059; border-radius: 2px;"></span> Đang xử lý
                        </div>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <span style="width: 12px; height: 12px; background: #e5cd98; border-radius: 2px;"></span> Hoàn tất
                        </div>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <span style="width: 12px; height: 12px; background: #4a0000; border-radius: 2px;"></span> Hủy
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Metrics Row matching Image 2 Bottom (1,250 Users, 310 Products, 5,5tr VNĐ Revenue) -->
        <div class="metrics-row">
            <div class="metric-card">
                <div>
                    <div class="metric-label">Tổng người dùng</div>
                    <div class="metric-number">1,250</div>
                </div>
                <div class="metric-icon">
                    <i class="fa-solid fa-users"></i>
                </div>
            </div>

            <div class="metric-card">
                <div>
                    <div class="metric-label">Tổng sản phẩm</div>
                    <div class="metric-number">${totalProducts != null ? totalProducts : 310}</div>
                </div>
                <div class="metric-icon" style="color: var(--gold-accent);">
                    <i class="fa-solid fa-box-archive"></i>
                </div>
            </div>

            <div class="metric-card">
                <div>
                    <div class="metric-label">Doanh thu hôm nay</div>
                    <div class="metric-number" style="color: var(--primary-red);">
                        <c:choose>
                            <c:when test="${totalRevenue != null}">
                                <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </c:when>
                            <c:otherwise>5,5tr VNĐ</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="metric-icon" style="background: #ffebee; color: var(--primary-red);">
                    <i class="fa-solid fa-money-bill-wave"></i>
                </div>
            </div>
        </div>

        <!-- Recent Orders Quick Table -->
        <div class="heritage-table-container" style="padding: 24px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
                <h3 style="font-family: var(--font-heading); font-size: 1.25rem; color: var(--dark-wood);">
                    <i class="fa-solid fa-clock-rotate-left" style="color: var(--primary-red);"></i> ĐƠN HÀNG MỚI NHẤT
                </h3>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn-pill-outline" style="font-size: 0.8rem;">
                    Xem tất cả đơn hàng <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <table class="heritage-table">
                <thead>
                    <tr>
                        <th>Mã Đơn</th>
                        <th>Khách Hàng</th>
                        <th>Ngày Đặt</th>
                        <th>Tổng Tiền</th>
                        <th>Trạng Thái</th>
                        <th style="text-align: center;">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${recentOrders}">
                        <tr>
                            <td><strong>#${o.id}</strong></td>
                            <td>${o.userName}</td>
                            <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td style="font-weight: 700; color: var(--primary-red);">
                                <fmt:formatNumber value="${o.totalMoney}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.status == 'PENDING'}"><span class="badge badge-pending">Chờ duyệt</span></c:when>
                                    <c:when test="${o.status == 'PROCESSING'}"><span class="badge badge-processing">Đang may</span></c:when>
                                    <c:when test="${o.status == 'SHIPPED'}"><span class="badge badge-shipped">Đang giao</span></c:when>
                                    <c:when test="${o.status == 'COMPLETED'}"><span class="badge badge-completed">Hoàn tất</span></c:when>
                                    <c:otherwise><span class="badge badge-cancelled">Đã hủy</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td style="text-align: center;">
                                <a href="${pageContext.request.contextPath}/admin/orders" class="btn-action-icon btn-action-edit" title="Quản lý đơn">
                                    <i class="fa-solid fa-pen-to-square"></i>
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
