<%-- 
    Document   : header
    Created on : Jan 9, 2026, 8:23:47 PM
    Author     : andik
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthyFood</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top py-3">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">HealthyFood</a>
        
        <%-- WAJIB ADA: Tombol Hamburger buat HP --%>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <%-- END TOMBOL --%>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto gap-3 align-items-center">
                 <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menu">Menu</a></li>
                 <li class="nav-item"><a class="btn btn-outline-success rounded-pill px-4" href="${pageContext.request.contextPath}/cart">Keranjang</a></li>
                 
                 <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item fw-bold text-success py-2 py-lg-0">Hai, ${sessionScope.user.username}</li>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                             <li><a class="btn btn-sm btn-outline-dark w-100" href="${pageContext.request.contextPath}/admin">Admin Panel</a></li>
                        </c:if>
                        <li class="nav-item"><a class="btn btn-danger btn-sm rounded-pill w-100" href="${pageContext.request.contextPath}/auth?action=logout">Logout</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="btn btn-success rounded-pill w-100" href="${pageContext.request.contextPath}/auth?action=login">Login</a></li>
                    </c:otherwise>
                 </c:choose>
            </ul>
        </div>
    </div>
</nav>

<%-- SCRIPT "MATA-MATA" NOTIFIKASI REALTIME --%>
<c:if test="${not empty sessionScope.user and sessionScope.user.role == 'USER'}">
<script>
    let lastKnownStatus = localStorage.getItem('lastStatus') || 'PENDING';

    function checkOrderStatus() {
        fetch('${pageContext.request.contextPath}/check-status')
            .then(response => response.text())
            .then(status => {
                // Kalau status berubah dari PENDING jadi COMPLETED
                if (status === 'COMPLETED' && lastKnownStatus === 'PENDING') {
                    
                    Swal.fire({
                        title: 'Pesanan Selesai! 🍽️',
                        text: 'Makananmu sudah siap/diantar. Selamat menikmati!',
                        icon: 'success',
                        confirmButtonColor: '#4ade80'
                    });

                    lastKnownStatus = 'COMPLETED';
                    localStorage.setItem('lastStatus', 'COMPLETED');
                } 
                else if (status === 'PENDING') {
                    lastKnownStatus = 'PENDING';
                    localStorage.setItem('lastStatus', 'PENDING');
                }
            })
            .catch(e => console.log("Cek status skip dulu.."));
    }

    setInterval(checkOrderStatus, 3000);
</script>
</c:if>
</body>
</html>