package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * EncodingFilter - Đảm bảo mã hóa UTF-8 toàn bộ Request & Response (Jakarta EE / Tomcat 10+)
 */
@WebFilter("/*")
public class EncodingFilter implements Filter {

    private String encoding = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String envEncoding = filterConfig.getInitParameter("encoding");
        if (envEncoding != null && !envEncoding.isEmpty()) {
            this.encoding = envEncoding;
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        request.setCharacterEncoding(encoding);
        response.setCharacterEncoding(encoding);

        if (request instanceof HttpServletRequest) {
            String uri = ((HttpServletRequest) request).getRequestURI();
            // Không gán text/html cho các tài nguyên tĩnh như CSS, JS, hình ảnh
            if (!uri.contains("/static/") && !uri.endsWith(".css") && !uri.endsWith(".js") && !uri.endsWith(".png") && !uri.endsWith(".jpg")) {
                response.setContentType("text/html; charset=" + encoding);
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
