<%-- 
    Document   : menu
    Created on : Jan 9, 2026
    Author     : andik
--%>

<%@ include file="common/header.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<div class="container py-5">
    <div class="text-center mb-5">
        <h2 class="fw-bold display-6">Daftar Menu Kami</h2>
        <div class="bg-success mx-auto mt-2" style="width: 80px; height: 4px; border-radius: 2px;"></div>
    </div>

    <%-- 2. LOGIC NOTIFIKASI POPUP (Pengganti Alert Biasa) --%>
    <c:if test="${param.status == 'success'}">
        <script>
            // Script ini otomatis jalan pas halaman dimuat kalau status=success
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({
                    title: 'Pembayaran Berhasil! ?',
                    text: 'Pesananmu sudah masuk dapur kami. Ditunggu ya!',
                    icon: 'success',
                    confirmButtonColor: '#198754', // Warna hijau Bootstrap
                    confirmButtonText: 'Siap, Ditunggu!',
                    backdrop: `
                        rgba(0,0,123,0.4)
                        left top
                        no-repeat
                    `
                    // Gambar gif konfeti (opsional, biar meriah)
                });
            });
        </script>
    </c:if>
    <%-- END LOGIC --%>

    <div class="row g-4">
        <c:forEach var="p" items="${productList}">
            <div class="col-md-4 col-sm-6">
                <div class="card card-food h-100">
                    
                    <%-- Gambar dari URL Database --%>
                    <div style="height: 200px; overflow: hidden;">
                        <img src="${p.imageUrl}" alt="${p.name}" class="w-100 h-100" style="object-fit: cover;" onerror="this.src='https://placehold.co/400x300?text=No+Image'">
                    </div>
                    
                    <div class="card-body d-flex flex-column">
                        <div class="mb-2">
                            <span class="badge bg-success-subtle text-success border border-success px-2 py-1 rounded-pill" style="font-size: 0.7rem;">
                                ${p.category}
                            </span>
                        </div>
                        <h5 class="card-title fw-bold">${p.name}</h5>
                        <p class="card-text text-muted small flex-grow-1">${p.description}</p>
                        
                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                            <span class="price-tag">Rp ${p.price}</span>
                            
                            <%-- Form Add to Cart --%>
                            <form action="cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" class="btn btn-sm btn-outline-success rounded-pill px-3 fw-bold">
                                    + Add
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>