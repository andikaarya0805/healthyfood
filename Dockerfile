# UPDATE KE JDK 21 (Supaya cocok sama NetBeans kamu)
FROM tomcat:10.1-jdk21

# --- JSTL LIBRARIES (Tetap Pertahankan ini) ---
ADD https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/3.0.1/jakarta.servlet.jsp.jstl-3.0.1.jar /usr/local/tomcat/lib/
ADD https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.0/jakarta.servlet.jsp.jstl-api-3.0.0.jar /usr/local/tomcat/lib/
# ---------------------------------------------

# Bersihkan default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR
COPY dist/HealthyFood.war /usr/local/tomcat/webapps/ROOT.war

# Port
EXPOSE 8080

# Run
CMD ["catalina.sh", "run"]