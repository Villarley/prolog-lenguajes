# Chatbot Inteligente con Programación Lógica

Proyecto universitario del curso **Paradigma Lógico** (TEC). Implementa un chatbot conversacional en **SWI-Prolog** con base de conocimiento, inferencia lógica, sinónimos y aprendizaje dinámico en memoria.

## Descripción

El sistema interpreta preguntas en español, consulta una base de hechos distribuida por integrante, infiere propiedades por herencia (`es_un` / `tiene`), resuelve sinónimos y aprende nuevos conceptos durante la conversación mediante `assertz`/`retract`.

## Requisitos

- [SWI-Prolog](https://www.swi-prolog.org/) 8.x o superior (probado con 10.x)
- Terminal con soporte UTF-8

## Cómo ejecutar

Desde la raíz del repositorio:

```bash
swipl src/main.pl
```

Para iniciar solo el bucle conversacional desde el REPL (después de cargar):

```prolog
?- [src/main].
?- iniciar.
```

## Ejemplos de conversación

| Entrada del usuario | Comportamiento esperado |
|---------------------|-------------------------|
| `¿Qué es Prolog?` | Muestra la definición de `prolog` |
| `Explique recursividad` | Muestra el concepto de recursividad |
| `Aprender que un gato es un animal` | Guarda `es_un(gato, animal)` |
| `Aprender que IA significa inteligencia artificial` | Guarda sinónimo (luego `inteligencia_artificial` ≈ `ia`) |
| `¿Qué es un gato?` | Tras aprender, puede inferir categorías/propiedades |
| `salir` | Despide y termina |

## Estructura de carpetas

```
.
├── README.md
├── .gitignore
├── src/
│   ├── main.pl              # Punto de entrada
│   ├── chatbot.pl           # Bucle conversacional recursivo
│   ├── nlp.pl               # Normalización y tokens
│   ├── interprete.pl        # Detección de intenciones
│   ├── inferencia.pl        # Cierre transitivo e herencia
│   ├── aprendizaje.pl       # assertz/retract dinámico
│   ├── sinonimos.pl         # Forma canónica
│   ├── respuestas.pl        # Plantillas de salida
│   └── kb/
│       ├── kb_core.pl       # Declaraciones :- dynamic
│       ├── kb_santiago.pl   # KB de Santiago (~50 hechos)
│       ├── kb_integrante2.pl
│       └── kb_integrante3.pl
├── docs/
│   ├── manual_usuario.md
│   └── arquitectura.md
└── tests/
    └── test_chatbot.pl
```

## Integrantes

| Integrante | Archivo KB | Estado |
|------------|--------------|--------|
| Santiago | `src/kb/kb_santiago.pl` | Muestra (~15 hechos, tema Prolog) |
| Integrante 2 | `src/kb/kb_integrante2.pl` | Muestra animales + **TODO: 50 hechos** |
| Integrante 3 | `src/kb/kb_integrante3.pl` | Muestra ciencia/IA + **TODO: 50 hechos** |

Cada integrante debe completar **50 hechos** en su archivo usando los cinco predicados: `concepto/2`, `es_un/2`, `tiene/2`, `sinonimo/2`, `relacion/3`. Así GitHub registra contribuciones individuales por archivo.

## Pruebas

```bash
swipl -g "run_tests, halt." -t halt tests/test_chatbot.pl
```

## Notas de diseño

- **Sin módulos**: todo se carga en el namespace `user` para que `assertz`/`retract` funcionen entre archivos.
- **Sin persistencia**: el aprendizaje vive solo en memoria hasta cerrar SWI-Prolog.
- **Sin ciclos imperativos**: el diálogo itera por recursión, no con `repeat` ni `between`.

## Documentación

- [Manual de usuario](docs/manual_usuario.md)
- [Arquitectura lógica](docs/arquitectura.md)
