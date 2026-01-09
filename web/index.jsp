<%-- 
    Document   : index
    Created on : Jan 9, 2026, 8:24:05?PM
    Author     : andik
--%>

<%@ include file="views/common/header.jsp" %>

 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<div class="hero-section text-center mb-5">
    <div class="container">
        <h1 class="display-3 fw-bold mb-3">Makan Enak, Tetap Sehat!</h1>
        <p class="fs-4 mb-4">Solusi catering diet dan makanan sehat tanpa rasa hambar.</p>
        <a href="menu" class="btn btn-warning btn-lg rounded-pill px-5 fw-bold shadow">
            Pesan Sekarang <i class="fas fa-arrow-right ms-2"></i>
        </a>
    </div>
</div>

<div class="container mb-5">
    <div class="row text-center g-4">
        <div class="col-md-4">
            <div class="p-4 bg-white rounded-4 shadow-sm h-100">
                <i class="fas fa-carrot fa-3x text-success mb-3"></i>
                <h4>Bahan Segar</h4>
                <p class="text-muted">Langsung dari petani lokal setiap pagi.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-4 bg-white rounded-4 shadow-sm h-100">
                <i class="fas fa-fire-alt fa-3x text-danger mb-3"></i>
                <h4>Rendah Kalori</h4>
                <p class="text-muted">Dihitung nutrisinya oleh ahli gizi.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-4 bg-white rounded-4 shadow-sm h-100">
                <i class="fas fa-shipping-fast fa-3x text-warning mb-3"></i>
                <h4>Pengiriman Cepat</h4>
                <p class="text-muted">Sampai di mejamu dalam keadaan hangat.</p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>