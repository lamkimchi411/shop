package model;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * Entity Model: Cart (Giỏ hàng)
 */
public class Cart implements Serializable {
    private static final long serialVersionUID = 1L;

    private Map<Integer, CartItem> itemsMap = new HashMap<>();

    public Cart() {
    }

    public Map<Integer, CartItem> getItemsMap() {
        return itemsMap;
    }

    public Collection<CartItem> getItems() {
        return itemsMap.values();
    }

    public void addItem(Product product, int quantity) {
        if (product == null) return;
        int pid = product.getId();
        if (itemsMap.containsKey(pid)) {
            CartItem item = itemsMap.get(pid);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            itemsMap.put(pid, new CartItem(product, quantity));
        }
    }

    public void updateItem(int productId, int quantity) {
        if (itemsMap.containsKey(productId)) {
            if (quantity <= 0) {
                itemsMap.remove(productId);
            } else {
                itemsMap.get(productId).setQuantity(quantity);
            }
        }
    }

    public void removeItem(int productId) {
        itemsMap.remove(productId);
    }

    public void clear() {
        itemsMap.clear();
    }

    public boolean isEmpty() {
        return itemsMap.isEmpty();
    }

    public int getSize() {
        int count = 0;
        for (CartItem item : itemsMap.values()) {
            count += item.getQuantity();
        }
        return count;
    }

    public double getTotalMoney() {
        double total = 0;
        for (CartItem item : itemsMap.values()) {
            total += item.getSubtotal();
        }
        return total;
    }
}
