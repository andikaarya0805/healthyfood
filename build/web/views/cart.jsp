<%-- 
    Document   : cart
    Created on : Jan 9, 2026, 8:24:40?PM
    Author     : andik
--%>
<%@ include file="common/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="card-header bg-white border-bottom p-4">
                    <h3 class="fw-bold mb-0">? Keranjang Belanjaan</h3>
                </div>
                
                <div class="card-body p-4">
                    <c:if test="${empty sessionScope.cart}">
                        <div class="text-center py-5">
                            <div class="mb-3 display-1">?</div>
                            <h4>Keranjangmu masih kosong nih!</h4>
                            <p class="text-muted">Yuk pilih makanan sehat dulu.</p>
                            <a href="menu" class="btn btn-healthy mt-3">Lihat Menu</a>
                        </div>
                    </c:if>

                    <c:if test="${not empty sessionScope.cart}">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Menu</th>
                                        <th class="text-end">Harga</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="total" value="0" />
                                    <c:forEach var="item" items="${sessionScope.cart}">
                                        <tr>
                                            <td class="fw-bold text-secondary">${item.name}</td>
                                            <td class="text-end fw-bold">Rp ${item.price}</td>
                                        </tr>
                                        <c:set var="total" value="${total + item.price}" />
                                    </c:forEach>
                                </tbody>
                                <tfoot class="bg-light">
                                    <tr class="fw-bold fs-5">
                                        <td>Total Bayar</td>
                                        <td class="text-end text-success">Rp ${total}</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="mt-5 p-4 bg-light rounded-4 border border-dashed">
                            <h5 class="fw-bold mb-3"><i class="fas fa-receipt me-2"></i>Data Pemesan</h5>
                            <form action="cart" method="post">
                                <input type="hidden" name="action" value="checkout">
                                <div class="mb-3">
                                    <label class="form-label small text-muted fw-bold">NAMA LENGKAP</label>
                                    <input type="text" name="customerName" class="form-control form-control-lg rounded-3" placeholder="Contoh: Budi Santoso" required>
                                </div>
                                <button type="submit" class="btn btn-healthy w-100 py-3 fs-5 shadow-sm">
                                    Bayar Sekarang ?
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>