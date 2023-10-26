CREATE DATABASE  IF NOT EXISTS `actividades`;
USE `actividades`;


DROP TABLE IF EXISTS `almacenes`;
CREATE TABLE `almacenes` (
  `CODIGO` int NOT NULL,
  `LUGAR` varchar(255) NOT NULL,
  `CAPACIDAD` int NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `almacenes` VALUES (1,'Valencia',3),(2,'Barcelona',4),(3,'Bilbao',7),(4,'Los Angeles',2),(5,'San Francisco',8);


DROP TABLE IF EXISTS `fabricantes`;
CREATE TABLE `fabricantes` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fabricantes` VALUES (1,'Sony'),(2,'Creative Labs'),(3,'Hewlett-Packard'),(4,'Iomega'),(5,'Fujitsu'),(6,'Winchester');


DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRECIO` decimal(10,0) NOT NULL,
  `FABRICANTE` int NOT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `FABRICANTE` (`FABRICANTE`),
  CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`FABRICANTE`) REFERENCES `fabricantes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `articulos` VALUES (1,'Hard drive',240,5),(2,'Memory',120,6),(3,'ZIP drive',150,4),(4,'Floppy disk',5,6),(5,'Monitor',240,1),(6,'DVD drive',180,2),(7,'CD drive',90,2),(8,'Printer',270,3),(9,'Toner cartridge',66,3),(10,'DVD burner',180,2);


DROP TABLE IF EXISTS `cajas`;
CREATE TABLE `cajas` (
  `NUMREFERENCIA` varchar(255) NOT NULL,
  `CONTENIDO` varchar(255) NOT NULL,
  `VALOR` double NOT NULL,
  `ALMACEN` int NOT NULL,
  PRIMARY KEY (`NUMREFERENCIA`),
  KEY `ALMACEN` (`ALMACEN`),
  CONSTRAINT `cajas_ibfk_1` FOREIGN KEY (`ALMACEN`) REFERENCES `almacenes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cajas` VALUES ('0MN7','Rocks',180,3),('4H8P','Rocks',250,1),('4RT3','Scissors',190,4),('7G3H','Rocks',200,1),('8JN6','Papers',75,1),('8Y6U','Papers',50,3),('9J6F','Papers',175,2),('LL08','Rocks',140,4),('P0H6','Scissors',125,1),('P2T6','Scissors',150,2),('TU55','Papers',90,5);


DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRESUPUESTO` decimal(10,0) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `departamentos` VALUES (14,'IT',65000),(37,'Accounting',15000),(59,'Human Resources',240000),(77,'Research',55000);


DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `DNI` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `APELLIDOS` varchar(255) NOT NULL,
  `DEPARTAMENTO` int NOT NULL,
  PRIMARY KEY (`DNI`),
  KEY `DEPARTAMENTO` (`DEPARTAMENTO`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `empleados` VALUES (123234877,'Michael','Rogers',14),(152934485,'Anand','Manikutty',14),(222364883,'Carol','Smith',37),(326587417,'Joe','Stevens',37),(332154719,'Mary-Anne','Foster',14),(332569843,'George','O\'Donnell',77),(546523478,'John','Doe',59),(631231482,'David','Smith',77),(654873219,'Zacary','Efron',59),(745685214,'Eric','Goldsmith',59),(845657233,'Luis','López',14),(845657245,'Elizabeth','Doe',14),(845657246,'Kumar','Swamy',14),(845657266,'Jose','Pérez',77);


DROP TABLE IF EXISTS `peliculas`;
CREATE TABLE `peliculas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `CALIFICACIONEDAD` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `peliculas` VALUES (1,'Citizen Kane','PG'),(2,'Singin\' in the Rain','G'),(3,'The Wizard of Oz','G'),(4,'The Quiet Man',NULL),(5,'North by Northwest',NULL),(6,'The Last Tango in Paris','NC-17'),(7,'Some Like it Hot','PG-13'),(8,'A Night at the Opera',NULL),(9,'Citizen King','G');


DROP TABLE IF EXISTS `salas`;
CREATE TABLE `salas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PELICULA` int DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `PELICULA` (`PELICULA`),
  CONSTRAINT `salas_ibfk_1` FOREIGN KEY (`PELICULA`) REFERENCES `peliculas` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `salas` VALUES (1,'Odeon',5),(2,'Imperial',1),(3,'Majestic',NULL),(4,'Royale',6),(5,'Paraiso',3),(6,'Nickelodeon',NULL);

/* Todos los where codigo > 0 són para no quitar el modo seguro de sql */
/*
Ejercicio 1
*/
select nombre from articulos;
select nombre, precio from articulos;
select nombre from articulos where precio <= 200;
select * from articulos where precio between 60 and 120;
select nombre, precio, precio * 166.386 as 'precio en pesetas' from articulos;
select avg(precio) as 'Precio Medio' from articulos;
select avg(precio) as 'Precio Medio' from articulos where fabricante = 2;
select count(codigo) from articulos where precio >= 180;
select nombre, precio from articulos where precio >= 180 order by precio desc, nombre asc;
select * from articulos a inner join fabricantes f on a.fabricante = f.codigo; 
select a.nombre, a.precio, f.nombre as 'nombre fabricante' from articulos a inner join fabricantes f on a.fabricante = f.codigo;
select avg(precio), fabricante from articulos group by fabricante; 
select f.nombre as 'nombre fabricante' from articulos a join fabricantes f on a.fabricante = f.codigo group by fabricante having avg(precio) >= 150; 
select nombre, precio from articulos where precio = (select min(precio) from articulos);
select a.nombre, a.precio, f.nombre from articulos a join fabricantes f on a.fabricante = f.codigo where a.fabricante = f.codigo AND a.precio = (SELECT max(atv.precio) FROM articulos atv WHERE atv.fabricante = f.codigo);
insert into articulos(codigo, precio, nombre, fabricante) values (11, 70,'Altavoces',2);
update articulos set nombre = 'Impresora Laser' where codigo = 8;
update articulos set precio = precio * 0.9 where codigo > 0;
update articulos set precio = precio - 10 where codigo > 0;

/*
Ejercicio 2
*/

select apellidos from empleados;
select distinct(apellidos) from empleados;
select * from empleados where apellidos = 'Smith';
select * from empleados where apellidos = 'Smith' or apellidos = 'Rogers';
select * from empleados where departamento = 14;
/* En el enunciado pone para el 37 y para el 77 asi que supongo que tienen que trabajar en ambos a la vez, de no ser ese el caso sería un or en vez de un and */
select * from empleados where departamento = 77 and departamento = 37;
select * from empleados where apellidos like 'P$';
select sum(presupuesto) as 'Presupuesto total' from departamentos;
select count(dni) as 'empleados por departamento', departamento from empleados group by (departamento);
select * from empleados e join departamentos d on e.departamento = d.codigo;
select e.nombre as 'nombre empleado', apellidos, d.nombre, d.presupuesto from empleados e join departamentos d on e.departamento = d.codigo;
select e.nombre as 'nombre', apellidos from empleados e join departamentos d on e.departamento = d.codigo where presupuesto > 60000;
select * from departamentos where presupuesto > (select avg(presupuesto)from departamentos);
select nombre from departamentos where 2 < (select count(dni) from empleados where departamento = codigo); 
insert into departamentos values(11,'Calidad',40000);
insert into empleados values(89267109,'Esther','Vázquez',11);
update departamentos set presupuesto = presupuesto * 0.9 where codigo > 0;
update empleados set departamento = 14 where departamento = 77;
delete from empleados where departamento = 14;
/* no me deja hacerlo por el safe mode, pero supongo que sería algo así pero quitando el dni like */
delete from empleados e where dni like '$' and (select presupuesto from departamentos where codigo = departamento) > 60000;
/* lo mismo que arriba */
delete from empleados;
 
/* Ejercicio 3 */

select * from almacenes;
select * from cajas where valor > 150;
select distinct(contenido) from cajas;
select avg(valor) from cajas;
select avg(valor) from cajas group by almacen;
select almacen from cajas group by almacen having avg(valor) > 150;
select numreferencia, lugar from cajas join almacenes on almacen = codigo;
select count(numreferencia) as 'cajas por almacen', almacen from cajas group by almacen;
select almacen from cajas group by almacen having count(numreferencia) > (select capacidad from almacenes where almacen = codigo); 
select numreferencia from cajas join almacenes on almacen = codigo where lugar = 'Bilbao';
insert into almacenes values (6,'Barcelona',3);
insert into cajas VALUES ('H5RT','Papel',200,2);
update cajas set valor = valor *0.85;
update cajas set valor = valor *0.80 where valor > (select avg(valor) from cajas);
delete from cajas where valor < 100;
/* Me estába dando error al ponerlo directamente, asi que he buscado el error y me ha salido que haciendo un select por encima, se resuelve, no sé el porque, pero así si funciona */
delete from cajas where almacen = (select num from (select codigo as num from almacenes a where capacidad < (select count(numreferencia) from cajas group by almacen having almacen = codigo)) as h);

/* Ejercicio 4 */

select nombre from peliculas;
select distinct(calificacionedad) from peliculas where calificacionedad is not null;
select * from peliculas where calificacionedad is null;
select * from salas where pelicula is null;
select s.codigo, s.nombre as 'nombre sala', ifnull(p.nombre, 'No hay pelicula') as 'nombre pelicula', calificacionedad from salas s left join peliculas p on pelicula = p.codigo;
select p.codigo, p.nombre as 'nombre sala', calificacionedad, ifnull(s.codigo, 'No tiene sala') as 'codigo sala', ifnull(s.nombre, 'No tiene sala') as 'nombre sala' 
from salas s right join peliculas p on pelicula = p.codigo;
select p.nombre from peliculas p join salas s on p.codigo = s.pelicula where s.pelicula is not null;
insert into peliculas values (10, 'Uno, Dos, Tres', 'PG-7');
update peliculas set calificacionedad = 'PG-13' where calificacionedad is null and codigo > 0;
delete from salas where pelicula = (select p.codigo from peliculas p where pelicula = p.codigo and calificacionedad = 'G') and salas.codigo > 0;
