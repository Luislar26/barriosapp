CREATE TABLE barrios_informales (
  id_barrio char[3] PRIMARY KEY,
  nombre_barrio varchar[40],
  cant_familias decimal(5:0),
  cant_habitantes decima(7:0),
  sup_barrio decimal(5,2),
  sup_por_habitante decimal(5,2),
  agua_porc decimal(5,2),
  elec_porc decimal(5,2),
  cloaca_porc decimal(5,2),
  residuos_porc decimal(5,2),
  desagues_porc decimal(5,2),
  red_vial_porc decimal(5,2),
  veredas_porc decimal(5,2),
  alumbrado_porc decimal(5,2),
  grado_consol decimal(5,2),
  seguridad boolean,
  salud boolean,
  educacion boolean,
  deportivo boolean,
  equipamiento boolean,
  id_riezgo char[2]
);

CREATE TABLE nivel_riesgo (
  id_riezgo char[1] PRIMARY KEY,
  class varchar[15]
);

CREATE TABLE barrios_nivel_riezgo (
  id_barrio char[3],
  id_riezgo char[1],
  sup_afectada decimal(7,0),
  PRIMARY KEY (id_barrio, id_riezgo),
  FOREIGN KEY (id_barrio) REFERENCES barrios_informales (id_barrio),
  FOREIGN KEY (id_riezgo) REFERENCES nivel_riesgo (id_riezgo)
);

CREATE TABLE barrios_intrumentos (
  id_barrio char[3],
  num_ley varchar[10],
  anio_ley integer,
  id_organismo char[3],
  id_estado_intrumento char[3],
  PRIMARY KEY (id_barrio, num_ley),
  FOREIGN KEY (id_barrio) REFERENCES barrios_informales (id_barrio),
  FOREIGN KEY (id_organismo) REFERENCES organismos (id_organismo),
  FOREIGN KEY (id_estado_intrumento) REFERENCES estado_intrumento (id_intrumento),
  FOREIGN KEY (id_barrio) REFERENCES barrio_catastro (id_barrio)
);

CREATE TABLE leyes_parcelas_urbana_expropiadas (
  num_ley varchar[10] PRIMARY KEY,
  anio_ley integer,
  id_intrumento char[1],
  documento_ley varchar[10],
  organismo_expropia varchar[40],
  organismo_construye varchar[40],
  gastos varchar[40],
  ley_anterior varchar[10],
  observaciones varchar[100],
  FOREIGN KEY (num_ley) REFERENCES barrios_intrumentos (num_ley),
  FOREIGN KEY (id_intrumento) REFERENCES tipos_intrumentos (id_intrumento)
);

CREATE TABLE parcelas_expropidadas_leyes (
  num_ley varchar[10] PRIMARY KEY,
  id_dominio char[3],
  id_parc varchar[28],
  cod_dept char[2],
  circunscripcion char[3],
  seccion char[2],
  chacra char[4],
  quinta char[4],
  fraccion char[4],
  mzna char[4],
  parcela char[5],
  folio_numero char[15],
  superficie float,
  unidad_superficie varchar[15],
  observaciones varchar[100],
  FOREIGN KEY (num_ley) REFERENCES leyes_parcelas_urbana_expropiadas (num_ley)
);

CREATE TABLE departamentos (
  cod_dept char[2] PRIMARY KEY,
  departamento varchar[40],
  FOREIGN KEY (cod_dept) REFERENCES parcelas_expropidadas_leyes (cod_dept)
);

CREATE TABLE dominio_tierra (
  id_dominio char[2] PRIMARY KEY,
  denomincacion varchar[30],
  FOREIGN KEY (id_dominio) REFERENCES parcelas_expropidadas_leyes (id_dominio)
);

CREATE TABLE estado_intrumento (
  id_intrumento char[3] PRIMARY KEY,
  estado varchar[30]
);

CREATE TABLE tipos_intrumentos (
  id_intrumento char[1] PRIMARY KEY,
  denomincacion varchar[30]
);

CREATE TABLE organismos (
  id_organismo char[3] PRIMARY KEY,
  denomincacion varchar[30]
);

CREATE TABLE barrio_catastro (
  id_barrio integer,
  id_parc varchar[28],
  sup_parcial decimal(7,2),
  PRIMARY KEY (id_barrio, id_parc)
);

CREATE TABLE catastro (
  id_parc varchar[28] PRIMARY KEY,
  cod_dept char[2],
  circunscripcion char[3],
  seccion char[2],
  chacra char[4],
  quinta char[4],
  fraccion char[4],
  mzna char[4],
  parcela char[5],
  observaciones varchar[100],
  FOREIGN KEY (id_parc) REFERENCES barrio_catastro (id_parc)
);


