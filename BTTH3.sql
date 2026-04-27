create database mini_mart;
use mini_mart;

create table customers (
    id int primary key auto_increment,
    full_name varchar(100) not null,
    phone varchar(15) unique,
    address varchar(150),
    customer_type enum('Normal', 'VIP') default 'Normal'
);

create table products(
    id int primary key auto_increment,
    product_name varchar(50) not null,
    category varchar(25),
    price decimal(10, 2) check (price >= 0),
    stock int check (stock >= 0)
);

create table orders(
    id int primary key auto_increment,
    customer_id int,
    order_date date default (current_date),
    status enum('completed', 'cancelled') default 'completed',
    foreign key (customer_id) references customers(id)
);

create table order_details(
    id int primary key auto_increment,
    order_id int,
    product_id int,
    quantity int check (quantity > 0),
    total_price decimal(10, 2),
    foreign key (order_id) references orders(id),
    foreign key (product_id) references products(id)
);

insert into customers(full_name, phone, address, customer_type)
values
	('Nguyễn Văn A', '091111111', 'Đà Nẵng', 'VIP'),
	('Trần Thị B', '092222222', 'Hải Phòng', 'Normal'),
	('Lê Văn C', '093333333', 'Hà Nội', 'VIP'),
	('Phạm Thị D', '094444444', 'TP. HCM', 'Normal'),
	('Hoàng Văn E', '095555555', 'Huế', 'Normal'),
	('Đỗ Thị F', '096666666', 'Cần Thơ', 'Normal'),
	('Vũ Văn G', '097777777', 'Quảng Ninh', 'Normal');
    
insert into products(product_name, category, price, stock)
values
	('Mì tôm', 'Thực phẩm', 20000, 50),
	('Bánh mì', 'Thực phẩm', 15000, 40),
	('Nem chua', 'Thực phẩm', 30000, 0),
	('Dầu gội', 'Chăm sóc cá nhân', 80000, 25),
	('Xà phòng', 'Chăm sóc cá nhân', 10000, 60),
	('Kem đánh răng', 'Chăm sóc cá nhân', 35000, 30),
	('Coca', 'Nước giải khát', 12000, 100),
	('Pepsi', 'Nước giải khát', 12000, 90),
	('Nước cam', 'Nước giải khát', 25000, 20),
	('Nước lọc', 'Nước giải khát', 5000, 200);

insert into orders(customer_id, order_date, status)
values
	(1, '2026-04-01', 'completed'),
	(2, '2026-04-02', 'completed'),
	(3, '2026-04-03', 'completed'),
	(4, '2026-04-04', 'cancelled'),
	(5, '2026-04-05', 'completed');
    
insert into order_details(order_id, product_id, quantity, total_price)
values
	(1, 1, 5, 100000),
	(1, 2, 2, 30000),
	(1, 4, 1, 80000),
	(2, 3, 1, 30000),
	(2, 5, 3, 30000),
	(3, 6, 2, 70000),
	(3, 7, 5, 60000),
	(3, 8, 1, 12000),
	(4, 2, 1, 15000),
	(4, 9, 2, 50000),
	(5, 1, 1, 20000),
	(5, 10, 4, 20000);
    
select sum(od.total_price) as 'Tổng Thu'
from orders o
join order_details od on od.order_id = o.id
where o.status = 'completed';

select
	category as 'Danh Mục',
	count(*) as 'Số Lượng SP',
    avg(price) as 'Giá Trung Bình'
from products
group by category;

select 
    c.full_name as 'Tên Khách',
    sum(od.total_price) as 'Tổng Tiền Đã Chi'
from customers c
join orders o on o.customer_id = c.id
join order_details od on od.order_id = o.id
where o.status = 'completed'
group by c.id, c.full_name
having sum(od.total_price) > 500000;

select *
from products
where price > (
    select avg(price)
    from products
);
    
    
    
