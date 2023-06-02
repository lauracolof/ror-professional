require 'test_helper'

class TodoTest < ActiveSupport::TestCase
# se define la funcionalidad de las pruebas
# cualquier método que inicie con test_ es una prueba
  def test_algo
  end
# método de ayuda que recibe un stringy  bloque y se convertirá en un método.
  test "test title should not be empty" do
    # instanciamos un nuevo método de la clase todo
    todo = Todo.def new
    todo.save
    puts todo.errors.full_messages # nos retorna los titulos de las pruebas 
    assert !todo.persisted? #si retorna falso la afirmacion falla, true, pasa. Si el obj fue guardado, es persisted. Alternativamente podemos afirmar que todos tiene algun error.
    assert todos.errors.any? 
    end
 # se convertirá en
  def test_title_should_not_be_empty
  end
end

=begin PROCESO COMPPLETO
  - creamos un nuevo obj, no le asignamos valor a ningun campo, la consulta es todos los registros vacios
  - lo intentamos guardar, inicia proceso de guardar en db
  - todo_test.rb ejecuta las validaciones, como no hay titulo presente
   - no guarda el registro y agrega al arr- de errores, que dice qué validación falló.
   - se verifica que haya titulo y si hay cambios pasa.
=end