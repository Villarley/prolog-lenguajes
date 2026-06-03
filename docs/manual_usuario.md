# Manual de usuario — Chatbot Inteligente

## Instalación de SWI-Prolog

### macOS (Homebrew)

```bash
brew install swi-prolog
```

### Linux (Debian/Ubuntu)

```bash
sudo apt-get install swi-prolog
```

### Windows

Descargar el instalador desde [swi-prolog.org](https://www.swi-prolog.org/download/stable).

Verificar instalación:

```bash
swipl --version
```

## Iniciar el chatbot

1. Abrir una terminal en la carpeta del proyecto.
2. Ejecutar:

```bash
swipl src/main.pl
```

3. Aparecerá el prompt `Tu> `. Escribir la pregunta o comando y presionar Enter.

Para salir: escribir `salir`, `adios`, `chao` o `exit`, o cerrar la entrada estándar (Ctrl+D).

## Tipos de interacción

### Preguntar por un concepto

Frases reconocidas:

- `¿Qué es Prolog?`
- `define recursividad`
- `explique backtracking`
- `para que sirve ia`

El bot busca `concepto/2` (resolviendo sinónimos). Si no hay definición, intenta mostrar inferencias (categorías y propiedades heredadas). Si tampoco hay datos, pide que le enseñes el concepto.

### Aprender un concepto (definición)

```
Aprender que blockchain es un registro distribuido inmutable
```

Si la definición no va en la misma frase, el bot pedirá una segunda línea.

También puedes responder cuando el bot pregunte tras una consulta fallida:

```
Tu> que es xyz
Bot> No tengo informacion...
Bot> Cuentame, que es xyz?
    > Es un termino inventado para pruebas
```

### Aprender sinónimo

```
Aprender que IA significa inteligencia artificial
Aprender que pl es sinonimo de programacion_logica
```

### Aprender relación taxonómica (es_un)

```
Aprender que un gato es un animal
Aprender que un perro es un mamifero
```

Después puedes preguntar propiedades heredadas, por ejemplo si `animal` tiene `vida`, el bot puede inferir que `perro` también.

### Saludo y despedida

- `hola`, `buenas`, `saludos` → respuesta cordial.
- `gracias` → reconocimiento.
- `salir` → fin del programa.

## Consejos

- Escribir en minúsculas o mayúsculas: el sistema normaliza la entrada.
- Los tildes y signos `¿?¡!.,;` se eliminan automáticamente.
- El conocimiento aprendido **no se guarda en disco**; al cerrar SWI-Prolog se pierde.
- Usar átomos sin espacios en los términos clave (`prolog`, `ia`, `gato`).

## Solución de problemas

| Problema | Solución |
|----------|----------|
| `ERROR: source_sink ... does not exist` | Ejecutar desde la raíz del proyecto, no desde `src/` |
| Caracteres raros en terminal | Asegurar UTF-8: `export LANG=es_ES.UTF-8` |
| El bot no responde | Verificar que la línea no esté vacía; probar `hola` |
