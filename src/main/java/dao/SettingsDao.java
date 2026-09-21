package dao;

import java.util.Map;

public interface SettingsDao {
    Map<String, String> getSettings();
    boolean saveSettings(Map<String, String> settings);
    String get(String key, String defaultValue);
}
