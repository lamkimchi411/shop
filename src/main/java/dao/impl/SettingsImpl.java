package dao.impl;

import dao.SettingsDao;
import driver.MySQLDriver;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class SettingsImpl implements SettingsDao {

    private Map<String, String> getDefaultSettings() {
        Map<String, String> defaults = new HashMap<>();
        defaults.put("site_name", "Áo Dài Vietnam Tradition");
        defaults.put("site_slogan", "Tinh Hoa Cổ Phục & Trang Phục Truyền Thống Việt Nam");
        defaults.put("hotline", "1900 6868");
        defaults.put("contact_email", "contact@vietnamtradition.vn");
        defaults.put("address", "72 Lê Lợi, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh");
        defaults.put("currency", "VNĐ");
        return defaults;
    }

    @Override
    public Map<String, String> getSettings() {
        Map<String, String> settings = new HashMap<>(getDefaultSettings());
        String sql = "SELECT setting_key, setting_value FROM system_settings";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        settings.put(rs.getString("setting_key"), rs.getString("setting_value"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return settings;
    }

    @Override
    public boolean saveSettings(Map<String, String> settings) {
        String sql = "INSERT INTO system_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                for (Map.Entry<String, String> entry : settings.entrySet()) {
                    stmt.setString(1, entry.getKey());
                    stmt.setString(2, entry.getValue());
                    stmt.addBatch();
                }
                stmt.executeBatch();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public String get(String key, String defaultValue) {
        Map<String, String> settings = getSettings();
        return settings.getOrDefault(key, defaultValue);
    }
}
