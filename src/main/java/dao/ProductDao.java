package dao;

import model.Product;
import java.util.List;

public interface ProductDao {
    boolean insert(Product product);
    boolean update(Product product);
    boolean delete(int id);
    Product find(int id);
    List<Product> findAll();
    List<Product> news(int limit);
    List<Product> featured(int limit);
    List<Product> findByCategory(int categoryId);
    List<Product> searchByName(String keyword);
}
