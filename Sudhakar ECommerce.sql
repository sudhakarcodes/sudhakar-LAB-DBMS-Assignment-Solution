use order_directory;

create table supplier(
	SUPP_ID int primary key auto_increment,
    SUPP_NAME varchar(50) not null,
    SUPP_CITY varchar(50),
    SUPP_PHONE varchar(50) not null
);

create table customer(
	CUS_ID int primary key auto_increment,
	CUS_NAME varchar(20) not null,
    CUS_PHONE varchar(10) not null,
    CUS_CITY varchar(30) not null,
    CUS_GENDER varchar(1)
);

create table category(
	CAT_ID int primary key auto_increment,
	CAT_NAME varchar(50) not null	
);

create table product(
	PRO_ID int primary key auto_increment,
    PRO_NAME varchar(20) not null default 'Dummy',
    PRO_DESC varchar(60),
    CAT_ID int not null,
    foreign key (CAT_ID) references category(CAT_ID)
);

create table supplier_pricing (
	PRICING_ID int primary key auto_increment,
    PRO_ID int not null,
    SUPP_ID int not null,
    SUPP_PRICE int not null default 0,
    foreign key (PRO_ID) references product(PRO_ID),
    foreign key (SUPP_ID) references supplier(SUPP_ID)
);

create table `order`(
	ORD_ID int primary key auto_increment,
    ORD_AMOUNT int not null,
    ORD_DATE date,
    CUS_ID int not null,
    PRICING_ID int not null,
    foreign key (CUS_ID) references customer(CUS_ID),
    foreign key (PRICING_ID) references supplier_pricing(PRICING_ID)
);

create table rating (
	RAT_ID int primary key,
    ORD_ID int not null,
    RAT_RATSTARS int not null,
    foreign key (ORD_ID) references `order`(ORD_ID)
);

insert into supplier values(1, "Rajesh Retails", "Delhi", "1234567890");
insert into supplier values(2, "Appario Ltd", "Mumbai", "2589631470");
insert into supplier values(3, "Knome products", "Bangalore", "9785462315");
insert into supplier values(4, "Bansal Retails", "Kochi", "8975463285");
insert into supplier values(5, "Mittal Ltd", "Lucknow", "7898456532");

insert into customer values(1,"Aaksh", "9999999999", "Delhi", "M");
insert into customer values(2,"Aman", "9785463215", "Noida", "M");
insert into customer values(3, "Neha", "9999999999", "Mumbai", "F");
insert into customer values(4, "Megha", "9998889991", "Kolkata", "F");

insert into category values(1,"Books");
insert into category values(2,"Games");
insert into category values(3,"Groceries");
insert into category values(4,"Electronics");

insert into product values(1,"GTA V", "Windows 7 and above", 2);
insert into product values(2,"Tshirt", "Size-L Black", 5);
insert into product values(3,"Rog Laptop", "Windows 10 with 15inch screen", 4);
insert into product values(4,"Oats", "Highly Nutritious from Nestle", 3);
insert into product values(5,"Harry Potter", "All time best JK Rowling", 1);
insert into product values(6,"Milk", "1L Toned Milk", 3);
insert into product values(7,"Boat Earphones", "1.5m long Dolby Atoms", 4);
insert into product values(8,"Jeans", "Stretchable Denim Jeans", 5);
insert into product values(9,"Project IGI", "Compatable with Windows 10 and above", 2);
insert into product values(10,"Hoodie", "Black Gucci", 5);
insert into product values(11,"Rich Dad Poor Dad", "Written by Robert Kiyosaki", 1);
insert into product values(12,"Train your Brain", "By Shireen Stephen", 1);

insert into supplier_pricing values(1,1,2,1500);
insert into supplier_pricing values(2,3,5,30000);
insert into supplier_pricing values(3,5,1,3000);
insert into supplier_pricing values(4,2,3,2500);
insert into supplier_pricing values(5,4,1,1000);

insert into `order` values(101, 1500, "2021-10-06", 2,1);
insert into `order` values(102, 1000, "2021-10-12", 3,5);
insert into `order` values(103, 30000, "2021-09-16", 5,2);
insert into `order` values(104, 1500, "2021-10-05", 1,1);
insert into `order` values(105, 3000, "2021-08-16", 4,3);
insert into `order` values(106, 1450, "2021-08-18", 1,4);
insert into `order` values(107, 789, "2021-09-01", 3,5);
insert into `order` values(108, 780, "2021-09-07", 5,3);
insert into `order` values(109, 3000, "2021-00-10", 5,3);
insert into `order` values(110, 2500, "2021-09-10", 2,4);
insert into `order` values(111, 1000, "2021-09-15", 4,5);
insert into `order` values(112, 789, "2021-09-16", 4,5);
insert into `order` values(113, 31000, "2021-09-16", 1,1);
insert into `order` values(114, 1000, "2021-09-16", 3,5);
insert into `order` values(115, 3000, "2021-09-16", 5,3);
insert into `order` values(116, 99, "2021-09-17", 2,2);

insert into rating values(1,101,4);
insert into rating values(2,102,3);
insert into rating values(3,103,1);
insert into rating values(4,104,2);
insert into rating values(5,105,4);
insert into rating values(6,106,3);
insert into rating values(7,107,4);
insert into rating values(8,108,4);
insert into rating values(9,109,3);
insert into rating values(10,110,5);
insert into rating values(11,111,3);
insert into rating values(12,112,4);
insert into rating values(13,113,2);
insert into rating values(14,114,1);
insert into rating values(15,115,1);
insert into rating values(16,116,0);

-- q4

select cus_gender, count(cus_gender) from customer 
	where cus_id in (select cus_id from `order` group by cus_id 
		having sum(ord_amount) >= 3000)
        group by cus_gender
        order by cus_gender;
-- Q5
select ord_id, ord_amount, ord_date, o.cus_id, o.pricing_id, pro_name
	from `order` o, customer c, supplier_pricing sp, product p
		where o.cus_id = c.cus_id
			and o.pricing_id = sp.pricing_id
            and sp.pro_id = p.pro_id
            and c.cus_id = 2;

-- Q6

select * from supplier where 
	supp_id in (select supp_id from supplier_pricing group by supp_id having count(supp_id)>1);
    
-- select @@session.sql_mode into @session_sql_mode;
-- set session sql_mode='';

select c.cat_id, cat_name, pro_name, min_price from
	(select cat_id, p.pro_id, min(supp_price) min_price from supplier_pricing sp, product p where
		sp.pro_id = p.pro_id group by p.cat_id) as cat_min_price, category c, product p
			where c.cat_id =p.cat_id 
				and p.pro_id = cat_min_price.pro_id;
                
-- set session sql_mode = @session_sql_mode;

-- Q7

select p.pro_id, pro_name from product p, supplier_pricing sp, `order` o 
	where p.pro_id = sp.pro_id
		and sp.pricing_id = o.pricing_id 
        and o.ord_date > '2021-10-05';
        
-- q8
select cus_name, cus_gender from customer where cus_name like 'A%' or cus_name like '%A';

-- q9

DELIMITER &&
CREATE PROCEDURE display_supplier_ratings()
BEGIN
select s.supp_id, s.supp_name, avg(ratstars),
	case when avg(rat_ratstars) = 5 then 'Excellent Service'
		 when avg(rat_ratstars) >4 then 'Good Service'
         when avg(rat_ratstars) >2 then 'Average Service'
         else 'Poor Service'
	end as type_of_service
    from supplier s, `order` o, supplier_pricing sp, rating r
    where s.supp_id = sp.supp_id
		and sp.pricing_id = o.pricing_id
        and o.ord_id = r.ord_id
	group by s.supp_id order by s.supp_id; 

END &&
-- DELIMITTER ; 

call display_supplier_ratings()


    
            