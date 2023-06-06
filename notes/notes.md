# Personal notes

## CARPETAS PRINCIPALES
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

## ARQUITECTURA MVC:

Base del framework. Identificamos tres tipos de archivos:

- Models, se encargan de la comunicación con la DB, se guarda info, se consulta, transforma, etc. Se hace a través del **Active Records** de ROR; es el módulo para comunicación con la DB, permite comunicarse a través de obj, clases y métodos sin usar SQL. La data se muestra en vistas (paginas HTML, Json, archivos xml, pdf.).
- Views, el módulo de rails para trabajar con vistas se llama **Action View** : contiene muchas características interesantes como manejo de layouts, vistas parciales y motor de vistas para embeber código de ruby, lo que permite mostrar la info en la app.
- Controllers, conector entre los datps y su representación en vistas. Reciben peticiones y visitas de parte de los usuarios, y dan respuestas a estas peticiones. Utilizan los modelos para consultar datos y las vistas para mostrar las representaciones de estos datos. Manejados a través de **Action Controllers**, que provee convenciones y caract. para trabajar.

## Convencion sobre configuración.

Por convencion, los que fueron formados con decisiones que fuerno tomadas desde el diseño del framework, como se usa, como se establecen archivos, se basa en convenciones de trabajo. Hay que colocar el mismo nombre de una vista a un controlador, el nomnbre de una tabla es el plural y el singular es el nombre del modelo.

### PASOS PARA DAR RESPUESTA

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

## ERB

Provee una manera facil pero poderosa para agregar sistema de templates para Ruby, viene implementado con ruby. Sistemas que requieran embeber código de ruby con un archivo de texto plano. No es exclusivo con html. Nos permite generar información y agregar estructuras del control de flujos como ciclos. Operadores para embeber código:
<% if true %> # no imprime resultado
<%= Hola mundo %> # resultado de la impresión se imprime en el elemento.
<% end %> se corta con end
Si hacemos una impresión como números con un ciclo, no necesitamos necesariamente que se imprima el mismo ciclo.

## ROUTES

get "/courses/free", to: ""
sin decirle que controller usará, rails usará la primer parte del path "courses", será el controlador, y la segunda "free" es el método o la acción que dará respuesta. Por convención rails buscará courses/controller y dentro, deberá existir un método que se llame free. Si el controller no cumpla la convención, podemos utilizar "to: "courses#index", para decir que tenemos un controlador courses y un método index que resolverán la petición courses. Y buscará un archivo que será "courses_controllers" y dentro una clase "CoursesController" que defina index.

### Main route

Se define utilizando el método **root** en routes. que recibe un hash de config y cno el que podemos utilizar to: también. Esto nos lleva a la ruta base sin /path, pero redirecciona a lo que establezcamos.

```
root to: "main#welcome"
```

## HELPERS

Métodos donde podemos definir métodos para utilizar en vistas o templates. Método para definir un link. Definimos como primer argumento lo que va a ir en vistas, y como segundo el path al que dirige el link.

```
<%= link to "Inicio, "/" %>
```

También tenemos métodos que definen las rutas, las rutas que definimos tienen otro nombre, root, es la base, root_path es la que establezcamos. Root url entrega el dominio.
<%= link to "Inicio, "/" root_path %>

## FORMS IN RAILS

Especiales por contar con más de una protección de seguridad, para los ataques web mas comunes, y por ofrecer métodos para las vistas que permiten generar form y controllers mas ordenados y mantenibles.

## PARAMS

A través de donde podemos leer data de un form, colocados como ?params=. Los que vienen de una url, son los query_params y los que vienen en el cuerpo de una petición, y dependen del método http. Si es GET, vendran en la url, si es tipo POST, vendran ocultos en el body. De todas formas, siempre están didsponibles via obj params.
Para acceder a la prop params:
{"Authenticity_token"=>"[FILTERED]","name"=>"Laura","commit"=>"Enviar"}
accedemos con simbolos [:name] o strings['name'] y podemos guardarlo en variable de clase con @variable = params... y queda disponible en las vistas.

## Diferentes generadores de código del framework

Producen la estructura base de elementos como controllers, views, migrations, etc.
**rails generate controller Example** // generador del controller "Example" y opcional acciones, como "demo". Agrega: agrega rutas, vistas para demo, pruebas unitarias y style
**rails destroy controller Example** // elimina lo generado
**rails generate migration CreateTodos title:string description:text due_date:datetime priority:integer** // el nombre de la tabla va en plural, y puede recibir argumetos como los datos para la tabla, como titulo, que será string, etc. Este archivo produce una tabla con una serie de props que pueden modificar la tabla. Esto se ejecutará dentro del método change que permitirá modificar o eliminarla. Una vez definida, **rails db:migrate** debemos ejecutarla para generar las migraciones. si le agregamos VERSION= y el numero de la migración, le decimos qué migracion en especifico queremos.
**rails generate model Todo title:string** //primer letra en mayus y singular, crea un nuevo modelo y una migración para la tabla de ese modelo
**rails test test/models/todo_test.rb** // Para ejecutar los archivos de pruebas: rails test /archivo.

## MIGRACIONES

Comúnmente conocidas como migraciones de esquema, decimos que una migración es como se conoce a los cambios incrementales y reversibles al esquema de la base de datos, éste tipo de archivos describen cambios al esquema que se pueden ejecutar de uno en uno, por lo que los llamamos incrementales, y que al mismo tiempo pueden ser revertidos.
En Rails, las migraciones residen en la carpeta migrations dentro de la carpeta db, que al mismo tiempo contiene otros archivos relacionados a la base de datos, o incluso la base de datos misma. Cada migración se almacena en un archivo distinto, cuyo nombre se compone de dos elementos: un texto descriptivo del cambio y la fecha en que fue generada la migración, en formato de timestamp.
A través de la utilidad de la terminal de Rails, se pueden ejecutar las migraciones, como normalmente nos referimos a la ejecución del cambio en la migración, así mismo, se pueden revertir dichas migraciones, para deshacer los cambios de la migración.
Como parte de nuestra base de datos, Rails genera una tabla especial de nombre migrations, en la cuál almacena qué migraciones ya fueron ejecutadas y cuáles no, esto nos permite ejecutar únicamente migraciones nuevas, y saber cuáles podemos revertir y cuáles no.
En un entorno de desarrollo, Rails reportará al ejecutar el proyecto que hay migraciones pendientes por realizar, para que todas las personas involucradas en el proyecto, sepan que hay nuevos cambios. Al mismo tiempo, gracias a que los archivos describen las modificaciones, no es necesario que cada persona en el equipo sepa cómo realizar los cambios, basta con ejecutar el comando de ejecución de migraciones, y éstos se realizarán.
También importante, es que en caso de que una migración haya ejecutado un cambio contraproducente, puede ser revertido con un comando, a través de la utilidad de terminal de Rails.

## MODELOS

Estructuras con los datos y la lógica para procesarlos, también son quienes nos comunican con la DB. Acá reside la lógica de negocio, que determinan como se almacenan y cambian los datos. También pueden existir modelos que no estén asociados a una tabla.

---

## UNITARY TEST

Las pruebas unitarias nos ayudan en muchos aspectos, tales como:

- A la detección temprana de errores o bugs
- A escribir mejor código, motivándonos a dividir nuestra solución en problemas individuales para cada método o estructura de nuestro código
- A describir el problema que queremos resolver
- A asegurarnos que nuevos cambios, no introducen bugs en otras partes de la aplicación
  En Rails, es común que sigamos un flujo de código basado en una metodología de nombre TDD, Test Driven Development. TDD es una de muchas metodologías para escribir código de pruebas, por lo que no ahondaremos en el concepto, de éste rescataremos el flujo de pruebas que funciona de la siguiente manera.
- Escribimos una prueba para código que aún no existe. Ejemplo: Probar que podemos crear usuarios, antes de escribir el código para crear usuarios
- Corremos o ejecutamos la prueba para ver que falle
- Escribimos el código para la prueba. Ejemplo: Escribimos la funcionalidad para crear usuarios
- Volvemos a ejecutar la prueba para ver que pase
- Refactorizamos o mejoramos el código
- Volvemos a ejecutar la prueba para asegurarnos que siga pasando
  Decimos que una prueba pasa, cuando la afirmación de la prueba se cumple, así mismo, decimos que una prueba falla cuando la afirmación de la prueba no se cumple.
  Para escribir pruebas, Rails viene preconfigurado con un framework de pruebas: MiniTest. Aunque cubrir a fondo este framework requeriría un curso propio, vamos a aprender los fundamentos del uso y la sintaxis para la redacción de pruebas en nuestra aplicación, de esta manera nos aseguraremos de que el código funciona correctamente, sin tener que probarlo manualmente.

## VALIDATIONS

RoR a través del Active_record, provee una serie de validaciones predefinidas y apis que permiten personalizarlas. Las validaciones se escriben en los métodos, en cada campo.
Si no hay fallas al ejecutar la prueba debería retornar algo como:
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

## ACTIVE RECORD

"Una fila de la Db representada por un obj, al que se le añade lógica del negocio, haciendo que tenga acceso directo a los datos en la tabla, además de operaciones de negocios sobre dichos datos."
Es la M del MVC, capa que nos permite comunicarnos a través de obj con acceso a la DB, implementación de ORM, representación en que los datos se representan con objetos. Se asegura que la comunicación con la DB se haga utilizando clases y obj, en lugar de SQL.
Beneficios:

- Podemos reemplazar la DB sin modificar las consultas.
- Usamos código declarativo de Ruby.
- Las relaciones de la DB se trasladan a objs.
- Nos permite escribir métodos de la lógica del negocio con acceso directo a los datos.
- Cada modelo que hereda de Application-Record que a su vez hereda de Active-Record-Base, es una clase de active-record.
- Cada modelo está asociado a una tabla, bajo convención, el nombre del modelo es el singular del nombre de la tabla. Modelo Todo, asociado a tabla Todos.
- Las clases del active record pueden utilizar consultas de búsquedas, en grupo para actualizar multiples elem a la vez, eliminar en bulto, etc.

- Las instancias (obj creados a partir de clases) del active-record pueden pueden utilizar actualizaciones, lectura, creacion y eliminación sobre una fila de datos asociados.
- Cuando consultamos por un grupo de filas de la tabla, se nos entrega una colección de la clase: **active record relation**, donde instancia un obj para cada fila del resultado.
- Podemos instanciar nuevos objetos de un modelo sin que represente una fila de la tabla, estos obj no son persistentes (puedo crear obj de un modelo sin que estén guardados en la db, solo en memoria virtual, al dejar de ser usados seran eliminados. Pero podemos guardarlos.)
  //La clase operaciones sobre consultas
  // Los objetos operaciones sobre filas

Para utilizar el active record utilizamos la consola de rails: rails console. Nos permite interactuar desde la línea de comandos.
Todas las consultas generadas en **rails console**, deben ser guardadas o se perderan: todo.save y retorna "INSERT INTO:...", ya podemos utilizar el métodos de clase para realizar consultas como "Todo.all" que retorna todos los registros.

- "Todo.all" todos los registros.
- "Todo.count" cuenta los registros.
- "Todo.all.first" retorna el primero.
- "todo.title = Todo.all.first" guardamos el primero en otra var
- "todo.title = 'Nuevo título' " cambiamos el nombre del anterior.
- "todo.save" vuelve a guardar el modificado, y retorna consulta "UPDATE".
  Alternativa a save para persistir datos.
- "Todo.create(title: 'Completar el bloque')", crea un nuevo registro y con los hash obligatorios y lo guarda directamente.
- "todo- Todo.all.last" obtenemos el último registro creado
- "todo.update" actualiza el anterior pasandole el hash.
- "todo.destroy" elimina un registro

## SCAFFOLF

Herramientas con las que podemos generar a la vez, vistas, controllador, modelo de una tabla en uno. 
**rails generate scaffold Tweet body:text** genera todas las apps de CRUD para un registro:
invoke active_record
create db/migrate/20230602182004_create_tweets.rb
create app/models/tweet.rb
invoke test_unit
create test/models/tweet_test.rb
create test/fixtures/tweets.yml
invoke resource_route
route resources :tweets
invoke scaffold_controller
create app/controllers/tweets_controller.rb
invoke erb
create app/views/tweets
create app/views/tweets/index.html.erb
create app/views/tweets/show.json.jbuilder
create app/views/tweets/\_tweet.json.jbuilder
invoke assets
invoke scss
create app/assets/stylesheets/tweets.scss
invoke scss
create app/assets/stylesheets/scaffolds.scss
Para que eso surga efecto sobre la tabla debemos utilizar el comando **rails db:migrate**

## VERBOS HTTP Y REST

Estas son algunas reglas que te servirán para saber cómo y cuándo debes usar los verbos Http en una arquitectura REST.

Los verbos Http involucrados en un sistema REST son GET, POST, PUT, PATCH y DELETE.

GET es el que usamos para consultar un recurso. Una de las principales características de una petición GET es que no debe causar efectos secundarios en el servidor, no deben producir nuevos registros, ni modificar los ya existentes. A esta cualidad la llamamos idempotencia, cuando una acción ejecutada un número indefinido de veces, produce siempre el mismo resultado.

Esto quiere decir, que no importa cuántas veces hagamos una petición GET, los resultados obtenidos serán los mismos.

Cuando ingresamos a la dirección usando GET https://cf.com/c/backend-profesional/ estamos solicitando que se nos entregue el recurso identificado por /cursos/backend-profesional, este es un buen ejemplo de uso con GET.

Esta otra ruta: https://codigofacilito.com/c/recomendar?selected_level=0&category_options=28 aunque más compleja, también es correcta, estamos solicitando los recursos identificados por /cursos con las opciones de filtrado ahí indicadas. Sin importar cuantas veces hagamos esta solicitud, no modificará los resultados por sí misma.

Las peticiones con POST son sólo para crear recursos nuevos. Cada llamada con POST debería producir un nuevo recurso.

Normalmente, la acción POST se dirige a una recurso que representa una colección, para indicar que el nuevo recurso debe agregarse a dicha colección, por ejemplo POST /cursos para agregar un nuevo recurso a la colección cursos.

Si queremos crear un nuevo artículo, pudiéramos tener una URI /articulos. Lo que es importante en estos casos, es recordar que la URI no debe decir qué acción estamos ejecutando, nos olvidamos de /articulos/crear o de /cursos/agregar, etc. El verbo dice qué haremos, y la URI sobre qué recurso se harán las modificaciones.

Algunos escenarios más complejos para el uso de POST son los inicios de sesión, agregar a un carrito de compras, procesar un pago nuevo, etc. Estos ejemplos nos dejan en claro que el recurso creado por POST no es precisamente una fila en la base de datos, el recurso puede ser una sesión, un pago en una API externa, etc.

Los verbos PUT/PATCH son muy similares ya que ambos se usan para modificar un recurso existente. En la teoría, PUT se diferencía de PATCH, en que el primero indica que vamos a sustituir por completo un recurso, mientras que PATCH habla de actualizar algunos elementos del recurso mismo, sin sustituirlo por completo.

Un escenario común para el uso de PUT sería una llamada para actualizar la información de un curso, por ejemplo:

PUT /cursos/backend-profesional

O también:

PATCH /cursos/backend-profesional

En la práctica, y particularmente en Rails, ambos verbos se usan para actualizar un recurso, sin importar si lo sustituimos parcial o totalmente.

Por último, DELETE es el verbo que usamos para eliminar registros, bien pudiera ser para eliminar un recurso individual como en:

DELETE /cursos/backend-profesional

O para eliminar una colección completa:

DELETE /cursos

Esta es la manera a través de la que usamos los verbos Http en una aplicación web. Estos en combinación con las URIs proveen la interfaz uniforme de la que hablamos cuando discutimos las características de un sistema REST.

## ANOTATE

Dependencia adicional, que permite utilizar el comando "anotate", _bundle exec annotate --model_ . Debemos pasarle la bander a --model y lo que hace es la info del schema de dicha tabla para generar los modelos y sirve para consultar los datos
**gem 'annotate'** y luego _bundle install_
También viene con un comando para no ejecutarla constantemente. **rails generate annotate:install** y automáticamente cada vez que generamos una migración se anotarán los datos del model.

## COOKIES Y SESSION

Cookies se guardan en el cliente (navegador). Para asignar una cookie se puede utilizar el obj cookie y para leerla se puede obtener al leer. En cada petición al servidor se pueden usar, todas son encryptada por rails. y sólo pueden ser accedidas por rails. El valor tmb se encuentra encryptado en credentials. Se pueden modificar pero no es recomendable. Si ejecutamos **rails secret** nos entrega el secreto.

Las sesiones en el servidor y un identificador único es en el navegador como una cookie. Pero busca en el servidor..
En session es muy similar al funcionamiento de las cookies.

## MENSAJE FLASH

Forma de comunicarnos entre acciones de un controlador. Se asignan a un hash flash y serán expuestos en la siguiente acción que el framework ejecute. Son muy buenos para comunicar información en un redireccionamiento. Sólo aceptan strings, arrays y otros hash. Para guardar un mensaje flash podemos utilizar el método flash, asignarlo a una clave arbitraria. Rails expone dos helpers en la vist para acceder específicamente a los flash, específicamente alert y notice. Que pueden enviar un mensaje antes del redireccionamiento. Por ejemplo: Todo ok, o failure. Por defecto no se muestra, hay que agregarlos a la vista. (layout/body). Y se muestra en el caso de que exista. Son para la siguiente acción del controlador que se ejecute.

## CONCERNS

Son como módulos. Las funciones de los concerns es hacerlo más legible. Cualquier método que se crea para poder compartir en otra parte del código, pero no se puede utilizar por si mismo. Ni se hereda.

```
module Example
  extend ActiveSupport::Concern

  def hello
    puts "hello"
  end

  class_methods do
    def metodo_de_clase
    end
  end
end

class ClassExample
  include Example
end
```

## METODOS ASOCIADOS A RUTAS

Es buena práctica utilizar helpers de rutas en lugar de colocar strings de las rutas cuando trabajamos en las vistas. Nos evita además tener que cambiar en cada lugar donde se llame a la ruta. Fomenta el principio de separación de responsabilidades.

**rails routes**
Enlista todas nuestras rutas, con info:
1- prefijo
2- verbo http
3- uri pattern
4- controller+action

nombre_path # retorna una ruta relativa como /photos
photos_path => /photos

nombre_url # returna una ruta absoluta que incluye el dominio
photos_url => localhost:3000/photos

## BLOQUES

Active Record: Modelo, sería como el api del active_record, una de las más importantes de rails y de los más utilizados.
Los modelos son lo más imporatnte de la app, el termino con los que definimos los procesos que asemejan al negocio. Los modelos contienen para lo que está diseñada la información.
Los modelos que heredan de la DB son los active_records, los que no, se pueden usar a conveniencia.

Clausura where: filtra los registros que obtenemos en una consulta. Where, es parte del método active records query methods. Puede usarse a traves de un modelo o encadenarlo en una consulta con otros métodos del modelo:
**Photo.all.class.name** # Nos retorna un obj de la clase: "ActiveRecord::Relation y puedo utilizar el Where **Photo.all.where** para hacer filtrado de info de los que devolvió class.name, pero sino puedo hacer **Photo.where** spbre el modelo para directamente solicitar elementos filtrados.
Para buscar un registro con algo definido, puede definir un hash o un string.
HASH:
**Photo.where(title: ["Demo", "Demov2"])**
STRING:
**Photo.where("created_at > ?", Date.parse("01-01-2021"))** # nos devuelve un objeto con un arreglo que es un iterable donde vienen todos los registros que cumplan con las condiciones. Como una consulta SQL
**Photo.where(title != 'demo'")** #Todos los registros diferentes a demo.
**Photo.where("title is NULL")** #Todos los registros diferentes a demo.
**Photo.where("title is NULL")** #Todos los registros diferentes a demo.

## OPERADORES

AND **Photo.where("title IS NOT NULL OR image_url IS NOT NULL")**
OR **Photo.where(title:"Demo v2").or(Photo.where(image_url:"some.jpg") )**
NOT **Photo.where.not(title:'demo')**
NOT **Photo.where.not(title: nil)**
NOT **Photo.where.not(title: ["demo", "demo v2"])**
Version >> 6 preferentemente pasarlas consultas individual
NOT **Photo.where.not(title: "").where.not(image_url: "")**

## PAGINACIÓN

Práctica común en los resultados que obtenemos de tablas. Especialmente útiles en tablas con muchos registros donde cargar toda la tabla en una sola operación puede ser contraproducente en tiempos de respuesta y memoria utilizada.

## SCOPE

son métodos de clase pensados para ser encadenados y siempre deben retornar una relación, el primer argumento es el método para el scope, el segundo es una estructura de ruby Proc, la sintaxis es una -> con un bloque de código y podemos pedir por ejemplo un orden descendente.

## VALIDACIONES

Predefinidas: las que vienen implementadas, y solo necesitamos declarar su uso en el modelo, built-in. Permiten definir multiples validaciones en una sola declaración. Pueden recibir procs para agregarle lógica adicional a las validaciones.
**uniqueness: {message: -> (object,data){"%{value} ya fue usado para #{object.image_url}%"}}** retornaría
**["Title logo de Código facilito ya fue usado para logo.png"]**

Podemos implementar nuestras propias validaciones para crear la que necesitamos utizliando el método validate:

```
class Todo < ApplicationRecord
  validate :due_date_is_valid (due date, campo de schema)

  def due_date_is_valid
    if due_date < DateTime.now
      errors.add(:due_date, "La fecha de entrega ya pasó")
    end
  end
end
```

## CALLBACKS

Métodos que se ejecutan antes, durante o después de la creación, actualización o eliminación de un obj. Existen más de 16 callbacks. After_create por ejemplo se puede usar después de crear un posteo.

```
class Tweet < ApplicationRecord
  after_create :send_notifications

  private
    def send_notifications
    end
end
```

after_commit Se llama cuando la modificación a un objeto nuevo o existente se ha registrado con un “commit” a la base de datos. Un commit finaliza una transacción en una base de datos relacional. Se puede usar un argumento :on para especificar para qué acción (crear, actualizar o eliminar) se debería aplicar el callback.

after_create Se llama luego de que un nuevo objeto ha sido guardado

after_destroy Se llama luego de que un nuevo objeto ha sido eliminado.

after_rollback Se llama luego de que la transacción para registrar una creación, actualización o eliminación se ha revertido sobre un objeto nuevo o existente. Esto puede pasar probablemente por algún error en la base de datos.

after_save Se llama luego de que un objeto nuevo o existente ha sido guardado.

after_update Se llama luego de que un objeto existente ha sido guardado.

after_validation Se llama luego de que las validaciones para un objeto nuevo o existente ocurrieran, sin importar si fallaron o pasaron.

around_create Este callback te da control absoluto sobre si la operación de creación se ejecuta o no, además de permitirte añadir lógica antes y después de la creación. La operación de creación no se ejecuta hasta que invocas yield en el método del callback, si yield se ejecuta el objeto se guarda y continúa la ejecución del método. Si yield no se ejecuta dentro del método, el objeto no se guarda.

around_destroy Este callback te da control absoluto sobre si la operación de eliminación se ejecuta o no, además de permitirte añadir lógica antes y después de la eliminación. La operación de eliminación no se ejecuta hasta que invocas yield en el método del callback, si yield se ejecuta el objeto se elimina y continúa la ejecución del método. Si yield no se ejecuta dentro del método, el objeto no se elimina.

around_save Este callback te da control absoluto sobre si la operación de guardado para un objeto nuevo o existente se ejecuta o no, además de permitirte añadir lógica antes y después de la operación de guardado. La operación de guardado no se ejecuta hasta que invocas yield en el método del callback, si yield se ejecuta el objeto se guarda y continúa la ejecución del método. Si yield no se ejecuta dentro del método, el objeto no se guarda.

around_update Este callback te da control absoluto sobre si la operación de guardado para un objeto existente se ejecuta o no, además de permitirte añadir lógica antes y después de la operación de guardado. La operación de guardado no se ejecuta hasta que invocas yield en el método del callback, si yield se ejecuta el objeto se guarda y continúa la ejecución del método. Si yield no se ejecuta dentro del método, el objeto no se guarda.

before_create Se llama antes de que un objeto nuevo haya sido guardado.

before_destroy Se llama antes de que un objeto haya sido eliminado.

before_save Se llama antes de que un objeto nuevo o existente haya sido guardado.

before_update Se llama antes de que un objeto existente haya sido guardado.

before_validation Se llama antes de que las validaciones para un objeto nuevo o existente ocurran.
