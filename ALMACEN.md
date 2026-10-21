# Sistema experto del almacen

## Problema

El sistema apoyara al personal de un almacen a tomar decisiones sobre la ubicacion, reposicion y movimiento de productos. La recomendacion dependera de datos como categoria, existencias, rotacion, prioridad, fragilidad, volumen y condiciones de almacenamiento.

## Usuario objetivo

Personal encargado de recibir productos, revisar inventario, preparar pedidos y decidir que acciones requieren atencion.

## Consultas previstas

- Identificar productos que requieren reposicion.
- Recomendar una ubicacion compatible con las caracteristicas del producto.
- Detectar productos que necesitan atencion prioritaria.
- Encontrar productos que pueden agruparse en una misma zona.
- Mostrar varias acciones posibles para un producto.

## Datos de entrada

La interfaz solicitara datos controlados, por ejemplo:

- Categoria del producto.
- Cantidad disponible.
- Nivel de rotacion.
- Nivel de prioridad.
- Fragilidad.
- Volumen.
- Requiere refrigeracion.
- Zona disponible.

## Resultados

Cada consulta podra devolver una o varias recomendaciones con una explicacion de las condiciones que se cumplieron. Cuando los datos sean insuficientes, la interfaz debera solicitar los campos faltantes. Si no existe una recomendacion compatible, debera comunicarlo claramente.

## Modulos

```text
conocimiento   Datos elaborados por el equipo
inferencia     Reglas elaboradas por el equipo
consultas      Consultas publicas del sistema
api            Validacion y comunicacion HTTP
interfaz       Captura y presentacion
pruebas        Casos y resultados
```

## Limite academico

Este documento define el dominio, pero no contiene hechos, reglas ni predicados Prolog. La base de conocimiento y el razonamiento logico deben ser elaborados, comprendidos y modificados autonomamente por el equipo.

## Primeros casos de prueba

El equipo documentara como minimo los siguientes escenarios:

1. Producto con existencias bajas.
2. Producto con existencias suficientes.
3. Producto de alta rotacion.
4. Producto fragil.
5. Producto voluminoso.
6. Producto que requiere refrigeracion.
7. Producto con prioridad alta.
8. Datos incompletos.
9. Valores no validos.
10. Consulta con varias recomendaciones.