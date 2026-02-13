USE flipkart_db;

-- Checking the datatype of each columns 
DESCRIBE `flipkart sales dataset`;

-- Changing the datatype of OrderDate and DeliveryDate from text to date 
UPDATE `flipkart sales dataset`
SET OrderDate = STR_TO_DATE(OrderDate, '%m/%d/%Y');

UPDATE `flipkart sales dataset`
SET `Delivery Date` = STR_TO_DATE(`Delivery Date`, '%m/%d/%Y');

UPDATE `flipkart sales dataset`
SET Reason = 'No Reason Specified'
WHERE Reason IS NULL OR Reason = '';


-- 1. BASIC / DESCRIPTIVE QUESTIONS

-- SECTION 1 SALES OVERVIEW 

-- PROBLEM STATEMENT 1 : Find the total number of orders placed
-- There are 133503 total orders in the dataset 
SELECT COUNT(*) AS total_orders
FROM `flipkart sales dataset`;

-- PROBLEM STATEMENT 2 : Calculate the total sales value using Sale Price
-- Total sales value is 30037520
SELECT SUM(`Sale Price`) AS total_sales
FROM `flipkart sales dataset`;

-- PROBLEM STATEMENT 3 : Find the average sale price per order
-- Average Sales price per order is 224.9951
SELECT AVG(`Sale Price`) AS avg_sale_price
FROM `flipkart sales dataset`;

-- PROBLEM STATEMENT 4 : Display the minimum, maximum, and average unit price
-- The minimum, maximum and average unit price is 50, 150 and 99.9192 respectively 
SELECT 
    MIN(`Unit Price`) AS min_price,
    MAX(`Unit Price`) AS max_price,
    AVG(`Unit Price`) AS avg_price
FROM `flipkart sales dataset`;

-- PROBLEM STATEMENT 5 : Count how many orders were returned vs delivered
-- Orders that are returned are 36036 and delivered are 97467
SELECT Status, COUNT(*) AS order_count
FROM `flipkart sales dataset`
GROUP BY Status;

-- SECTION 2 CUSTOMER INSIGHTS 

-- PROBLEM STATEMENT 1 : Find the total number of unique customers
-- There are 112933 unique customers 
SELECT COUNT(DISTINCT CustomerID) AS unique_customers
FROM `flipkart sales dataset`;
 
-- PROBLEM STATEMENT 2 : Show the gender-wise order count
-- Gender-Wise Order Count : M - 68815 and F - 64688
SELECT  `Customer Gender`,
		COUNT(*) AS 'order_count'
FROM `flipkart sales dataset`
GROUP BY `Customer Gender`;

-- PROBLEM STATEMENT 3 : Find the average customer age
-- Average Age is 35.9301
SELECT AVG(`Customer Age`) AS 'avg_age'
FROM `flipkart sales dataset`; 

-- PROBLEM STATEMENT 4 : Count how many customers belong to each age group (below 25, 25–40, above 40)
-- Above 40 - 42491, Below 25 - 21026, 25-40 - 69986
SELECT 
CASE 
	WHEN `Customer Age` < 25 THEN 'Below 25'
	WHEN `Customer Age` BETWEEN 25 AND 40  THEN '25-40'
	ELSE 'Above 40'
END AS age_group,
COUNT(*) AS 'total_customers'
FROM `flipkart sales dataset`
GROUP BY age_group;

-- PROBLEM STATEMENT 5 : Find the oldest and youngest customer
-- Oldest - 87 AND Youngest - 17
SELECT 
    MIN(`Customer Age`) AS youngest,
    MAX(`Customer Age`) AS oldest
FROM `flipkart sales dataset`;

-- SECTION 3 PRODUCT & CATEGORY 

-- PROBLEM STATEMENT 1 : Display the total number of product categories
-- There are 5 Product Category 
SELECT COUNT(DISTINCT(`Product Category`)) AS 'Total Number of Product Categories'
FROM `flipkart sales dataset`;

-- PROBLEM STATEMENT 2 : Show how many orders belong to each product category
/*
Product Category    orders
Fashion	            39432
Health and beauty	42447
Phones and Tablet	21244
Electronics	        12187
Home and Office	    18193
*/
SELECT `Product Category`, COUNT(*) AS orders
FROM `flipkart sales dataset`
GROUP BY `Product Category`;

-- PROBLEM STATEMENT 3 : Find the top 5 most ordered products by quantity
/*
Product 												total_quantity
Avon Soft Musk Eau de Toilette Spray - 50ml	       			 17331
Fashion 4-Piece Leather HandBag Set - Black	       			 17128
Triple Power C20 Super Bass USB Bluetooth Subwoofer
- Brown + free S530 V4.0 Bluetooth Headset - Black			 17098
Heat Resistant Glass Storage Bowl - 15 Pieces
Multicolour													 17051
Yazole Leather Wrist Watch - Black							 17042
*/
SELECT  Product, 
		SUM(`Order Quantity`) AS total_quantity
FROM `flipkart sales dataset`
GROUP BY Product
ORDER BY total_quantity DESC
LIMIT 5;

-- PROBLEM STATEMENT 4 : List all products that were returned
/*
Product
Fashion Girl's Dress Kids Children Newborn Baby Dinner Party Princess Dress Ball Gown
Blood Pressure Monitor Digital Wrist BP Pulse Monitor Meter Heart Rate Measure
Triple Power C20 Super Bass USB Bluetooth Subwoofer - Brown + free S530 V4.0 Bluetooth Headset - Black
Amazon Fire HD 8 Kids Tablet 32GB HDD - 2GB RAM - 8" Blue"
Avon Soft Musk Eau de Toilette Spray - 50ml
Maze Batik Designed 3D Wallpaper - 10M - White/Black
Fashion Girls' Patent Leather Stitching Shoes - Black
Muscle Stimulators - Abdominal Muscle Trainer Set - Fitness
Trust Leather Buckle Shoes - Black
8 Cubes Plastic Wardrobe - Blue/White
6030 3.1 Bluetooth Home Theatre With Remote Control - Black + Free Smartwatch
B5 HiFi 5.0 Ture Wireless Headsets Auto Pair Touch - Black
Boys Sneakers Casual Kids Sports Shoes-Gold
Aichun Beauty Eight Pack Essential Oil - 30ml
Vida Divina TeDivina (Detox Tea Formula) - 1 Tea Bag
Yazole Analog Quartz Wrist Watch - Black
Fashion 4-Piece Leather HandBag Set - Black
Sports Pants - Black
Canon EOS 60D CMOS DSLR Camera Bundle - 18 - 55mm Lens - Black
Short Sleeve Polo Shirt - Royal Blue
Clere Avocado Milk Body Lotion With Vitamins E+A - 400ml
Plastic Storage Bowl - 17 Pieces Green
Lindy 12 Cubes Wardrobe 8 Doors - Brown
L A Girl Pro Coverage HD Illuminating Liquid Foundation - Coffee
Optimum Nutrition Creatine Sports - 5000mg per Daily Serve Powder
Cq Amaigrissant Slimming Tea - 20 Tea Bags
Canon EOS 600D 18MP CMOS DSLR Camera - Black
Potluck Lunch Box - Brown
Infinix Smart HD X612 (2021) - 32GB HDD - 2GB RAM - Black
Samsung Galaxy A02 - 64GB HDD - 3GB RAM Smartphone - Black
Leather Vintage Bracelet Watch - Black
Portable Blood Pressure Monitor - White
Fashion Boys Sneakers Children Outdoor Shoes-Black
Yazole Leather Wrist Watch - Black
Heat Resistant Glass Storage Bowl - 15 Pieces Multicolour
100%Cotton 4 Piece Short Sleeve T-Shirts - Multicolour
Slip On Leather Sneakers - Black
M4 Smart Bracelet Sports Pedometer Watch
Hemani Ultra Slim Tea - 10 Bags
Fragrance World Smart Black Eau de Parfum Spray - 100ml
voice blood Pressure Monitor Digital BP Pulse Health Vascular Heartbeat Test
Clere Radiance Oil Control Toner - 100ml
Samsung A3 Core Dual SIM - 16GB HDD - 1GB RAM - Blue
10.1'' Business Tablet with MT6582 Quad-Core Processor
*/
SELECT DISTINCT Product 
FROM `flipkart sales dataset`
WHERE `Status` = 'Returned';

-- PROBLEM STATEMENT 5 : Find the average unit price per product category
/*
Product Category					 avg_unit_price
Fashion									99.8305
Health and beauty						99.7775
Phones and Tablet						100.2454
Electronics								100.3857
Home and Office							99.7486
*/
SELECT  `Product Category`,
		AVG(`Unit Price`) AS 'avg_unit_price'
FROM `flipkart sales dataset`
GROUP BY `Product Category`;

-- 2. ANALYTICAL QUESTIONS

-- SECTION 4 REVENUE & PERFORMANCE 

-- PROBLEM STATEMENT 1 : Calculate total revenue per product category
/*
Product Category				 total_revenue
Phones and Tablet					4777918
Home and Office						4092845
Health and beauty					9561335
Fashion								8861364
Electronics							2744058
*/
SELECT  `Product Category`,
		SUM(`Sale Price`) AS 'total_revenue'
FROM `flipkart sales dataset`
GROUP BY `Product Category`;

-- PROBLEM STATEMENT 2 : Find the top 5 products by total sales value
/*
Product 																				total_sales
Heat Resistant Glass Storage Bowl - 15 Pieces Multicolour									691046
Short Sleeve Polo Shirt - Royal Blue														691031
Canon EOS 600D 18MP CMOS DSLR Camera - Black												690399
Avon Soft Musk Eau de Toilette Spray - 50ml													689927
6030 3.1 Bluetooth Home Theatre With Remote Control - Black + Free Smartwatch				689497
*/
SELECT `Product`,
		SUM(`Sale Price`) AS 'total_sales'
FROM `flipkart sales dataset`
GROUP BY `Product`
ORDER BY total_sales DESC
LIMIT 5;

-- PROBLEM STATEMENT 3 : Identify products with high quantity but low total revenue 
-- Assuming High Quantity > 10,000 and Low Revenue < 7,00,000
-- There are 42 products having qty > 10000 and revenue < 700000
SELECT  `Product`,
		SUM(`Order Quantity`) AS 'qty',
        SUM(`Sale Price`) AS 'revenue'
FROM `flipkart sales dataset`
GROUP BY `Product`
HAVING qty > 10000 AND revenue < 700000;

-- PROBLEM STATEMENT 4 : Find the average order value per customer
SELECT  CustomerID, 
		AVG(`Sale Price`) AS avg_order_value
FROM `flipkart sales dataset`
GROUP BY CustomerID;

-- PROBLEM STATEMENT 5 : Show monthly sales trends using OrderDate
/*
month 	 sales
1		2724863
2		2413476
3		2688238
4		2922225
5		3053224
6		2276577
7		2357824
8		2310086
9		2290469
10		2357401
11		2265617
12		2377520
*/
SELECT  MONTH(`OrderDate`) AS 'month',
		SUM(`Sale Price`) AS 'sales'
FROM `flipkart sales dataset`
GROUP BY MONTH(`OrderDate`)
ORDER BY `month`;

-- SECTION 5 RETURNS ANALYSIS 

-- PROBLEM STATEMENT 1 : Calculate the return rate (%) for all orders
-- return_rate is 26.99265
SELECT 
		COUNT(CASE WHEN Status='Returned' THEN 1 END)*100.0 / COUNT(*) AS return_rate
FROM `flipkart sales dataset`;

-- PROBLEM STATEMENT 2 : Find the most common return reasons
/*
Reason 							total_returns
Delivey - Missing item/part			7125
Quality-Defective item				7114
Delivery-Wrong item					6955
Onsite -Description mismatch		6895
Product - Not fitting expectation	6892
No Reason Specified					1055
*/
SELECT  Reason, 
		COUNT(*) AS total_returns
FROM `flipkart sales dataset`
WHERE `Status`='Returned'
GROUP BY Reason
ORDER BY total_returns DESC;

-- PROBLEM STATEMENT 3 : Identify products with the highest number of returns
/* 
Product											 return_count
Blood Pressure Monitor Digital Wrist 
BP Pulse Monitor Meter Heart Rate Measure			1067
*/
SELECT  `Product`,
		COUNT((CASE WHEN `Status` = 'Returned' THEN 1 END)) AS 'number_of_returns'
FROM `flipkart sales dataset`
GROUP BY `Product`
ORDER BY number_of_returns DESC;

SELECT Product, COUNT(*) AS return_count
FROM `flipkart sales dataset`
WHERE Status='Returned'
GROUP BY Product
ORDER BY return_count DESC;

-- PROBLEM STATEMENT 4 : Find which delivery type has the highest return rate
/*
Delivery Type 						   return_rate
Express									26.27742
Standard Delivery						23.89531
Shipped from Abroad						30.79143

The Product which are delivered through Expresshave highest return rate
*/
SELECT  `Delivery Type`,
		COUNT(CASE WHEN Status='Returned' THEN 1 END)*100.0/COUNT(*) AS return_rate
FROM `flipkart sales dataset`
GROUP BY `Delivery Type`;

-- PROBLEM STATEMENT 5 : Show category-wise return percentage
/*
Product Category 			   return_rate
Fashion							27.01867
Health and beauty				27.35647
Phones and Tablet				26.07324
Electronics						26.50365
Home and Office					27.48859
*/
SELECT  `Product Category`,
		COUNT(CASE WHEN Status='Returned' THEN 1 END)*100.0/COUNT(*) AS return_rate
FROM `flipkart sales dataset`
GROUP BY `Product Category`;

-- SECTION 6 DELIVERY & LOGISTICS 

-- PROBLEM STATEMENT 1 : Compare average delivery duration between delivery types
/*
Delivery Type 			   avg_days
Express						3.4961
Standard Delivery			9.9930
Shipped from Abroad			15.0049
*/
SELECT  `Delivery Type`,
		AVG(DATEDIFF(`Delivery Date`, OrderDate)) AS avg_days
FROM `flipkart sales dataset`
GROUP BY `Delivery Type`;

-- PROBLEM STATEMENT 2 : Find which delivery type generates higher sales
/*
Delivery Type 				 sales
Shipped from Abroad			10056328
Standard Delivery			10040529
Express						 9940663

The Product which are shipped from abroad generates highest sales
*/
SELECT  `Delivery Type`,
		SUM(`Sale Price`) AS 'sales'
FROM `flipkart sales dataset`
GROUP BY `Delivery Type`
ORDER BY sales DESC;

-- PROBLEM STATEMENT 3 : Identify zones with the highest number of delayed deliveries
/*
Zone 			  delayed_deliveries
Zone 3					57607
Zone 1					33575
Zone 2					24611
Zone 4					17710

Zone 3 have the highest number of delayed deliveries
*/
SELECT 
    Zone,
    COUNT(*) AS delayed_deliveries
FROM `flipkart sales dataset`
GROUP BY Zone
ORDER BY delayed_deliveries DESC;

-- PROBLEM STATEMENT 4 : Calculate average shipping fee per zone
/*
Zone 				avg_shipping_fee
Zone 4					11.5425
Zone 2					11.5061
Zone 3					11.4964
Zone 1					11.4618
*/
SELECT  Zone,
		AVG(`Shipping Fee`) AS 'avg_shipping_fee'
FROM `flipkart sales dataset`
GROUP BY Zone
ORDER BY avg_shipping_fee DESC;

-- PROBLEM STATEMENT 5 : Find orders where shipping fee is unusually high compared to sale price
-- There is no product which have shipping fee greater than sale price 
SELECT 
    OrderID,
    Product,
    `Sale Price`,
    `Shipping Fee`,
    (`Shipping Fee` / `Sale Price`) AS shipping_ratio
FROM `flipkart sales dataset`
WHERE `Shipping Fee` > `Sale Price`
ORDER BY shipping_ratio DESC;

-- Shipping fee is more than 50% of sale price
SELECT 
    OrderID,
    Product,
    `Sale Price`,
    `Shipping Fee`
FROM `flipkart sales dataset`
WHERE `Shipping Fee` > 0.5 * `Sale Price`;

-- 3. INSIGHT-DRIVEN QUESTIONS

-- SECTION 7 CUSTOMER BEHAVIOR 

-- PROBLEM STATEMENT 1 : Identify repeat customers (customers with more than 1 order)
-- There are 300 customers with more than 1 order
SELECT  CustomerID,
		COUNT(*) AS 'customers_count'
FROM `flipkart sales dataset`
GROUP BY CustomerID
HAVING customers_count > 1
ORDER BY customers_count DESC;

-- PROBLEM STATEMENT 2 : Find customers who frequently return products
-- There are 300 Customers who frequently return products (CustomerID 230500375,230514199 have returned the product 4 times)
SELECT  CustomerID,
		COUNT(*) AS 'customers_returned_product'
FROM `flipkart sales dataset`
WHERE Status = 'Returned'
GROUP BY CustomerID
ORDER BY customers_returned_product DESC;

-- PROBLEM STATEMENT 3 : Calculate lifetime value (LTV) of each customer
SELECT 
    CustomerID,
    SUM(`Sale Price`) AS lifetime_value
FROM `flipkart sales dataset`
GROUP BY CustomerID
ORDER BY lifetime_value DESC;

-- PROBLEM STATEMENT 4 : Find customers who ordered from multiple product categories
-- There are 39 customers who ordered from multiple product categories 
SELECT CustomerID
FROM `flipkart sales dataset`
GROUP BY CustomerID
HAVING COUNT(DISTINCT `Product Category`) > 1;

-- PROBLEM STATEMENT 5 : Segment customers based on purchase value (Low, Medium, High)
-- Assuming total_sales < 100 AS 'LOW', BETWEEN 100 AND 500 AS 'MEDIUM' AND ABOVE 500 AS 'HIGH'
SELECT  CustomerID,
		SUM(`Sale Price`) AS 'total_sales',
CASE
    WHEN SUM(`Sale Price`) < 100 THEN 'Low'
    WHEN SUM(`Sale Price`) BETWEEN 100 AND 500 THEN 'Medium'
    ELSE 'High'
END AS segment
FROM `flipkart sales dataset`
GROUP BY CustomerID;

-- SECTION 8 PRODUCT QUALITY & RATING 

-- PROBLEM STATEMENT 1 : Find products with average rating below 3
-- There are 44 product with average rating below 3 
SELECT  Product,
		AVG(Rating) AS 'avg_rating'
FROM `flipkart sales dataset`
GROUP BY Product
HAVING avg_rating < 3;

-- PROBLEM STATEMENT 2 : Analyze the relationship between returns and ratings
/*
Status 			  avg_rating
Returned			2.0030
Delivered			2.9992
*/
SELECT  Status,
		AVG(Rating) AS 'avg_rating'
FROM `flipkart sales dataset`
GROUP BY Status;

-- PROBLEM STATEMENT 3 : Identify categories with high returns but low ratings
/*
Product Category 		   avg_rating
Fashion						2.7293
Health and beauty			2.7202
Phones and Tablet			2.7529
Electronics					2.7257
Home and Office				2.7325
*/
SELECT `Product Category`,
		AVG(Rating) AS 'avg_rating'
FROM `flipkart sales dataset`
GROUP BY `Product Category`
HAVING 'avg_rating' < 3
AND COUNT(CASE WHEN Status='Returned' THEN 1 END) > 5;

-- PROBLEM STATEMENT 4 : Find products that were returned despite high ratings
-- There are 300 Products that were returned despite high ratings 
SELECT Product
FROM `flipkart sales dataset`
WHERE Status='Returned' AND Rating >= 3;

-- PROBLEM STATEMENT 5 : Show rating distribution for returned vs non-returned orders
/*
Status 	  Rating    count
Returned	2		12157
Delivered	3		19404
Delivered	1		19611
Returned	1		11886
Delivered	5		19520
Delivered	4		19518
Delivered	2		19414
Returned	3		11993
*/
SELECT  Status, 
		Rating, 
        COUNT(*) AS count
FROM `flipkart sales dataset`
GROUP BY Status, Rating;

-- SECTION 9 GEOGRAPHY & ZONES

-- PROBLEM STATEMENT 1 : Find zone-wise total sales
/*
Zone       total_sales
Zone 3		12962489
Zone 1		7561445
Zone 2		5532994
Zone 4		3980592
*/
SELECT  Zone,
		SUM(`Sale Price`) AS 'total_sales'
FROM `flipkart sales dataset`
GROUP BY Zone
ORDER BY total_sales DESC;

-- PROBLEM STATEMENT 2 : Identify the best-performing zone in terms of revenue
/*
Zone       total_sales
Zone 3		12962489
*/
SELECT  Zone,
		SUM(`Sale Price`) AS 'total_sales'
FROM `flipkart sales dataset`
GROUP BY Zone
ORDER BY total_sales DESC
LIMIT 1;

-- PROBLEM STATEMENT 3 : Compare return rates across locations
SELECT Location,
COUNT(CASE WHEN Status='Returned' THEN 1 END)*100.0/COUNT(*) AS return_rate
FROM `flipkart sales dataset`
GROUP BY Location;

-- PROBLEM STATEMENT 4 : Find which zones prefer Express vs Standard Delivery
SELECT Zone, `Delivery Type`, COUNT(*) AS orders
FROM `flipkart sales dataset`
GROUP BY Zone, `Delivery Type`;

-- PROBLEM STATEMENT 5 : Identify zones with high shipping cost but low sales
-- There ia no zone which have average shipping cost greater than the average sales prices
SELECT Zone
FROM `flipkart sales dataset`
GROUP BY Zone
HAVING AVG(`Shipping Fee`) > AVG(`Sale Price`);

-- SECTION 10 PROFITABILITY & OPTIMIZATION 

-- PROBLEM STATEMENT 1 : Estimate net revenue (Sale Price − Shipping Fee)
-- the net revenue is 28502822
SELECT SUM(`Sale Price` - `Shipping Fee`) AS net_revenue
FROM `flipkart sales dataset`;

-- PROBLEM STATEMENT 2 : Identify products where shipping cost is more than 10% of sale price
-- There are 300 records where the shipping cost is more than 10% of sale price
SELECT *
FROM `flipkart sales dataset`
WHERE `Shipping Fee` > (`Sale Price` * 0.10);

-- PROBLEM STATEMENT 3 : Find loss-making orders due to returns and shipping costs 
-- There is no records where there is loss-making orders due to returns and shipping costs 
SELECT *
FROM `flipkart sales dataset`
WHERE Status='Returned' AND `Shipping Fee` > `Sale Price`;

-- PROBLEM STATEMENT 4 : Suggest which products should be discontinued based on returns & ratings
-- There are 44 products having rating less than 3 and product return greater than 1000 
SELECT Product
FROM `flipkart sales dataset`
GROUP BY Product
HAVING AVG(Rating) < 3
AND COUNT(CASE WHEN Status='Returned' THEN 1 END) > 1000;

-- PROBLEM STATEMENT 5 : Identify high-revenue but high-return risk products
-- There are 10 products whose revenue is greater than 5000 and reurn of product greater than 1000
SELECT Product
FROM `flipkart sales dataset`
GROUP BY Product
HAVING SUM(`Sale Price`) > 5000
AND COUNT(CASE WHEN Status='Returned' THEN 1 END) > 1000;

-- SECTION 11 TIME BASED INSIGHTS 

-- PROBLEM STATEMENT 1 : Find peak order dates
SELECT OrderDate, COUNT(*) AS orders
FROM `flipkart sales dataset`
GROUP BY OrderDate
ORDER BY orders DESC;

-- PROBLEM STATEMENT 2 : Analyze weekday vs weekend sales performance
/*
day_type     sales
Weekend		8571768
Weekday		21465752
*/
SELECT 
CASE 
    WHEN DAYOFWEEK(OrderDate) IN (1,7) THEN 'Weekend'
    ELSE 'Weekday'
END AS day_type,
SUM(`Sale Price`) AS sales
FROM `flipkart sales dataset`
GROUP BY day_type;

-- PROBLEM STATEMENT 3 : Identify months with highest return rates
-- The highest return rate is in the month of March having the return rate as 28.42%
SELECT  MONTHNAME(OrderDate) AS month, 
		COUNT(CASE WHEN Status='Returned' THEN 1 END)*100.0/COUNT(*) AS return_rate
FROM `flipkart sales dataset`
GROUP BY month
ORDER BY return_rate DESC;

-- PROBLEM STATEMENT 4 : Compare customer spending trends over time
SELECT  OrderDate, 
		SUM(`Sale Price`) AS daily_sales
FROM `flipkart sales dataset`
GROUP BY OrderDate;

-- PROBLEM STATEMENT 5 : Detect seasonal demand patterns by category
SELECT  MONTHNAME(OrderDate) AS month, 	
		`Product Category`,
		SUM(`Order Quantity`) AS demand
FROM `flipkart sales dataset`
GROUP BY  month, 	
		  `Product Category`;
