package controller.admin;

import dao.DatabaseDao;
import dao.SettingsDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 * Controller: Admin Quản Lý Cài Đặt Banner & Giao Diện
 */
@WebServlet(name = "AdminSettingsServlet", urlPatterns = {"/admin/settings"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminSettingsServlet extends BaseAdminServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SettingsDao settingsDao = DatabaseDao.getInstance().getSettingsDao();
        Map<String, String> settings = settingsDao.getSettings();
        request.setAttribute("settings", settings);
        request.getRequestDispatcher("/views/admin/settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SettingsDao settingsDao = DatabaseDao.getInstance().getSettingsDao();
        Map<String, String> settings = settingsDao.getSettings();

        String heroTitle = request.getParameter("hero_title");
        String heroSubtitle = request.getParameter("hero_subtitle");
        String bgLeftUrl = request.getParameter("hero_bg_left");
        String bgRightUrl = request.getParameter("hero_bg_right");
        String floatingImgUrl = request.getParameter("hero_floating_img");

        String uploadedLeft = handleFileUpload(request, "hero_bg_left_file");
        if (uploadedLeft != null) bgLeftUrl = uploadedLeft;

        String uploadedRight = handleFileUpload(request, "hero_bg_right_file");
        if (uploadedRight != null) bgRightUrl = uploadedRight;

        String uploadedFloating = handleFileUpload(request, "hero_floating_img_file");
        if (uploadedFloating != null) floatingImgUrl = uploadedFloating;

        Map<String, String> newSettings = new HashMap<>(settings);

        if (heroTitle != null && !heroTitle.trim().isEmpty()) {
            newSettings.put("hero_title", heroTitle.trim());
        }
        if (heroSubtitle != null && !heroSubtitle.trim().isEmpty()) {
            newSettings.put("hero_subtitle", heroSubtitle.trim());
        }
        if (bgLeftUrl != null && !bgLeftUrl.trim().isEmpty()) {
            newSettings.put("hero_bg_left", bgLeftUrl.trim());
        }
        if (bgRightUrl != null && !bgRightUrl.trim().isEmpty()) {
            newSettings.put("hero_bg_right", bgRightUrl.trim());
        }
        if (floatingImgUrl != null && !floatingImgUrl.trim().isEmpty()) {
            newSettings.put("hero_floating_img", floatingImgUrl.trim());
        }

        settingsDao.saveSettings(newSettings);

        request.getSession().setAttribute("successMsg", "Cập nhật cài đặt giao diện Banner Stage thành công!");
        response.sendRedirect(request.getContextPath() + "/admin/settings");
    }

    private String handleFileUpload(HttpServletRequest request, String fieldName) {
        try {
            Part filePart = request.getPart(fieldName);
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/") + "static" + File.separator + "images";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String savedFileName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadDir + File.separator + savedFileName);
                return "static/images/" + savedFileName;
            }
        } catch (Exception ignored) {
        }
        return null;
    }
}
