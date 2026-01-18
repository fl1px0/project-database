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
('Мария Волкова', '+79993334455', 'ул. Гагарина, 4'),
('Светлана Морозова', '+79990002211', 'ул. Пушкина, 17'),
('Артем Соколов', '+79991113344', 'ул. Спортивная, 9'),
('Елена Крылова', '+79992224455', 'ул. Лесная, 30'),
('Владимир Захаров', '+79993335566', 'ул. Парковая, 48'),
('Галина Федорова', '+79994446677', 'ул. Солнечная, 3'),
('Денис Андреев', '+79995557788', 'ул. Школьная, 14'),
('Татьяна Комарова', '+79996668899', 'ул. Полевая, 6'),
('Александр Лебедев', '+79997779900', 'ул. Южная, 11');


INSERT INTO Restaurants (name, address) VALUES
('Pizza House', 'ул. Центральная, 10'),
('Sushi Time', 'пр. Победы, 22'),
('Burger City', 'ул. Молодёжная, 5'),
('Pasta Point', 'ул. Итальянская, 12'),
('Grill Master', 'ул. Огненная, 7'),
('Vegan World', 'пр. Эко, 12'),
('Taco Fiesta', 'ул. Мексиканская, 9'),
('Coffee Corner', 'ул. Чайная, 4');


INSERT INTO MenuItems (restaurant_id, name, category, price) VALUES
(1, 'Пепперони', 'Пицца', 650.00),
(1, 'Маргарита', 'Пицца', 550.00),
(1, 'Кола', 'Напитки', 120.00),
(2, 'Филадельфия', 'Роллы', 720.00),
(2, 'Калифорния', 'Роллы', 680.00),
(3, 'Чизбургер', 'Бургеры', 390.00),
(4, 'Карбонара', 'Паста', 610.00),
(5, 'Стейк Рибай', 'Гриль', 1200.00),
(5, 'Овощи гриль', 'Гарниры', 350.00),
(6, 'Боул овощной', 'Веган', 540.00),
(6, 'Смузи зелёный', 'Напитки', 260.00),
(7, 'Тако с курицей', 'Тако', 430.00),
(7, 'Тако с говядиной', 'Тако', 470.00),
(8, 'Капучино', 'Кофе', 190.00),
(8, 'Чизкейк', 'Десерты', 320.00);


INSERT INTO Orders (customer_id, restaurant_id, order_time, total_price, status) VALUES
(1, 1, '2025-12-15 18:30:00', 1320.00, 'preparing'),
(2, 2, '2025-12-15 19:10:00', 1400.00, 'delivering'),
(3, 3, '2025-12-15 19:40:00', 390.00, 'new'),
(4, 4, '2025-12-15 20:00:00', 610.00, 'delivered'),
(5, 5, '2025-12-15 20:30:00', 1550.00, 'new'),
(6, 6, '2025-12-15 20:50:00', 800.00, 'preparing'),
(7, 7, '2025-12-15 21:10:00', 900.00, 'delivering'),
(8, 8, '2025-12-15 21:20:00', 510.00, 'delivered'),
(9, 5, '2025-12-15 21:40:00', 350.00, 'new'),
(10, 6, '2025-12-15 21:55:00', 540.00, 'delivered'),
(11, 7, '2025-12-15 22:05:00', 870.00, 'preparing'),
(12, 8, '2025-12-15 22:15:00', 510.00, 'new');

INSERT INTO OrderItems (order_id, item_id, quantity, price_each) VALUES
(1, 1, 1, 650.00),
(1, 2, 1, 550.00),
(1, 3, 1, 120.00),
(2, 4, 1, 720.00),
(2, 5, 1, 680.00),
(3, 6, 1, 390.00),
(4, 7, 1, 610.00);
(5, 8, 1, 1200.00),
(5, 9, 1, 350.00),
(6, 10, 1, 540.00),
(6, 11, 1, 260.00),
(7, 12, 2, 430.00),
(7, 13, 1, 470.00),
(8, 14, 1, 190.00),
(8, 15, 1, 320.00),
(9, 9, 1, 350.00),
(10, 10, 1, 540.00),
(11, 12, 1, 430.00),
(11, 13, 1, 470.00),
(12, 14, 1, 190.00),
(12, 15, 1, 320.00);

INSERT INTO Couriers (full_name, phone, transport) VALUES
('Алексей Иванов', '+79994445566', 'bike'),
('Дмитрий Орлов', '+79995556677', 'car'),
('Сергей Никитин', '+79996667788', 'foot'),
('Илья Данилов', '+79998889911', 'bike'),
('Максим Корнев', '+79997778866', 'scooter'),
('Роман Ершов', '+79996667755', 'car'),
('Ольга Белова', '+79995556644', 'foot');

INSERT INTO Deliveries (order_id, courier_id, pickup_time, delivery_time, status) VALUES
(1, 1, '2025-12-15 18:50:00', NULL, 'on_way'),
(2, 2, '2025-12-15 19:20:00', NULL, 'on_way'),
(4, 3, '2025-12-15 20:10:00', '2025-12-15 20:40:00', 'delivered'),
(5, 4, '2025-12-15 20:40:00', NULL, 'on_way'),
(6, 5, '2025-12-15 21:00:00', NULL, 'on_way'),
(7, 6, '2025-12-15 21:20:00', NULL, 'on_way'),
(8, 7, '2025-12-15 21:30:00', '2025-12-15 21:50:00', 'delivered'),
(9, 4, NULL, NULL, 'waiting'),
(10, 5, '2025-12-15 21:50:00', '2025-12-15 22:10:00', 'delivered'),
(11, 6, '2025-12-15 22:00:00', NULL, 'on_way'),
(12, 7, NULL, NULL, 'waiting');
