# Sistema experto en Prolog

Proyecto integrador de la unidad de aprendizaje **Paradigmas de Programación** de la Escuela Superior de Cómputo, Instituto Politécnico Nacional.

## Propósito

Desarrollar y publicar una aplicación web cuyo motor de inferencia esté implementado en SWI-Prolog. El sistema atenderá una problemática cotidiana mediante hechos, reglas, consultas e inferencias que puedan ser revisadas directamente en Prolog y desde una interfaz web.

## Estado del proyecto

El repositorio se encuentra en la etapa inicial de documentación. La base de conocimientos y la selección definitiva del problema serán elaboradas por el equipo, de acuerdo con la restricción académica de no utilizar inteligencia artificial generativa para producir, completar o corregir el código lógico de los archivos `.pl`.

## Requisitos académicos

- Al menos 20 hechos significativos.
- Al menos 10 reglas lógicas no triviales.
- Al menos 5 predicados propios claramente diferenciados.
- Al menos 3 conclusiones o recomendaciones.
- Al menos 10 consultas de prueba documentadas.
- Uso de variables, unificación y backtracking cuando corresponda.
- Interfaz gráfica accesible desde un navegador.
- Comunicación real entre la interfaz, la API y SWI-Prolog.
- Manejo de consultas válidas, datos incompletos, valores no válidos y ausencia de resultados.
- Despliegue público de la aplicación.

## Arquitectura prevista

```text
Usuario
  |
  v
Interfaz web
  |
  v
API HTTP y JSON
  |
  v
Motor SWI-Prolog
  |
  v
Conclusiones y explicaciones
```

## Separación de módulos

La implementación se organizará por responsabilidades:

```text
prolog/
  conocimiento.pl   # Conocimiento
  inferencia.pl     # Inferencia
  consultas.pl      # Consultas
backend/
  api               # Servicio web
frontend/
  interfaz          # Interfaz web
tests/
  casos             # Casos prueba
docs/
  pruebas           # Evidencias
```

Los comentarios del código se mantendrán breves y tendrán como máximo dos palabras. La documentación detallada de cada módulo se mantendrá en este archivo o en `docs/`.

## Flujo de una consulta

1. El usuario selecciona o introduce los datos en la interfaz.
2. La interfaz envía una solicitud JSON a la API.
3. La API valida los valores recibidos.
4. La API ejecuta una consulta controlada sobre el archivo Prolog.
5. SWI-Prolog obtiene una o varias soluciones mediante sus reglas.
6. La API transforma las soluciones en JSON.
7. La interfaz muestra conclusiones, explicaciones o mensajes de insuficiencia.

La API no recibirá ni ejecutará código Prolog arbitrario enviado por el usuario.

## Instalación y ejecución local

La estructura y los comandos definitivos se documentarán cuando el equipo seleccione las tecnologías y complete cada módulo. Como requisito base se utilizará:

- SWI-Prolog
- Git
- Un entorno para ejecutar la API
- Un navegador web

## Pruebas

Se documentarán como mínimo diez casos con:

- Datos de entrada.
- Consulta realizada.
- Resultado esperado.
- Resultado obtenido.
- Estado de la prueba.

También se comprobará que las respuestas de la aplicación coincidan con las consultas ejecutadas directamente en SWI-Prolog.

## Despliegue

La aplicación se publicará mediante una plataforma compatible con el backend y SWI-Prolog. El procedimiento, las variables de entorno, los comandos de arranque y la URL pública se agregarán después de validar el despliegue.

## Uso de inteligencia artificial

La asistencia generativa podrá utilizarse para documentación, configuración de GitHub, interfaz, integración frontend-backend, Docker, despliegue y análisis de infraestructura. No se utilizará para producir, completar o corregir los hechos, reglas ni predicados de los archivos `.pl`.

## Historial de trabajo

Los cambios se registrarán en commits separados por módulo para que el avance del proyecto sea identificable:

1. Documentación inicial.
2. Base de conocimiento elaborada por el equipo.
3. Motor de inferencia elaborado por el equipo.
4. API e integración.
5. Interfaz web.
6. Pruebas y evidencias.
7. Configuración de despliegue.

## Entrega

La entrega final incluirá el repositorio de GitHub, la URL pública, los archivos Prolog, la interfaz, el documento técnico, los casos de prueba, las evidencias, la declaración de uso de IA y el video demostrativo.