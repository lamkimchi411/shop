package dao;

import model.User;
import java.util.List;

public interface UserDao {
    boolean insert(User user);
    boolean update(User user);
    boolean setActive(int id, boolean active);
    boolean updatePassword(int id, String newPassword);
    boolean delete(int id);
    User find(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    User checkLogin(String username, String password);
    List<User> findAll();
}
