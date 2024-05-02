--switching into courier_Management database 
use Courier_Management;

--creating user table
create table [user] 
(userId int primary key,
Name VARCHAR(245),
Email VARCHAR(245) UNIQUE,
Password VARCHAR(240),
ContactNumber VARCHAR(20),
Address TEXT );

--creating courier table

create table Courier (
CourierID INT PRIMARY KEY,
EmployeeID INT,
UserID INT,
ServiceID INT,
SenderName VARCHAR(255),
SenderAddress TEXT,
ReceiverName VARCHAR(255),
ReceiverAddress TEXT,
Weight DECIMAL(5, 2),
Status VARCHAR(50),
TrackingNumber VARCHAR(20) UNIQUE,
DeliveryDate DATE,
foreign key (employeeId) references employee(employeeId),
foreign key (userId) references [user](userId),
foreign key (serviceId) references [CourierServices](serviceId)
);

--creating courierServices table
create table CourierServices (
ServiceID INT PRIMARY KEY,
ServiceName VARCHAR(100),
Cost DECIMAL(8, 2)
);

--creating employee table 
CREATE TABLE EMPLOYEE 
(EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(255),
Email VARCHAR(255) UNIQUE,
ContactNumber VARCHAR(20),
Role VARCHAR(50),
Salary DECIMAL(10, 2));

--CREATING LOCATION TABLE
CREATE TABLE [LOCATION](
LocationID INT IDENTITY(1,1) PRIMARY KEY,
LocationName VARCHAR(100),
Address TEXT
); 

--CREATING PAYMENT TABLE 
CREATE TABLE PAYMENT(
PaymentID INT IDENTITY(1,1) PRIMARY KEY,
UserID INT,
CourierID INT,
LocationId INT,
Amount DECIMAL(10, 2),
PaymentDate DATE,
FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
foreign key (userId) references [user](userId)
);


--inserting values into user table

insert into [user] values(1, 'April Kepner', 'april.kepner@example.com', 'password123', '163-056-7890', '19 church St, Greenville, 09'),
(2, 'Derek', 'derek.l@example.com', 'abc123', '587-604-3210', '78-0 keye St, Costa Rica, POK'),
(3, 'Shivani', 'shivani.a@example.com', 'pass123', '955-055-9155', '09 Sai Nagar, Chennai, 091'),
(4, 'Joe', 'joe.r@example.com', 'secufefpass', '181-272-3833', '456 Maduravayal, chennai, 095'),
(5, 'Kiruba', 'kiruba.w@example.com', 'jfnrty', '444-444-4444', '78 T.V.K, TVM, OL9');

--inserting values into courier table
INSERT INTO Courier
VALUES
(1,1,2,3,'April Kepner', '19 church St, Greenville, 09', 'Ria', '567 brinda nagar', 17, 'In transit', 'POff909989', '2024-04-28'),
(2,3,5,1, 'Derek', '78-0 keye St, Costa Rica, POK', 'Grace kyle', '456 vine St,San Jose', 10, 'Pending', 'LP987654321', NULL),
(3,1,2,4, 'Shivani',  '09 Sai Nagar, Chennai, 091', 'Aditya', '999 Urapakkam, Guduvancheri', 18, 'Delivered', 'SAK567890100', '2024-04-19'),
(4,5,3,2, 'Joe', '456 Maduravayal, Chennai, 095', 'Karpagam', '31 apple St, HermsVille', 9, 'Delivered', 'KUK987654331', '2024-04-11'),
(5,4,3,1, ' Kiruba',  '78 T.V.K nagar, TVM, OL9', 'Gaya', '99 Munusammy nagar, Thiruvallur', 5, 'Not Delivered', 'TRK567890123', NULL)
;

--inserting values into employee table
insert into employee values('John Smith', 'john.smith@example.com', '123-456-7890', 'Software Engineer', 7000.00),
('Jennifer Adams', 'jennifer.adams@example.com', '234-567-8901', 'Accountant', 5000.00),
('Michael Davis', 'michael.davis@example.com', '345-678-9012', 'Customer Support Specialist', 4500.00),
('Jessica Wilson', 'jessica.wilson@example.com', '456-789-0123', 'Project Manager', 65000.00),
('Daniel Thompson', 'daniel.thompson@example.com', '567-890-1234', 'Sales Representative', 4800.00)


--inserting values into courier services table 
insert into CourierServices values 
(1, 'Standard Shipping', 100.00),
(2, 'Express Shipping', 900.00),
(3, 'Overnight Shipping', 3000.00),
(4, 'International Economy', 7005.00),
(5, 'International Standard', 4565.00);

--inserting values into location table
insert into location values 
('Office Lane 1', '19 Chruch St, Greenville, 09'),
('Lane 2', '78-0 keye St, Costa Rica, POK'),
('Lane 3', '09 Sai Nagar, Chennai, 091'),
('Warehouse', '456 Maduravayel, Chennai, 095'),
('Service stock room', '78 T.V.K, TVM, OL9');

--inserting values into payment table
insert into payment values
(1,2, 1, 5000.00, '2024-04-20'),
(2,3, 2, 3005.75, '2023-04-24'),
(3,1, 2, 7000.25, '2024-04-26'),
(4,4, 3, 450.50, '2024-04-01'),
(5, 5,5, 40.20, '2024-04-28');



--task2 question

--1 List all customers: 
select * from [user];

--2 List all orders for a specific customers
select * from courier where SenderName = 'April Kepner';

--3 list all couriers 
select * from courier;

--4 List all packages for a specific order:
select * from courier
where TrackingNumber = 'POff909989';

--5.List all deliveries for a specific courier;
select * from courier 
where Status = 'Delivered';

--6 List all undelivered packages
select * from Courier 
where Status = 'Not Delivered';

--7 List all packages that are scheduled for delivery today
select * from Courier 
where DeliveryDate = GETDATE();

--8 List all packages with a specific status:
select * from courier 
where status ='In Transit';

--9 Calculate the total number of courier for each courierservice.
SELECT 
    CourierServices.ServiceID,
    CourierServices.ServiceName,
    COUNT(Courier.CourierID) AS TotalCouriers
FROM 
    CourierServices
LEFT JOIN 
    Courier ON CourierServices.ServiceID = Courier.ServiceID
GROUP BY 
    CourierServices.ServiceID, CourierServices.ServiceName;


--.10 Find the average delivery time for each courier 
select c.courierID, AVG(DATEDIFF(DAY, P.PaymentDate, C.DeliveryDate)) AS AverageDelivery from Courier C
join Payment P on C.CourierID = P.CourierID
group by C.CourierID;

--11 List all packages with a specific weight range: 
select * from courier 
where weight between 10 and 20;

--12 Retrieve employees whose names contain 'Jennifer Adams'
select * from EMPLOYEE 
where [Name] like '%Jennifer Adams%';

--13.Retrieve all courier records with payments greater than $50. 
select CourierID,Amount from payment 
WHERE Amount >=5000;



--task 3 questions

--14. Find the total number of couriers handled by each employee.
select e.employeeId,count(courierId) as totalCouriers from courier c 
join employee e 
on c.employeeId=e.employeeId 
group by e.employeeId;

--15. Calculate the total revenue generated by each location
select locationName , sum(amount) as totalRevenue from payment p
join location l 
on p.LocationId=l.LocationID 
group by p.LocationId,LocationName;

--16. Find the total number of couriers delivered to each location. 
select l.LocationName, COUNT(c.CourierID) AS TotalCouriersDelivered from Location l
join payment p
on l.LocationID = p.LocationId
join Courier c on p.CourierID=c.CourierID
where c.Status = 'delivered'
group by l.LocationID,l.LocationName;

--17. Find the courier with the highest average delivery time: 
select top 1 c.courierID, AVG(DATEDIFF(DAY, P.PaymentDate, C.DeliveryDate)) AS AverageDelivery from Courier C
join Payment P on C.CourierID = P.CourierID
group by C.CourierID 
order by AverageDelivery desc;

--18. Find Locations with Total Payments Less Than a Certain Amount
select l.LocationID,l.LocationName, SUM(Amount) as TotalPayments from Payment p
join [LOCATION] l 
on l.LocationID=p.locationId
group by l.LocationID ,l.LocationName
having SUM(Amount) < 780;

--19. Calculate Total Payments per Location 
select l.LocationID,l.LocationName, SUM(Amount) as TotalPayments from Payment p
join [LOCATION] l 
on l.LocationID=p.locationId
group by l.LocationID ,l.LocationName
having SUM(Amount) < 780;

--20 Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X):
select CourierID from Payment
where LocationID = 3
group by CourierID
having SUM(Amount) > 1000;

--21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'):
select CourierID
from Payment
where PaymentDate > '2024-04-02'
group by CourierID
having SUM(Amount) > 1000;

--22. Retrieve locations where the total amount received is more than $5000 before a certain date (PaymentDate > 'YYYY-MM-DD') 
select LocationID
from Payment
where PaymentDate < '2024-04-02'
group by LocationID
having SUM(Amount) > 5000;

--TASK 4 

--23. Retrieve Payments with Courier Information 
select * from payment p 
join courier c 
on p.courierId = c.courierId;

--24. Retrieve Payments with Location Information 
select * from payment p 
join location l 
on p.LocationId = l.LocationID;

--25. Retrieve Payments with Courier and Location Information
select * from payment p 
join location l 
on p.locationId = l.locationId 
join courier c 
on p.CourierID = l.LocationID;

--26. List all payments with courier details
select * from payment p 
join Courier c 
on p.CourierID = c.CourierID;

--27. Total payments received for each courier 
select p.CourierID,sum(amount) as totalPaymets from payment p
join Courier c
on p.courierId = c.CourierID
group by p.CourierID;

--28. List payments made on a specific date 
select * from payment 
where PaymentDate = '2024-04-26';

--29. Get Courier Information for Each Payment 
select * from courier c 
right join payment p
on p.CourierID=c.CourierID

--30. Get Payment Details with Location 
select * from payment p
left join location l
on p.LocationId=l.LocationID;

--31. Calculating Total Payments for Each Courier
select p.courierId,sum(amount) as totalPayments from payment p
join courier c 
on p.CourierID = c.CourierID
group by p.CourierID;

--32. List Payments Within a Date Range 
select * from PAYMENT
where PaymentDate between '2021-02-12' and '2023-05-12';

--33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side 
select * from [user] u 
full outer join courier c 
on u.[Name] = c.SenderName;

--34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side 
SELECT *
FROM Courier C
FULL OUTER JOIN CourierServices CS ON C.ServiceID = CS.ServiceID;


--35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side  

SELECT
    Employee.EmployeeID,
    Employee.Name AS EmployeeName,
    Payment.PaymentID,
    Payment.Amount,
    Payment.PaymentDate
FROM
    Employee 
FULL OUTER JOIN courier C ON C.EmployeeID = employee.EmployeeID
full outer join payment  ON payment.CourierID =C.CourierID;



--36. List all users and all courier services, showing all possible combinations.
select * from [user] u 
cross join courier c;

--37. List all employees and all locations, showing all possible combinations:
select * from employee 
cross join LOCATION;

--38. Retrieve a list of couriers and their corresponding sender information (if available)
select * from courier c
join [user] u 
on c.SenderName = u.[Name];

--39.Retrieve a list of couriers and their corresponding receiver information (if available):
select * from Courier c
join [user] u 
on c.ReceiverName = u.[Name];

--40.Retrieve a list of couriers along with the courier service details (if available): 
SELECT *
FROM Courier C
LEFT JOIN CourierServices CS ON C.ServiceID = CS.ServiceID;

--41. Retrieve a list of employees and the number of couriers assigned to each employee:
select e.[Name],c.courierId from employee e 
join Courier c
on e.EmployeeID = c.employeeId;

--42. Retrieve a list of locations and the total payment amount received at each location:
select l.LocationID,l.LocationName, SUM(Amount) as TotalPayments from Payment p
join [LOCATION] l 
on l.LocationID=p.locationId
group by l.LocationID ,l.LocationName;

--43. Retrieve all couriers sent by the same sender (based on SenderName).
select * from courier 
where SenderName = 'April Kepner';

--44. List all employees who share the same role.
select * , RANK() over (partition by [role] order by [Name]) as [Role] from EMPLOYEE;

--45. Retrieve all payments made for couriers sent from the same location.
select * from payment p 
join [location] l
on p.LocationId=l.LocationID
where LocationName = '19 Chruch St, Greenville, 09';

--46. Retrieve all couriers sent from the same location (based on SenderAddress). 
select * from courier c 
join [LOCATION] l
on c.SenderAddress = l.LocationName;

--47. List employees and the number of couriers they have delivered:
select * from employee e 
join courier c
on e.EmployeeID = c.employeeId
where [Status] = 'Delivered';

--48. Find couriers that were paid an amount greater than the cost of their respective courier services 
SELECT c.*
FROM Courier c
JOIN CourierServices cs ON c.ServiceID = cs.ServiceID
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > cs.Cost;


--49. Find couriers that have a weight greater than the average weight of all couriers
select * from courier where [weight] > (select avg(weight) from courier);

--50. Find the names of all employees who have a salary greater than the average salary:\
select [Name] from employee where salary > (select Avg(Salary) from employee);

--51. Find the total cost of all courier services where the cost is less than the maximum cost

SELECT SUM(Cost) AS TotalCost
FROM CourierServices
WHERE Cost < (SELECT MAX(Cost) FROM CourierServices);

--52. Find all couriers that have been paid for 
select * from courier c
join payment p
on c.CourierID = p.CourierID;

--53. Find the locations where the maximum payment amount was made 
select top 1 LocationName,amount 
from [Location] l 
join PAYMENT p 
on p.LocationId = l.LocationID
order by Amount desc;

--54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender
select max(weight) as MaxWeight from courier where SenderName = 'Shivani';
