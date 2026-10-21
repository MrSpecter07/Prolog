:- use_module(library(http/json)).

% base_datos productos.
producto(1, 'Leche Saborizada Pequena', 5, media, normal, estandar, refrigerado, media).
producto(2, 'Arroz Integral 1kg', 150, media, normal, estandar, seco, baja).
producto(3, 'Bebida Energetica', 80, alta, normal, estandar, seco, media).
producto(4, 'Copas de Vidrio', 40, baja, fragil, estandar, seco, media).
producto(5, 'Colchon Matrimonial', 12, baja, normal, voluminoso, seco, media).
producto(6, 'Salmon Fresco Premium', 20, alta, normal, estandar, refrigerado, alta).
producto(7, 'Medicamento Oncologico', 8, alta, normal, estandar, refrigerado, alta).
producto(8, 'Producto Incompleto', sin_datos, alta, normal, estandar, seco, media).
producto(9, 'Error de Registro', -5, alta, normal, estandar, seco, critica).
producto(10, 'Atun en Lata', 45, alta, normal, estandar, seco, baja).
producto(11, 'Televisor 55 Pulgadas', 15, baja, fragil, voluminoso, seco, alta).
producto(12, 'Helado de Vainilla', 60, alta, normal, estandar, refrigerado, media).
producto(13, 'Espejo de Pared', 8, baja, fragil, voluminoso, seco, media).
producto(14, 'Aceite de Oliva', 200, media, normal, estandar, seco, baja).
producto(15, 'Carne de Res', 14, alta, normal, estandar, refrigerado, alta).
producto(16, 'Harina de Trigo', 0, alta, normal, estandar, seco, alta).
producto(17, 'Lampara de Techo', 25, media, fragil, estandar, seco, media).
producto(18, 'Ropero Desarmable', 3, baja, normal, voluminoso, seco, baja).
producto(19, 'Yogurt Natural', 9, alta, normal, estandar, refrigerado, baja).
producto(20, 'Galleton de Avena', 500, alta, normal, estandar, seco, baja).

% validacion datos.
es_invalido(ID, 'ERROR: Datos incompletos (campos sin_datos)') :-
    producto(ID, _, Ex, Rot, Emp, Vol, Amb, Pri),
    (Ex == sin_datos; Rot == sin_datos; Emp == sin_datos; Vol == sin_datos; Amb == sin_datos; Pri == sin_datos).

es_invalido(ID, 'ERROR: Las existencias no pueden ser negativas') :-
    producto(ID, _, Ex, _, _, _, _, _),
    number(Ex), Ex < 0.

es_invalido(ID, 'ERROR: Parametros fuera de catalogo estandar') :-
    producto(ID, _, _, Rot, Emp, Vol, Amb, Pri),
    (\+ member(Rot, [alta, media, baja]);
     \+ member(Emp, [normal, fragil]);
     \+ member(Vol, [estandar, voluminoso]);
     \+ member(Amb, [seco, refrigerado]);
     \+ member(Pri, [alta, media, baja])).

% reglas de_ubicacion.
ubicacion(ID, 'ZONA FRÍA: Almacenar inmediatamente en cámara de refrigeración') :-
    producto(ID, _, _, _, _, _, refrigerado, _).

ubicacion(ID, 'ZONA DE VOLUMÉNICOS: Asignar racks pesados o espacio directo en piso') :-
    producto(ID, _, _, _, _, voluminoso, _, _).

ubicacion(ID, 'ZONA DE ALTA ACCESIBILIDAD: Ubicar cerca de las puertas de despacho (Picking rápido)') :-
    producto(ID, _, _, alta, _, estandar, seco, _).

ubicacion(ID, 'ZONA ESTÁNDAR: Ubicar en racks generales de pasillo central') :-
    producto(ID, _, _, media, normal, estandar, seco, _).

ubicacion(ID, 'ZONA DE RESGUARDO: Ubicar en niveles inferiores con protección anticaídas') :-
    producto(ID, _, _, baja, fragil, estandar, seco, _).

% reglas de_reposicion.
reposicion(ID, 'ALERTA CRÍTICA: Stock en ruptura o crítico. Emitir orden de compra prioritaria') :-
    producto(ID, _, Ex, _, _, _, _, _),
    number(Ex), Ex >= 0, Ex < 10.

reposicion(ID, 'REPOSICIÓN ESTÁNDAR: Programar reorden en el próximo ciclo semanal') :-
    producto(ID, _, Ex, alta, _, _, _, _),
    number(Ex), Ex >= 10, Ex =< 30.

reposicion(ID, 'STOCK SALUDABLE: No se requieren acciones de compra actualmente') :-
    producto(ID, _, Ex, alta, _, _, _, _),
    number(Ex), Ex > 30.

reposicion(ID, 'MONITOREO BISEMANAL: Revisar niveles en el siguiente corte programado') :-
    producto(ID, _, Ex, Rot, _, _, _, _),
    member(Rot, [media, baja]),
    number(Ex), Ex >= 10.

% reglas de_movimiento.
movimiento(ID, 'MANIPULACIÓN: Requiere operador certificado y montacargas de alta capacidad') :-
    producto(ID, _, _, _, _, voluminoso, _, _).

movimiento(ID, 'EMPAQUE: Utilizar cajas con amortiguación y etiquetado de FRÁGIL') :-
    producto(ID, _, _, _, fragil, _, _, _).

movimiento(ID, 'DESPACHO EXPEDITO: Procesar orden mediante canal de Envíos Express (Garantizar SLA)') :-
    producto(ID, _, _, _, _, _, _, alta).

movimiento(ID, 'LOGÍSTICA INVERSA: Evaluar remate o devolución (Baja rotación estancada)') :-
    producto(ID, _, Ex, baja, _, _, _, baja),
    number(Ex), Ex > 50.

movimiento(ID, 'FLUJO ESTÁNDAR: Manipulación normal FIFO (Primeras entradas, primeras salidas)') :-
    producto(ID, _, _, media, normal, estandar, _, media).

% adaptador json.
obtener_json_decisiones(ID, JSON) :-
    \+ producto(ID, _, _, _, _, _, _, _),
    with_output_to(string(JSON), json_write(current_output, json([status=error, message='ERROR: El ID de producto no existe en el sistema']))).

obtener_json_decisiones(ID, JSON) :-
    producto(ID, _, _, _, _, _, _, _),
    findall(Err, es_invalido(ID, Err), Errores),
    Errores \= [],
    with_output_to(string(JSON), json_write(current_output, json([status=invalid, errors=Errores]))).

obtener_json_decisiones(ID, JSON) :-
    producto(ID, Nombre, Ex, Rot, Emp, Vol, Amb, Pri),
    \+ es_invalido(ID, _),
    findall(Ubi, ubicacion(ID, Ubi), Ubicaciones),
    findall(Rep, reposicion(ID, Rep), Reposiciones),
    findall(Mov, movimiento(ID, Mov), Movimientos),
    with_output_to(string(JSON), json_write(current_output, json([
        status=success,
        data=json([
            id=ID,
            nombre=Nombre,
            existencias=Ex,
            rotacion=Rot,
            empaque=Emp,
            volumen=Vol,
            ambiente=Amb,
            prioridad=Pri,
            ubicaciones=Ubicaciones,
            reposiciones=Reposiciones,
            movimientos=Movimientos
        ])
    ]))).

% interfaz consulta.
consultar_producto(ID) :-
    obtener_json_decisiones(ID, JSON),
    format('~w~n', [JSON]).
