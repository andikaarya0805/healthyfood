<%-- 
    Document   : admin-order-rows
    Created on : Jan 9, 2026, 11:31:57 PM
    Author     : andik
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Trik: Simpan jumlah order di input hidden biar bisa diambil JS buat update Badge Total --%>
<input type="hidden" id="server-order-count" value="${orderList.size()}">

<c:forEach var="o" items="${orderList}">
    <tr>
        <td>#${o.id}</td>
        <td>${o.orderDate}</td>
        <td class="fw-bold">${o.customerName}</td>
        <td class="small text-muted">${o.orderDetails}</td>
        <td class="fw-bold text-success">Rp ${o.totalAmount}</td>
        <td>
            <c:choose>
                <c:when test="${o.status == 'COMPLETED'}">
                    <span class="badge bg-success">SELESAI</span>
                </c:when>
                <c:otherwise>
                    <span class="badge bg-warning text-dark">PENDING</span>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:if test="${o.status == 'PENDING'}">
                <%-- Tombol Proses (Kita ubah jadi onclick function biar rapi) --%>
                <button class="btn btn-sm btn-primary" onclick="prosesPesanan('${o.id}')">
                    <i class="fas fa-check"></i> Proses
                </button>
            </c:if>
            <c:if test="${o.status == 'COMPLETED'}">
                <button class="btn btn-sm btn-secondary" disabled>Done</button>
            </c:if>
        </td>
    </tr>
</c:forEach>