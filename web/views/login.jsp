<%-- 
    Document   : login
    Created on : Jan 9, 2026, 10:15:28 PM
    Author     : andik
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login - HealthyCuy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center vh-100">
    <div class="card p-4 shadow-sm" style="width: 400px;">
        <h3 class="text-center text-success fw-bold mb-3">Login</h3>
        
        <c:if test="${not empty param.error or not empty error}">
            <div class="alert alert-danger small py-2">${empty error ? param.error : error}</div>
        </c:if>
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success small py-2">${param.msg}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="login">
            <div class="mb-3">
                <label class="fw-bold small">Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="fw-bold small">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Masuk</button>
        </form>
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/auth?action=register">Belum punya akun? Daftar</a>
        </div>
    </div>
</body>
</html>