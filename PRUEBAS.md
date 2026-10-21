# Registro de pruebas

Este documento se utilizara para validar el sistema experto desde la URL desplegada. Los resultados deben registrarse despues de publicar la aplicacion y deben coincidir con las consultas directas realizadas en SWI-Prolog.

## Datos de la ejecucion

| Campo | Valor |
|---|---|
| Fecha | 2026-10-20 |
| URL publica | Pendiente |
| Rama probada | `dev` |
| Navegador | Pendiente |
| Dispositivo | Pendiente |
| Responsable | Pendiente |
| Version o commit | `4d6c58c` |

## Criterios de estado

- **Pendiente:** la prueba aun no se ejecuta.
- **Aprobada:** el resultado coincide con lo esperado.
- **Fallida:** el resultado no coincide o aparece un error.
- **Bloqueada:** no puede ejecutarse por una dependencia o configuracion.

## Casos de prueba

| ID | Escenario | Entrada | Resultado esperado | Resultado obtenido | Estado | Evidencia |
|---|---|---|---|---|---|---|
| P01 | Producto valido con existencias bajas | ID 1 | Devuelve reposicion critica y decisiones compatibles | Falla `json_write_string/2` | Fallida | Consola local |
| P02 | Producto valido con existencias suficientes | ID 2 | Devuelve una recomendacion de inventario | Falla `json_write_string/2` | Fallida | Consola local |
| P03 | Producto de alta rotacion | ID 3 | Devuelve decisiones relacionadas con acceso y reposicion | Falla `json_write_string/2` | Fallida | Consola local |
| P04 | Producto fragil | ID 4 | Incluye una instruccion de empaque | Falla `json_write_string/2` | Fallida | Consola local |
| P05 | Producto voluminoso | ID 5 | Incluye ubicacion o movimiento para volumen | Falla `json_write_string/2` | Fallida | Consola local |
| P06 | Producto refrigerado | ID 6 | Incluye una ubicacion fria | Falla `json_write_string/2` | Fallida | Consola local |
| P07 | Producto con prioridad alta | ID 7 | Incluye despacho expedito | Falla `json_write_string/2` | Fallida | Consola local |
| P08 | Producto con datos incompletos | ID 8 | Devuelve estado `invalid` | Falla `json_write_string/2` | Fallida | Consola local |
| P09 | Producto con datos invalidos | ID 9 | Devuelve estado `invalid` y el error correspondiente | Falla `json_write_string/2` | Fallida | Consola local |
| P10 | Producto inexistente | ID 99 | Devuelve estado `error` sin fallar el servicio | Falla `json_write_string/2` | Fallida | Consola local |

## Backtracking

Consulta directa en SWI-Prolog:

```prolog
ubicacion(13, Resultado).
```

Registrar todas las soluciones obtenidas al presionar `;`:

| Consulta | Soluciones obtenidas | Coincide con la API | Evidencia |
|---|---|---|---|
| `movimiento(11, Resultado).` | Manipulacion, empaque y despacho expedito | Pendiente | Consola local |

## Comparacion local y desplegada

| Caso | Resultado local | Resultado desplegado | Coinciden | Evidencia |
|---|---|---|---|---|
| P01 | Pendiente | Pendiente | Pendiente | Pendiente |
| P04 | Pendiente | Pendiente | Pendiente | Pendiente |
| P06 | Pendiente | Pendiente | Pendiente | Pendiente |
| P08 | Pendiente | Pendiente | Pendiente | Pendiente |
| P10 | Pendiente | Pendiente | Pendiente | Pendiente |

## Evidencias

Guardar las capturas o respuestas exportadas en una carpeta como `docs/evidencias/` y completar esta lista:

- [ ] Interfaz desplegada.
- [ ] Consulta valida.
- [ ] Consulta con multiples recomendaciones.
- [ ] Datos incompletos.
- [ ] Valores invalidos.
- [ ] Producto inexistente.
- [ ] Consulta directa en SWI-Prolog.
- [ ] Backtracking.
- [ ] Acceso desde otro dispositivo.

## Incidencias

| ID | Descripcion | Causa | Solucion | Estado |
|---|---|---|---|---|
| I01 | `json_write_string/2` no existe en SWI-Prolog | Adaptador JSON sin predicado disponible | Pendiente de correccion por el equipo | Abierta |

## Nota sobre Vercel

La interfaz puede desplegarse en Vercel, pero el backend debe ejecutarse en un entorno que pueda iniciar SWI-Prolog. Antes de marcar las pruebas como aprobadas, confirmar que la API publica realmente ejecuta `ALMACEN.pl` y no una respuesta simulada.