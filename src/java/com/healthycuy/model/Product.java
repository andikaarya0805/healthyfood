package com.healthycuy.model;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private String imageUrl;
    private String category;

    // 1. Constructor Kosong (Wajib ada buat tool/framework tertentu)
    public Product() {}

    // 2. Constructor Lengkap (Buat gampang bikin object baru)
    public Product(int id, String name, String description, double price, String imageUrl, String category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.category = category;
    }

    // 3. Getter & Setter (Penting biar bisa dibaca JSP ${p.name})
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}