≡ Краткое описание

## Учебный проект "askme"

Канал - [Хороши йпрограммист](https://www.youtube.com/@goodprogrammer)

Видео-курс - [Уроки Ruby on Rails](https://www.youtube.com/playlist?list=PL87kYOx0cUgh_2FH8flx11o0mbN9vNMIj)

Используемый фрймворк: Ruby on rails 7.0.5

Язык программирования: Ruby 3.0

СУБД: Postgre SQL

Среда разработки: VS code, RubyMine

OS : Linux Ubuntu 22.04.2 LTS,

Windows subsystem for Linux v2 (WSL 2)

### Описание

Проект представляет из себя сайт с простой формой регистрации и возможностью задавать вопросы и отвечать на них.


### Проблемы и их решение

#### PostgreSQL

Команда
__`rails db:create`__ Выдает ошибку 

We could not find your database: postgres. Which can be found in the database configuration file located at config/database.yml.

psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  Peer authentication failed for user "rails"

##### Решение

[stackoverflow](https://stackoverflow.com/questions/17443379/psql-fatal-peer-authentication-failed-for-user-dev)

Your connection failed because by default psql connects over UNIX sockets using peer authentication, that requires the current UNIX user to have the same user name as psql. So you will have to create the UNIX user dev and then login as dev or use sudo -u dev psql test_development for accessing the database (and psql should not ask for a password).


But if you intend to force password authentication over Unix sockets instead of the peer method, try changing the following pg_hba.conf* line:
(/etc/postgresql/15/main/pg_hba.conf)

from
```
# TYPE DATABASE USER ADDRESS METHOD

 local  all      all          peer
```

to

```
# TYPE DATABASE USER ADDRESS METHOD

 local  all      all          md5

```

#### Как настроить отладчик в VS Code для удаленной отладки в WSL2

VS Code у нас работает под windows с проектом, расположенным на WSL2 

##### Решение 

В папке проекта есть папка `vscode`, в ней необходимо создать или отредактировать файл `launch.json`

Также понадобится `gem debug`

Содержимое файла (так же файл есть в проекте):

```
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "type": "rdbg",
      "name": "Rails server with rdbg",
      "request": "launch",
      "script": "${workspaceRoot}/bin/rails s",
      "useBundler": false,
      "command": "ruby"
    }, 
    {
      "name": "Rails server",
      "type": "Ruby",
      "request": "launch",
      "cwd": "${workspaceRoot}",
      "program": "${workspaceRoot}/bin/rails",
       "args": [
          "server"
      ]
    },
    {
      "type": "rdbg",
      "name": "Debug current file with rdbg",
      "request": "launch",
      "script": "${file}",
      "args": [],
      "askParameters": true
    },
    {
      "type": "rdbg",
      "name": "Attach with rdbg",
      "request": "attach"
    }
]
}

```

#### Не работает "VS Code Solargraph Extension" в WSL2 

##### Решение 
Run 
```which solargraph ``` in bash and copy the path

например: 

```/home/linuxuser/.rvm/gems/ruby-3.2.2/bin/solargraph```

Create a ```solargraph.bat``` file and paste the following snippet. Use the the path from which solargraph to replace ```{{SOLARGRAPH_PATH}}```
```
@echo off
bash -c "{{SOLARGRAPH_PATH}} %*"
```
Например:

```
@echo off
bash -c "/home/linuxuser/.rvm/gems/ruby-3.2.2/bin/solargraph %*"
```
IMPORTANT: Replace "bin" with "wrapper" in the path. 
(e.g. "/home/mtamdev/.rvm/gems/ruby-2.6.0@dev-project/bin/solargraph %*" 
-> 
"/home/mtamdev/.rvm/gems/ruby-2.6.0@dev-project/wrappers/solargraph %*"

Save the ```solargraph.bat``` file and copy it's full filepath
Add the following to the VSCode settings.json. 
Replace the path with the copied bat filepath.     

```"solargraph.commandPath": "C:\\Max\\solargraph.bat"```

пример

```"solargraph.commandPath": "C:\\Ruby31-x64\\solargraph.bat"```

Restart VSCode
