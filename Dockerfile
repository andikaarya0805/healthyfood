
# Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
# Click nbfs://nbhost/SystemFileSystem/Templates/Other/Dockerfile to edit this template

# Pake Tomcat versi terbaru
FROM tomcat:10.1-jdk17

# Hapus aplikasi default Tomcat biar bersih
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR hasil build NetBeans ke dalam Docker
# Pastikan nama folder dist dan file war sesuai project kamu!
# Kita rename jadi ROOT.war biar pas dibuka langsung muncul (gak perlu ketik /HealthyFood)
COPY dist/HealthyFood.war /usr/local/tomcat/webapps/ROOT.war

# Buka port 8080
EXPOSE 8080

# Jalankan Tomcat
CMD ["catalina.sh", "run"]