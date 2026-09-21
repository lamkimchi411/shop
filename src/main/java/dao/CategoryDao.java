package dao;

import model.Category;
import java.util.List;

public interface CategoryDao {
    boolean insert(Category category);
    boolean update(Category category);
    boolean delete(int id);
    Category find(int id);
    List<Category> findAll();
}
