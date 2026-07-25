Manual Git - AI MineSoftware
1. Verificar la carpeta actual
pwd
¿Qué hace?

Muestra la carpeta donde estás trabajando.

Cuándo usarlo

Siempre antes de ejecutar comandos importantes.

2. Inicializar un repositorio Git
git init
¿Qué hace?

Convierte una carpeta normal en un proyecto Git.

Solo se ejecuta una vez por proyecto.
3. Ver el estado del proyecto
git status
¿Qué hace?

Muestra:

archivos nuevos
archivos modificados
archivos eliminados
archivos preparados para commit

Este es probablemente el comando que más usarás.

4. Agregar TODOS los cambios
git add .
¿Qué hace?

Pasa todos los archivos al Staging Area.

Todavía NO crea el commit.

5. Agregar modificaciones y eliminaciones
git add -u
¿Qué hace?

Actualiza el índice de Git cuando:

modificaste archivos
eliminaste archivos

No agrega archivos nuevos.

6. Crear un Commit
git commit -m "Descripción del cambio"

Ejemplo:

git commit -m "Create HomePage component"
¿Qué hace?

Guarda un punto de restauración del proyecto.

7. Modificar el último commit (ANTES de publicarlo)

Este fue el comando más importante que aprendimos hoy.

git commit --amend --no-edit
¿Qué hace?

Reemplaza el último commit por una nueva versión.

No crea otro commit.

Conserva el mismo mensaje.

¿Cuándo usarlo?

Cuando olvidaste:

agregar un archivo
eliminar un archivo
corregir un pequeño detalle

IMPORTANTE

Solo debe usarse si todavía NO hiciste:

git push
8. Ver los repositorios remotos
git remote -v

Ejemplo:

origin https://github.com/mine-infante/BudgetKeep.git

Sirve para verificar a qué GitHub está conectado el proyecto.

9. Agregar el repositorio remoto
git remote add origin https://github.com/usuario/proyecto.git

Solo se hace una vez.

10. Publicar el proyecto
git push -u origin master
¿Qué hace?

Sube el proyecto a GitHub.

El parámetro

-u

crea la relación entre:

Repositorio local

↓

Repositorio remoto

Después de eso bastará con:

git push
11. Subir cambios posteriores
git push

Muchísimo más sencillo.

12. Descargar cambios
git pull

Obtiene los cambios desde GitHub.

13. Flujo normal de trabajo

Cada vez que terminemos una funcionalidad:

git status

↓

git add .

↓

git commit -m "Descripción"

↓

git push
14. Flujo cuando olvidamos algo antes del Push
git status

↓

Corregir archivos

↓

git add .

o

git add -u

↓

git commit --amend --no-edit

↓

git push
15. Nuestra Regla de Oro

Nunca hacer git push sin antes ejecutar:

git status

Debe mostrar:

nothing to commit, working tree clean

Solo entonces hacemos:

git push
16. Cosas que NO haremos

Nunca usaremos estos comandos sin analizar antes:

git reset --hard
git push --force
git rebase

No porque sean malos, sino porque son herramientas avanzadas. Cuando llegue el momento, aprenderemos a usarlas correctamente.

17. Nuestra filosofía

Git no es solo un respaldo.

Git es la historia del proyecto.

Cada commit debe representar un cambio completo, coherente y entendible.