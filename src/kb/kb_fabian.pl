% Knowledge Base - Fabián Sánchez Durán
% Temas: AI, datascience y otras cosas de compu

:- multifile concepto/2, es_un/2, tiene/2, sinonimo/2, relacion/3.

% Conceptos
concepto(ia, 'Campo de computación que busca simular inteligencia humana').
concepto(inteligencia_artificial, 'Disciplina que crea sistemas capaces de razonar y aprender como si fuesen humanos').
concepto(machine_learning, 'Rama de la IA que aprende patrones a partir de datos').
concepto(deep_learning, 'Aprendizaje automático con redes neuronales profundas').
concepto(red_neuronal, 'Modelo computacional inspirado en neuronas biológicas').
concepto(algoritmo, 'Secuencia finita de pasos para resolver un problema específico').
concepto(datasets, 'Conjuntos de datos usados para entrenar modelos de IA').
concepto(big_data, 'Volúmenes masivos de datos que requieren procesamiento distribuido').
concepto(python, 'Lenguaje de programación popular en ciencia de datos e IA, tiene muchas librerias interesantes').
concepto(tensorflow, 'Framework de Google para construir modelos de deep learning').
concepto(nlp, 'Sistema que procesa lenguaje natural en conversaciones (nlp es Natural Language Processing, por sis siglas en inglés)').
concepto(vision, 'Campo de IA que interpreta imagenes y videos (como lo que hace Azure AI Vision)').
concepto(robotica, 'Disciplina que combina mecanica, sensores e inteligencia (aveces)').
concepto(gpu, 'Procesador especializado en calculo paralelo (útil para entrenamiento de modelos de IA)').
concepto(cloud_computing, 'Servicios de computo y almacenamiento accesibles por la nube (AWS, Azure, GCP, etc)').

% Taxonomia
es_un(ia, disciplina_ciencia).
es_un(machine_learning, subcampo_ia).
es_un(deep_learning, subcampo_ml).
es_un(red_neuronal, modelo_ia).
es_un(algoritmo, metodo_computacion).
es_un(datasets, recurso_datos).
es_un(big_data, recurso_datos).
es_un(python, lenguaje_programacion).
es_un(tensorflow, framework_ml).
es_un(nlp, aplicacion_ia).
es_un(vision, aplicacion_ia).
es_un(robotica, aplicacion_ia).
es_un(gpu, hardware_computacion).
es_un(cloud_computing, servicio_computacion).

% Jerarquia
es_un(subcampo_ia, ia).
es_un(subcampo_ml, machine_learning).
es_un(modelo_ia, ia).
es_un(aplicacion_ia, ia).
es_un(metodo_computacion, tecnica_computacion).
es_un(lenguaje_programacion, herramienta_desarrollo).
es_un(framework_ml, herramienta_desarrollo).
es_un(recurso_datos, insumo_ia).
es_un(hardware_computacion, infraestructura).
es_un(servicio_computacion, infraestructura).
es_un(disciplina_ciencia, campo_conocimiento).
es_un(tecnica_computacion, campo_conocimiento).
es_un(herramienta_desarrollo, herramienta_computacion).
es_un(insumo_ia, recurso_tecnologico).
es_un(infraestructura, soporte_tecnologico).
es_un(tema_transversal, area_estudio).

% Modelos
es_un(perceptron, red_neuronal).
es_un(cnn, red_neuronal).
es_un(transformer, modelo_ia).
es_un(regresion_lineal, algoritmo).
es_un(arbol_decision, algoritmo).
es_un(kmeans, algoritmo).

% Propiedades
tiene(disciplina_ciencia, investigacion).
tiene(modelo_ia, entrenamiento).
tiene(modelo_ia, datos).
tiene(subcampo_ml, estadistica).
tiene(deep_learning, capas_ocultas).
tiene(red_neuronal, pesos).
tiene(algoritmo, complejidad).
tiene(lenguaje_programacion, sintaxis).
tiene(python, librerias).
tiene(tensorflow, grafos_computacion).
tiene(gpu, paralelismo).
tiene(cloud_computing, escalabilidad).
tiene(aplicacion_ia, inferencia).
tiene(recurso_datos, volumen).
tiene(big_data, variedad).
tiene(nlp, tokenizacion).
tiene(vision, clasificacion_imagenes).
tiene(robotica, sensores).
tiene(transformer, atencion).
tiene(cnn, convolucion).

% Relaciones
relacion(ia, utiliza, red_neuronal).
relacion(algoritmo, requiere, logica).
relacion(machine_learning, depende_de, datasets).
relacion(deep_learning, usa, gpu).
relacion(tensorflow, implementa, deep_learning).
relacion(python, popular_en, machine_learning).
relacion(nlp, procesa, lenguaje_natural).
relacion(vision, analiza, imagenes).
relacion(robotica, controla, actuadores).
relacion(big_data, almacena_en, cloud_computing).
relacion(transformer, mejora, nlp).
relacion(cnn, especializa_en, vision).

% Sinonimos
sinonimo(inteligencia_artificial, ia).
sinonimo(ml, machine_learning).
sinonimo(dl, deep_learning).
sinonimo(nn, red_neuronal).
sinonimo(ia_generativa, gen_ai).
sinonimo(aprendizaje_automatico, machine_learning).
sinonimo(redes_neuronales, red_neuronal).
