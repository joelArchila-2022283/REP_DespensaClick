drop database if exists DB_DespensaClick_IN5CM;
create database DB_DespensaClick_IN5CM;
use DB_DespensaClick_IN5CM;

create table Proveedores( 
    id_proveedor int auto_increment not null, 
    nombre_proveedor varchar(60) not null, 
    telefono_proveedor int not null, 
    direccion varchar(100) not null, 
    email_proveedor varchar(100) not null, 
    primary key PK_id_proveedor(id_proveedor) 
); 

create table Empleados( 
    id_empleado int auto_increment not null, 
    nombre_empleado varchar(60) not null, 
    apellido_empleado varchar(60) not null, 
    puesto_empleado varchar(20) null, 
    email_empleado varchar(100) not null, 
    primary key PK_id_empleado(id_empleado) 
); 

create table Productos( 
    id_producto int auto_increment not null, 
    nombre_producto varchar(60) not null, 
    categoria_producto varchar(60) not null, 
    precio_compra double not null, 
    precio_venta double not null, 
    id_proveedor int not null, 
    primary key PK_id_producto(id_producto), 
    constraint FK_producto_proveedor foreign key (id_proveedor)  
    references Proveedores(id_proveedor) on delete cascade 
); 

create table Ventas( 
    id_venta int auto_increment not null, 
    fecha_venta date not null, 
    cantidad int not null, 
    total double not null, 
    id_empleado int not null, 
    id_producto int not null, -- Cambiado para apuntar a Productos
    primary key PK_id_venta(id_venta), 
    constraint FK_ventas_empleado foreign key (id_empleado)  
    references Empleados(id_empleado) on delete cascade, 
    constraint FK_ventas_producto foreign key (id_producto)  
    references Productos(id_producto) on delete cascade 
);


-- 1. PROVEEDORES (10 registros)
insert into Proveedores (nombre_proveedor, telefono_proveedor, direccion, email_proveedor) values 
('Lácteos Olán', 55443322, 'Km 20 Ruta al Atlántico', 'ventas@olan.com'),
('Corporación Abarrotera', 22110099, 'Zona 12, Ciudad', 'pedidos@corpabarr.com'),
('Limpieza Total', 77889966, 'Zona 4, Mixco', 'contacto@limpiezatotal.com'),
('Panadería El Trigal', 44556677, 'Avenida Elena 3-45', 'info@eltrigal.com'),
('Distribuidora Bebidas Ya', 33221100, 'Calzada Roosevelt', 'logistica@bebidasya.gt'),
('Carnes Selectas', 66554433, 'Mercado Central Local 5', 'ventas@carnesselectas.com'),
('Frutas y Verduras HN', 88991122, 'Central de Mayoreo', 'pedidos@fyvhn.com'),
('Empaques Diversos', 11223344, 'Parque Industrial Sur', 'empaques@diversos.com'),
('Especias del Mundo', 99887766, 'Zona 1, Centro Histórico', 'especias@mundo.com'),
('Avícola Real', 55664477, 'Granja El Retiro', 'contacto@avicolareal.com');

-- 2. EMPLEADOS (10 registros)
insert into Empleados (nombre_empleado, apellido_empleado, puesto_empleado, email_empleado) values 
('Ana', 'Ramírez', 'Gerente', 'aramirez@click.com'),
('Luis', 'Cano', 'Cajero', 'lcano@click.com'),
('Pedro', 'Méndez', 'Vendedor', 'pmendez@click.com'),
('Sofía', 'Estrada', 'Cajera', 'sestrada@click.com'),
('Jorge', 'Morales', 'Repartidor', 'jmorales@click.com'),
('Lucía', 'Gómez', 'Inventario', 'lgomez@click.com'),
('Mario', 'Duarte', 'Seguridad', 'mduarte@click.com'),
('Elena', 'Solís', 'Vendedora', 'esolis@click.com'),
('Roberto', 'Paz', 'Limpieza', 'rpaz@click.com'),
('Claudia', 'Vega', 'Subgerente', 'cvega@click.com');

-- 3. PRODUCTOS (10 registros)
insert into Productos (nombre_producto, categoria_producto, precio_compra, precio_venta, id_proveedor) values 
('Leche Entera 1L', 'Lácteos', 10.50, 14.00, 1),
('Arroz Blanco 2lb', 'Granos', 5.00, 8.50, 2),
('Detergente Multiusos', 'Limpieza', 12.00, 18.00, 3),
('Aceite Vegetal 900ml', 'Abarrotes', 15.00, 22.00, 2),
('Pan Integral pack', 'Panadería', 14.00, 20.00, 4),
('Agua Pura 5L', 'Bebidas', 8.00, 12.00, 5),
('Docena de Huevos', 'Granja', 11.00, 16.00, 10),
('Jabón de Manos', 'Higiene', 6.50, 10.00, 3),
('Pasta de Dientes', 'Higiene', 9.00, 13.50, 8),
('Café Molido 400g', 'Bebidas', 25.00, 38.00, 9);

-- 4. VENTAS (10 registros)
insert into Ventas (fecha_venta, cantidad, total, id_empleado, id_producto) values 
('2024-05-20', 2, 28.00, 2, 1),
('2024-05-20', 1, 8.50, 4, 2),
('2024-05-21', 3, 54.00, 2, 3),
('2024-05-21', 1, 22.00, 8, 4),
('2024-05-21', 2, 40.00, 4, 5),
('2024-05-22', 5, 60.00, 2, 6),
('2024-05-22', 1, 16.00, 8, 7),
('2024-05-23', 2, 20.00, 2, 8),
('2024-05-23', 1, 13.50, 4, 9),
('2024-05-23', 1, 38.00, 8, 10);

-- PROCEDIMIENTO ALMACENADOS

-- Procedimiento almacenado Listar
delimiter $$
	create procedure sp_ListarProductos()
    begin
		select p.id_producto, p.nombre_producto, p.categoria_producto, p.precio_compra, p.precio_venta, pr.nombre_proveedor from Productos p
        inner join Proveedores pr on p.id_proveedor = pr.id_proveedor;
    end $$
delimiter ;

-- Procedimeinto almacenado Crear
delimiter $$
	create procedure sp_AgregarProducto(
		in p_nombre varchar(60),
        in p_categoria varchar(60),
        in p_compra double,
        in p_venta double,
        in p_idProveedor int
    )
    begin
		insert into Productos (nombre_producto, categoria_producto, precio_compra, precio_venta, id_proveedor)values
        (p_nombre, p_categoria, p_compra, p_venta, p_idProveedor);
    end $$
delimiter ;

-- Procedimiento almacenado Actualizar
delimiter $$
	create procedure sp_ActualizarProducto(
		in p_id int,
        in p_nombre varchar(60),
        in p_categoria varchar(60),
        in p_compra double,
        in p_venta double,
        in p_idProveedor int
    )
    begin
		update Productos
        set nombre_producto = p_nombre, 
			categoria_producto = p_categoria,
			precio_compra = p_compra,
			precio_venta = p_venta,
			id_proveedor = p_idProveedor
        where id_producto = p_id;
    end $$
delimiter ;

-- Procedimiento almacenado Eliminar
delimiter $$
	create procedure sp_EliminarProducto(in p_id int)
    begin
		delete from Productos where id_producto = p_id;
    end $$
delimiter ;

-- call sp_ListarProductos();