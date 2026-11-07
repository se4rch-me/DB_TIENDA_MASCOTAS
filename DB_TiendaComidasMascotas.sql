drop database if exists tienda_mascotas;


create database if not exists tienda_mascotas;

Use tienda_mascotas;

create table marcas(
    id_marca INT AUTO_INCREMENT,
    nombre_marca VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id_marca)

);

CREATE TABLE clases_animales (
    id_clase INT AUTO_INCREMENT,
    nombre_clase VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY (id_clase)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT,
    codigo_barras VARCHAR(50) NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    stock_actual INT NOT NULL DEFAULT 0,
    id_marca INT NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_marca) REFERENCES marcas(id_marca)
);



CREATE TABLE productos_clases (
    id_producto INT NOT NULL,
    id_clase INT NOT NULL,
    PRIMARY KEY (id_producto, id_clase),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_clase) REFERENCES clases_animales(id_clase)
);



CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT,
    documento_identidad VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    rol ENUM('Cajero', 'Administrador') NOT NULL, 
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (id_empleado)
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT,
    documento_identidad VARCHAR(20) NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL DEFAULT 'Cliente General',
    telefono VARCHAR(20) NULL,
    correo VARCHAR(100) NULL,
    PRIMARY KEY (id_cliente)
);


CREATE TABLE cajas (
    id_caja INT AUTO_INCREMENT,
    numero_caja VARCHAR(10) NOT NULL UNIQUE,
    estado ENUM('Activa', 'Inactiva') NOT NULL DEFAULT 'Inactiva',
    PRIMARY KEY (id_caja)
);

CREATE TABLE sesiones_caja (
    id_sesion INT AUTO_INCREMENT,
    id_caja INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_hora_apertura DATETIME NOT NULL,
    monto_inicial DECIMAL(10,2) NOT NULL,
    fecha_hora_cierre DATETIME NULL,
    monto_final DECIMAL(10,2) NULL,
    PRIMARY KEY (id_sesion),
    FOREIGN KEY (id_caja) REFERENCES cajas(id_caja),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);


CREATE TABLE facturas (
    id_factura INT AUTO_INCREMENT,
    numero_factura VARCHAR(20) NOT NULL UNIQUE,
    fecha_hora DATETIME NOT NULL,
    id_cliente INT NOT NULL,
    id_sesion INT NOT NULL,
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_sesion) REFERENCES sesiones_caja(id_sesion)
);

CREATE TABLE detalles_factura (
    id_detalle INT AUTO_INCREMENT,
    id_factura INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_vendida INT NOT NULL,
    precio_unitario_historico DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_detalle),
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO marcas (nombre_marca) VALUES 
('Royal Canin'),
('Pro Plan'),
('Whiskas'),
('Mirringo'),
('Dog Chow');

INSERT INTO clases_animales (nombre_clase) VALUES 
('Perro'),
('Gato'),
('Ave'),
('Roedor');

INSERT INTO productos (codigo_barras, nombre, descripcion, precio_venta, stock_actual, id_marca) VALUES 
('7701234567891', 'Chuncky Cachorros 1KG', 'Comida concentrada para perros cachorros', 15000.00, 50, 5), 
('7701234567892', 'Pro Plan Gatos Esterilizados 3KG', 'Alimento premium para gatos capados', 85000.00, 20, 2),
('7701234567893', 'Whiskas Megamix Salmon 500G', 'Croquetas sabor salmón para gatos adultos', 12000.00, 100, 3),
('7701234567894', 'Royal Canin Club Performance 15KG', 'Bulto de alimento alta protección para perros adultos', 210000.00, 10, 1);

INSERT INTO productos_clases (id_producto, id_clase) VALUES 
(1, 1),
(2, 2), 
(3, 2), 
(4, 1); 

INSERT INTO empleados (documento_identidad, nombre, apellido, rol, activo) VALUES 
('1010202030', 'Carlos', 'Mendoza', 'Cajero', TRUE),
('1040505060', 'Ana', 'Martínez', 'Administrador', TRUE);

INSERT INTO clientes (documento_identidad, nombre, telefono, correo) VALUES 
(NULL, 'Cliente General', NULL, NULL),
('52345678', 'María López', '3157778899', 'maria.lopez@email.com'),
('79888999', 'Juan Pérez', '3001112233', 'juan.perez@email.com');

INSERT INTO cajas (numero_caja, estado) VALUES 
('CAJA-01', 'Activa'),
('CAJA-02', 'Inactiva');

INSERT INTO sesiones_caja (id_caja, id_empleado, fecha_hora_apertura, monto_inicial, fecha_hora_cierre, monto_final) VALUES 
(1, 1, '2026-11-06 08:00:00', 50000.00, NULL, NULL);

INSERT INTO facturas (numero_factura, fecha_hora, id_cliente, id_sesion, total) VALUES 
('FAC-00001', '2026-11-06 09:30:15', 2, 1, 42000.00);

INSERT INTO detalles_factura (id_factura, id_producto, cantidad_vendida, precio_unitario_historico) VALUES 
(1, 3, 2, 12000.00), 
(1, 1, 1, 15000.00);


SELECT * FROM empleados;

SELECT * FROM productos;

SELECT * FROM clientes;

SELECT * FROM sesiones_caja;

SELECT * FROM facturas;

DELETE FROM empleados
WHERE id_empleado = 2;

INSERT INTO facturas (numero_factura, fecha_hora, id_cliente, id_sesion, total) VALUES 
('FAC-00002', '2026-10-12 10:25:15', 3, 2, LLENAAAAAR );

INSERT INTO detalles_factura (id_factura, id_producto, cantidad_vendida, precio_unitario_historico) VALUES 
(2, 2, 2, 12000.00), -- 
(2, 4, 1, 15000.00); 