--PRACTICA 7
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 22/03/22
--DESCRIPCION: Practicar la identificacion de indices y donde estos deben ser creados.

--PONER EN USO LA BD
USE NORTHWIND;

---1. VERIFIQUE CUANTOS INDICE TIENE CADA TABLA, INDICANDO EL NOMBRE Y PORQUE CAMPOS ESTAN HECHOS CADA INDICE.
EXECUTE sp_helpindex Categories;
/*
	NOMBRE: CategoryName
	CAMPO: CategoryName

	NOMBRE: PK_Categories
	CAMPO: CategoryID
*/
EXECUTE sp_helpindex CustomerCustomerDemo;
/*
	NOMBRE: PK_CustomerCustomerDemo
	CAMPO: CustomerID, CustomerTypeID
*/
EXECUTE sp_helpindex CustomerDemographics;
/*
	NOMBRE: PK_CustomerDemographics
	CAMPO: CustomerTypeID
*/
EXECUTE sp_helpindex Customers;
/*
	NOMBRE: City
	CAMPO: City

	NOMBRE: CompanyName
	CAMPO: CompanyName

	NOMBRE: PK_Customers
	CAMPO: CustomerID

	NOMBRE: PostalCode
	CAMPO:PostalCode

	NOMBRE: Region
	CAMPO: Region
*/
EXECUTE sp_helpindex Employees;
/*
	NOMBRE: LastName
	CAMPO: LastName

	NOMBRE: PK_Employees
	CAMPO: EmployeeID

	NOMBRE: PostalCode
	CAMPO: PostalCode
*/
EXECUTE sp_helpindex EmployeeTerritories;
/*
	NOMBRE: PK_EmployeeTerritories
	CAMPO: EmployeeID, TerritoryID
*/
EXECUTE sp_helpindex [Order Details];
/*
	NOMBRE: OrderID
	CAMPO: OrderID

	NOMBRE: OrdersOrder_Details
	CAMPO: OrderID

	NOMBRE: PK_Order_Details
	CAMPO: OrderID, ProductID

	NOMBRE: ProductID
	CAMPO: ProductID

	NOMBRE: ProductsOrder_Details
	CAMPO: ProductID
*/
EXECUTE sp_helpindex Orders;
/*
	NOMBRE: CustomerID
	CAMPO: CustomerID

	NOMBRE: CustomersOrders
	CAMPO: CustomerID
	
	NOMBRE: EmployeeID
	CAMPO: EmployeeID 

	NOMBRE: EmployeesOrders
	CAMPO: EmployeeID

	NOMBRE: OrderDate
	CAMPO: OrderDate

	NOMBRE: PK_Orders
	CAMPO: OrderID

	NOMBRE: ShippedDate
	CAMPO: ShippedDate

	NOMBRE: ShippersOrders
	CAMPO: ShipVia

	NOMBRE: ShipPostalCode
	CAMPO: ShipPostalCode
*/
EXECUTE sp_helpindex Products;
/*
	NOMBRE: CategoriesProducts
	CAMPO: CategoryID

	NOMBRE: CategoryID
	CAMPO: CategoryID

	NOMBRE: PK_Products
	CAMPO: ProductID

	NOMBRE: ProductName
	CAMPO: ProductName

	NOMBRE: SupplierID
	CAMPO: SupplierID

	NOMBRE: SuppliersProducts
	CAMPO: SupplierID
*/
EXECUTE sp_helpindex Region;
/*
	NOMBRE: PK_Region
	CAMPO: RegionID
*/
EXECUTE sp_helpindex Shippers;
/*
	NOMBRE: PK_Shippers
	CAMPO: ShipperID 
*/
EXECUTE sp_helpindex Suppliers;
/*
	NOMBRE: CompanyName
	CAMPO: CompanyName

	NOMBRE: PK_Suppliers
	CAMPO: SupplierID

	NOMBRE: PostalCode
	CAMPO: PostalCode
*/
EXECUTE sp_helpindex Territories;
/*
	NOMBRE: PK_Territories
	CAMPO: TerritoryID
*/


---2. SUGIERA SI LES FALTA ALGUN INDICE A LA TABLA, DE QUE TIPO Y PORQUE CAMPOS.
/*
TABLA: Customers
TIPO: INDICE NONCLUSTERED:
CAMPO: ContactName
*/

/*
TABLA: Employees
TIPO: INDICE NONCLUSTERED:
CAMPO: FirstName
*/

/*
TABLA: Orders
TIPO: INDICE NONCLUSTERED:
CAMPO: ShipCity

TABLA: Orders
TIPO: INDICE NONCLUSTERED:
CAMPO: ShipCountry
*/

/*
TABLA: Products
TIPO: INDICE NONCLUSTERED:
CAMPO: UnitsInStock

TABLA: Products
TIPO: INDICE NONCLUSTERED:
CAMPO: Discontinued
*/

/*
TABLA: Suppliers
TIPO: INDICE NONCLUSTERED:
CAMPO: Country
*/