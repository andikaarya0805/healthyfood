<%-- 
    Document   : admin
    Created on : Jan 9, 2026, 10:09:05 PM
    Author     : andik
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Admin Panel - HealthyFood</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body { background-color: #f8f9fa; }
        .card-custom { border: none; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .img-thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 8px; }
        .table-responsive { max-height: 400px; overflow-y: auto; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark mb-4 sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">Admin HealthyFood</a>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/menu" class="btn btn-outline-light btn-sm">Web Utama</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn btn-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container pb-5">
    
    <div class="row mb-5">
        <div class="col-12">
            <div class="card card-custom p-4 border-start border-5 border-primary">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="fw-bold"><i class="fas fa-shopping-cart text-primary"></i> Daftar Pesanan Masuk</h4>
                    <span class="badge bg-primary rounded-pill" id="totalOrdersBadge">Total: ${orderList.size()}</span>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>#ID</th><th>Tanggal</th><th>Pelanggan</th><th>Detail</th><th>Total</th><th>Status</th><th>Aksi</th></tr>
                        </thead>
                        <%-- ID buat diinject data baru via AJAX --%>
                        <tbody id="orderTableBody">
                            <%-- Kita include fragment di sini untuk tampilan awal --%>
                            <jsp:include page="admin-order-rows.jsp" />
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card card-custom p-4 border-start border-5 border-success">
                <h5 class="fw-bold mb-3">Tambah Menu Baru</h5>
                <form action="${pageContext.request.contextPath}/admin" method="post">
                    <input type="hidden" name="action" value="insert">
                    <div class="mb-3"><input type="text" name="name" class="form-control" required placeholder="Nama Menu"></div>
                    <div class="mb-3"><textarea name="description" class="form-control" rows="2" required placeholder="Deskripsi"></textarea></div>
                    <div class="mb-3"><input type="number" name="price" class="form-control" required placeholder="Harga"></div>
                    <div class="mb-3">
                        <select name="category" class="form-select">
                            <option value="FOOD">Makanan</option>
                            <option value="DRINK">Minuman</option>
                        </select>
                    </div>
                    <div class="mb-3"><input type="text" name="imageUrl" class="form-control" placeholder="Link Gambar (Unsplash)"></div>
                    <button type="submit" class="btn btn-success w-100 fw-bold">Simpan</button>
                </form>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card card-custom p-4">
                <h5 class="fw-bold">List Menu</h5>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr><th>Gbr</th><th>Menu</th><th>Harga</th><th>Aksi</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${productList}">
                                <tr>
                                    <td><img src="${p.imageUrl}" class="img-thumb" onerror="this.src='https://placehold.co/50'"></td>
                                    <td><div class="fw-bold">${p.name}</div><small class="text-muted">${p.category}</small></td>
                                    <td>Rp ${p.price}</td>
                                    <td>
                                        <form id="delete-form-${p.id}" action="${pageContext.request.contextPath}/admin" method="post">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${p.id}">
                                            <button type="button" class="btn btn-danger btn-sm" onclick="konfirmasiHapus('${p.id}', '${p.name}')"><i class="fas fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 1. AUTO REFRESH ORDERAN (Jalan setiap 3 detik)
    setInterval(function() {
        fetch('${pageContext.request.contextPath}/admin-refresh')
            .then(response => response.text())
            .then(html => {
                // Update isi tabel
                document.getElementById('orderTableBody').innerHTML = html;
                
                // Update Total Badge (Ngambil value dari hidden input di file fragment)
                let count = document.getElementById('server-order-count').value;
                document.getElementById('totalOrdersBadge').innerText = 'Total: ' + count;
            })
            .catch(err => console.error('Gagal refresh order:', err));
    }, 3000); // 3000ms = 3 detik

    // 2. PROSES PESANAN (AJAX)
    function prosesPesanan(id) {
        Swal.fire({
            title: 'Proses Pesanan?', text: "Status akan berubah jadi SELESAI.", icon: 'question',
            showCancelButton: true, confirmButtonText: 'Ya, Proses!'
        }).then((result) => {
            if (result.isConfirmed) {
                let params = new URLSearchParams();
                params.append('action', 'updateStatus');
                params.append('id', id);
                params.append('status', 'COMPLETED');

                fetch('${pageContext.request.contextPath}/admin', {method: 'POST', body: params})
                .then(() => {
                    Swal.fire('Berhasil!', 'Pesanan selesai.', 'success');
                    // Gak perlu reload page manual, nanti otomatis ke-refresh sama script di atas
                });
            }
        })
    }

    // 3. DELETE MENU (AJAX)
    function konfirmasiHapus(id, namaMenu) {
        Swal.fire({
            title: 'Hapus ' + namaMenu + '?', text: "Data hilang permanen!", icon: 'warning',
            showCancelButton: true, confirmButtonColor: '#d33', confirmButtonText: 'Hapus'
        }).then((result) => {
            if (result.isConfirmed) {
                let params = new URLSearchParams(); params.append('action', 'delete'); params.append('id', id);
                fetch('${pageContext.request.contextPath}/admin', {method: 'POST', body: params})
                .then(() => location.reload());
            }
        })
    }
</script>

</body>
</html>