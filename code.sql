-- Клиенты 
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL
);

-- Рестораны
CREATE TABLE Restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
);
-- Позиции меню
CREATE TABLE MenuItems (
    item_id SERIAL PRIMARY KEY,
    restaurant_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);
-- Заказы
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_time TIMESTAMP NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);
-- Позиции заказа
CREATE TABLE OrderItems (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    price_each DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES MenuItems(item_id)
);
--Курьеры
CREATE TABLE Couriers (
    courier_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    transport VARCHAR(20)
);
--Доставки
CREATE TABLE Deliveries (
    delivery_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    courier_id INT NOT NULL,
    pickup_time TIMESTAMP,
    delivery_time TIMESTAMP,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (courier_id) REFERENCES Couriers(courier_id)
);

INSERT INTO Customers (full_name, phone, address) VALUES
('Иван Петров', '+79990001122', 'ул. Ленина, 15'),
('Анна Смирнова', '+79991112233', 'пр. Мира, 8'),
('Олег Кузнецов', '+79992223344', 'ул. Советская, 21'),
('Мария Волкова', '+79993334455', 'ул. Гагарина, 4');

INSERT INTO Restaurants (name, address) VALUES
('Pizza House', 'ул. Центральная, 10'),
('Sushi Time', 'пр. Победы, 22'),
('Burger City', 'ул. Молодёжная, 5'),
('Pasta Point', 'ул. Итальянская, 12');

INSERT INTO MenuItems (restaurant_id, name, category, price) VALUES
(1, 'Пепперони', 'Пицца', 650.00),
(1, 'Маргарита', 'Пицца', 550.00),
(1, 'Кола', 'Напитки', 120.00),
(2, 'Филадельфия', 'Роллы', 720.00),
(2, 'Калифорния', 'Роллы', 680.00),
(3, 'Чизбургер', 'Бургеры', 390.00),
(4, 'Карбонара', 'Паста', 610.00);

INSERT INTO Orders (customer_id, restaurant_id, order_time, total_price, status) VALUES
(1, 1, '2025-12-15 18:30:00', 1320.00, 'preparing'),
(2, 2, '2025-12-15 19:10:00', 1400.00, 'delivering'),
(3, 3, '2025-12-15 19:40:00', 390.00, 'new'),
(4, 4, '2025-12-15 20:00:00', 610.00, 'delivered');

INSERT INTO OrderItems (order_id, item_id, quantity, price_each) VALUES
(1, 1, 1, 650.00),
(1, 2, 1, 550.00),
(1, 3, 1, 120.00),
(2, 4, 1, 720.00),
(2, 5, 1, 680.00),
(3, 6, 1, 390.00),
(4, 7, 1, 610.00);

INSERT INTO Couriers (full_name, phone, transport) VALUES
('Алексей Иванов', '+79994445566', 'bike'),
('Дмитрий Орлов', '+79995556677', 'car'),
('Сергей Никитин', '+79996667788', 'foot');

INSERT INTO Deliveries (order_id, courier_id, pickup_time, delivery_time, status) VALUES
(1, 1, '2025-12-15 18:50:00', NULL, 'on_way'),
(2, 2, '2025-12-15 19:20:00', NULL, 'on_way'),
(4, 3, '2025-12-15 20:10:00', '2025-12-15 20:40:00', 'delivered');
