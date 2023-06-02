# CARPETAS PRINCIPALES

APP:
Models,
View,
Controllers,
Helpers: funciones para las vistas
Mailers: Correos electrónicos
Jobs: Trabajos en segundo plano
Channels: canales de websocket y comunicación en tiempo real.
Assets y JS: front

CONFIG: Archivos de config para la app y librerías extras
Environments: archivos de config para cada ambiente de desarrollo, se pueden estableceer de forma independiente según el estado de la app
Locals: Traducciones de texto para la app.
Archivos yml: propósito de guardar config, tipo json guarda llaves, etc.
Archivo routes.rb: definimos a qué direcciones responde nuestra app y qué respuestas entrega.

PUBLIC: contiene todos los arch publicos del proyecto y todos pueden ser accedidos, por ende son vulnerables.

STORAGE: archivos por defecto que subamos a la app utilizando el modelo de rails

# ARQUITECTURA MVC:

Base del framework. Identificamos tres tipos de archivos:

- Models, se encargan de la comunicación con la DB, se guarda info, se consulta, transforma, etc. Se hace a través del **Active Records** de ROR; es el módulo para comunicación con la DB, permite comunicarse a través de obj, clases y métodos sin usar SQL. La data se muestra en vistas (paginas HTML, Json, archivos xml, pdf.).
- Views, el módulo de rails para trabajar con vistas se llama **Action View** : contiene muchas características interesantes como manejo de layouts, vistas parciales y motor de vistas para embeber código de ruby, lo que permite mostrar la info en la app.
- Controllers, conector entre los datps y su representación en vistas. Reciben peticiones y visitas de parte de los usuarios, y dan respuestas a estas peticiones. Utilizan los modelos para consultar datos y las vistas para mostrar las representaciones de estos datos. Manejados a través de **Action Controllers**, que provee convenciones y caract. para trabajar.

# Convencion sobre configuración.

Por convencion, los que fueron formados con decisiones que fuerno tomadas desde el diseño del framework, como se usa, como se establecen archivos, se basa en convenciones de trabajo. Hay que colocar el mismo nombre de una vista a un controlador, el nomnbre de una tabla es el plural y el singular es el nombre del modelo.

# PASOS PARA DAR RESPUESTA

- routes.rb, le pasamos el controlador y acción va a responder: En las rutas nosotros declaramos qué recurso es manejado por cuál controlador, de manera que una vez que encuentra el controlador definido para la ruta correspondiente, la solicitud pasa hacia el controlador.

```
"get /welcome", to: "main#welcome"
```

- Controller: En el controlador es donde nosotros tenemos que declarar los pasos para responder a cada solicitud, en algunos casos, la respuesta es solo una página, en otros una imagen, en otros un reporte, etc.

```
class MainController < ApplicationController
  def welcome
  end
end
```

- Busca vista /views con el mismo nombre del controller: welcome.html.erb. Esa respuesta se envía al navegador quien se encarga de mostrar dicha vista.

```
<h1>Hola Mundo</h1>
```

# ERB

Provee una manera facil pero poderosa para agregar sistema de templates para Ruby, viene implementado con ruby. Sistemas que requieran embeber código de ruby con un archivo de texto plano. No es exclusivo con html. Nos permite generar información y agregar estructuras del control de flujos como ciclos. Operadores para embeber código:
<% if true %> # no imprime resultado
<%= Hola mundo %> # resultado de la impresión se imprime en el elemento.
<% end %> se corta con end
Si hacemos una impresión como números con un ciclo, no necesitamos necesariamente que se imprima el mismo ciclo.

# ROUTES

get "/courses/free", to: ""
sin decirle que controller usará, rails usará la primer parte del path "courses", será el controlador, y la segunda "free" es el método o la acción que dará respuesta. Por convención rails buscará courses/controller y dentro, deberá existir un método que se llame free. Si el controller no cumpla la convención, podemos utilizar "to: "courses#index", para decir que tenemos un controlador courses y un método index que resolverán la petición courses. Y buscará un archivo que será "courses_controllers" y dentro una clase "CoursesController" que defina index.

# Main route

Se define utilizando el método **root** en routes. que recibe un hash de config y cno el que podemos utilizar to: también. Esto nos lleva a la ruta base sin /path, pero redirecciona a lo que establezcamos.

```
root to: "main#welcome"
```

# HELPERS

Métodos donde podemos definir métodos para utilizar en vistas o templates. Método para definir un link. Definimos como primer argumento lo que va a ir en vistas, y como segundo el path al que dirige el link.

```
<%= link to "Inicio, "/" %>
```

También tenemos métodos que definen las rutas, las rutas que definimos tienen otro nombre, root, es la base, root_path es la que establezcamos. Root url entrega el dominio.
<%= link to "Inicio, "/" root_path %>

# FORMS IN RAILS

Especiales por contar con más de una protección de seguridad, para los ataques web mas comunes, y por ofrecer métodos para las vistas que permiten generar form y controllers mas ordenados y mantenibles.

# PARAMS

A través de donde podemos leer data de un form, colocados como ?params=. Los que vienen de una url, son los query_params y los que vienen en el cuerpo de una petición, y dependen del método http. Si es GET, vendran en la url, si es tipo POST, vendran ocultos en el body. De todas formas, siempre están didsponibles via obj params.
Para acceder a la prop params:
{"Authenticity_token"=>"[FILTERED]","name"=>"Laura","commit"=>"Enviar"}
accedemos con simbolos [:name] o strings['name'] y podemos guardarlo en variable de clase con @variable = params... y queda disponible en las vistas.

# Diferentes generadores de código del framework

Producen la estructura base de elementos como controllers, views, migrations, etc.
**rails generate controller Example** // generador del controller "Example" y opcional acciones, como "demo". Agrega: agrega rutas, vistas para demo, pruebas unitarias y style
**rails destroy controller Example** // elimina lo generado
**rails generate migration CreateTodos title:string description:text due_date:datetime priority:integer** // el nombre de la tabla va en plural, y puede recibir argumetos como los datos para la tabla, como titulo, que será string, etc. Este archivo produce una tabla con una serie de props que pueden modificar la tabla. Esto se ejecutará dentro del método change que permitirá modificar o eliminarla. Una vez definida, **rails db:migrate** debemos ejecutarla para generar las migraciones. si le agregamos VERSION= y el numero de la migración, le decimos qué migracion en especifico queremos.

# MIGRACIONES

Comúnmente conocidas como migraciones de esquema, decimos que una migración es como se conoce a los cambios incrementales y reversibles al esquema de la base de datos, éste tipo de archivos describen cambios al esquema que se pueden ejecutar de uno en uno, por lo que los llamamos incrementales, y que al mismo tiempo pueden ser revertidos.
En Rails, las migraciones residen en la carpeta migrations dentro de la carpeta db, que al mismo tiempo contiene otros archivos relacionados a la base de datos, o incluso la base de datos misma. Cada migración se almacena en un archivo distinto, cuyo nombre se compone de dos elementos: un texto descriptivo del cambio y la fecha en que fue generada la migración, en formato de timestamp.
A través de la utilidad de la terminal de Rails, se pueden ejecutar las migraciones, como normalmente nos referimos a la ejecución del cambio en la migración, así mismo, se pueden revertir dichas migraciones, para deshacer los cambios de la migración.
Como parte de nuestra base de datos, Rails genera una tabla especial de nombre migrations, en la cuál almacena qué migraciones ya fueron ejecutadas y cuáles no, esto nos permite ejecutar únicamente migraciones nuevas, y saber cuáles podemos revertir y cuáles no.
En un entorno de desarrollo, Rails reportará al ejecutar el proyecto que hay migraciones pendientes por realizar, para que todas las personas involucradas en el proyecto, sepan que hay nuevos cambios. Al mismo tiempo, gracias a que los archivos describen las modificaciones, no es necesario que cada persona en el equipo sepa cómo realizar los cambios, basta con ejecutar el comando de ejecución de migraciones, y éstos se realizarán.
También importante, es que en caso de que una migración haya ejecutado un cambio contraproducente, puede ser revertido con un comando, a través de la utilidad de terminal de Rails.
