# Pake Tomcat 10.1 (Terbaru)
FROM tomcat:10.1-jdk17

# --- BAGIAN PENTING: DOWNLOAD LIBRARY JSTL ---
# Tomcat polosan gak punya JSTL, jadi kita download manual & taruh di folder lib server
ADD https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/3.0.1/jakarta.servlet.jsp.jstl-3.0.1.jar /usr/local/tomcat/lib/
ADD https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.0/jakarta.servlet.jsp.jstl-api-3.0.0.jar /usr/local/tomcat/lib/
# ---------------------------------------------

# Hapus aplikasi default Tomcat biar bersih
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR hasil build NetBeans ke dalam Docker
# Pastikan nama folder dist dan file war sesuai project kamu
COPY dist/HealthyFood.war /usr/local/tomcat/webapps/ROOT.war

# Buka port 8080
EXPOSE 8080

# Jalankan Tomcat
CMD ["catalina.sh", "run"]