-- Consultas 
/*
 * 1 Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados.
 *  El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. 
 * El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor.
 *  El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.
 * 
 * */
use institucion;

select d.nombre , p.apellido1 , p.apellido2 , p.nombre 
from profesor p 
left join departamento d  on  d.id  = p.id_departamento
order by  d.nombre , p.apellido1 , p.apellido2 , p.nombre

-- 2 Devuelve un listado con los profesores que no están asociados a un departamento.


select p.id , p.nif , p.nombre , p.apellido1 , p.apellido2, p.ciudad ,p.direccion , p.telefono , p.fecha_nacimiento , p.sexo 
from profesor p 
left join departamento d  on  d.id  = p.id_departamento
where p.id_departamento  is NULL ;

-- 3 Devuelve un listado con los departamentos que no tienen profesores asociados.

select d.id , d.nombre 
from profesor p 
right join departamento d  on  d.id  = p.id_departamento
where p.id_departamento  is NULL ;

--  4 Devuelve un listado con los profesores que no imparten ninguna asignatura.

select  p.id , p.nif , p.nombre , p.apellido1 , p.apellido2, p.ciudad ,p.direccion , p.telefono , p.fecha_nacimiento , p.sexo, a.id 
from profesor p 
left join asignatura a  on a.id_profesor  = p.id 
where a.id_profesor  is null;

-- 5 Devuelve un listado con las asignaturas que no tienen un profesor asignado.

select   a.id , a.nombre , a.creditos , a.tipo , a.curso , a.cuatrimestre , a.id_profesor , a.id_grado 
from profesor p 
right join asignatura a  on a.id_profesor  = p.id 
where a.id_profesor  is null;


-- 6 Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. 
-- El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.


select d.nombre AS departamento, a.nombre AS asignatura
from  departamento d  
join profesor p  on  p.id_departamento  = d.id
join asignatura a  on  a.id_profesor  = p.id 
left join alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
where am.id_asignatura is null;

-- 7 Devuelve el número total de alumnas que hay.

select distinct  count(id)  as totalAlumnas
from alumno a 
where a.sexo  = "m";

-- 8 Calcula cuántos alumnos nacieron en 1999.

select distinct count(id)
from  alumno a 
where YEAR (a.fecha_nacimiento) = 1999;

 /* 
  *  9 Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento 
  * y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen 
  * profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
  * 
  * */
select d.nombre as departamento, count(p.id) as num_profesores
from departamento d
join profesor p on d.id = p.id_departamento
group by d.nombre
order by num_profesores DESC;



/* 10  Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. 
 * Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos 
 * también tienen que aparecer en el listado.*/

select d.nombre as departamento, count(p.id) as num_profesores
from departamento d
left join profesor p on d.id = p.id_departamento
group by d.nombre;

 /* 11 Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas 
  * que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados 
  * también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
  * */

select g.nombre as grado, COUNT(a.id) as num_asignaturas
from grado g
left join asignatura a on g.id = a.id_grado
group by g.nombre
order by num_asignaturas desc;

/* 12 Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno,
 *  de los grados que tengan más de 40 asignaturas asociadas.*/

select g.nombre as grado, COUNT(a.id) as num_asignaturas
from grado g
join asignatura a on g.id = a.id_grado
group by g.nombre
having num_asignaturas > 40;

/* 13 Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. 
 * El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas 
 * que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.*/

select g.nombre as grado, a.tipo, SUM(a.creditos) as total_creditos
from grado g
join asignatura a on g.id = a.id_grado
group by g.nombre, a.tipo
order by total_creditos desc;


/* 14 Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. 
 * El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos 
 * matriculados.*/
 
select c.anyo_inicio as año_inicio, count(distinct am.id_alumno) as num_alumnos_matriculados
from curso_escolar c
left join alumno_se_matricula_asignatura am ON c.id = am.id_curso_escolar
group by c.anyo_inicio
order by c.anyo_inicio;

/* 
  15 Devuelve un listado con el número de asignaturas que imparte cada profesor. 
  El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. 
  El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas.
  El resultado estará ordenado de mayor a menor por el número de asignaturas.
 * */

select p.id, p.nombre, p.apellido1, p.apellido2, count(a.id) as num_asignaturas
from profesor p
left join asignatura a on p.id = a.id_profesor
group by p.id, p.nombre, p.apellido1, p.apellido2
order by num_asignaturas desc;

 -- 16 Devuelve todos los datos del alumno más joven.

select *  
from alumno  
order by fecha_nacimiento DESC  
limit 1;


-- 17 Devuelve un listado con los profesores que no están asociados a un departamento.

select p.id , p.nif , p.nombre , p.apellido1 , p.apellido2, p.ciudad ,p.direccion , p.telefono , p.fecha_nacimiento , p.sexo 
from profesor p 
left join departamento d  on  d.id  = p.id_departamento
where p.id_departamento  is NULL ;

-- 18 Devuelve un listado con los departamentos que no tienen profesores asociados.

select d.id , d.nombre 
from profesor p 
right join departamento d  on  d.id  = p.id_departamento
where p.id_departamento  is NULL ;


-- 19 Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.

select p.id, p.nombre, p.apellido1, p.apellido2, d.nombre as departamento
from profesor p
join departamento d on p.id_departamento = d.id
left join asignatura a on p.id = a.id_profesor
where a.id is null;


-- 20 Devuelve un listado con las asignaturas que no tienen un profesor asignado.

select   a.id , a.nombre , a.creditos , a.tipo , a.curso , a.cuatrimestre , a.id_profesor , a.id_grado 
from profesor p 
right join asignatura a  on a.id_profesor  = p.id 
where a.id_profesor  is null;
