# Импорт данных из ФИАС в Postgresql

**NOTE**: реализация на базе https://github.com/asyncee/fias2pgsql

### Установка

Просто склонируйте текущую версию  ветки master.

### Краткое описание

Все манипуляции проводились на [postgresql](https://www.postgresql.org/) версии 11.x.x, однако всё должно
работать и на младших версиях, вплоть до 9.x.x.

Краткая суть импорта данных заключается в следующем:

1. Импорт данных из *\*.dbf* файлов в postgresql используя утилиту *pgdbf v0.6.2*.
2. Приведение полученной схемы данных в надлежащее состояние, в т.ч. удаление, добавление, изменение типа данных колонок.
3. Удаление исторических записей (оставляется только последняя запись об объекте)
4. Запись всех адресных объектов в одну иерархическую таблицу
5. Приведение типов адресных объектов к типам из справочника SOCRBASE

### Использование

Используемые переменные окружения:

`$POSTGRES_DB` - имя БД, в которую будет осуществлён импорт

`$POSTGRES_USER` - имя юзера, от имени которого будет осуществлён импорт

`$POSTGRES_PASSWORD` - пароль для `$POSTGRES_USER` к БД

`$POSTGRES_HOST` - хост БД

`$POSTGRES_PORT` - порт БД

`$PATH_TO_DBF_FILES` - абсолютный путь к файлам *\*.dbf*

По умолчанию переменные окружения не задаются, их необходимо указать самостоятельно.
Пример инициализации в скрипте variables.sh

Алгоритм действий:

1. Развернуть БД postgres. Это можно сделать с помощью
[docker-compose.yml](https://github.com/Hedgehogues/fias2pgsql/blob/master/docker-compose.yml), который присутствует в
репозитории или непосредственно поднять БД руками. Для того, чтобы воспользоваться *docker-compose*, потребуется
[docker](https://www.docker.com/) и [docker-compose](https://docs.docker.com/compose/install/). После установки следует запустить контейнер с postgres-11:

```
    docker-compose up
```

*Замечание*: настоятельно рекомендуется отказаться от использования докера на боевом сервере для базы. Если
всё-таки принято решение использовать докер, ознакомьтесь с [этим](https://ru.stackoverflow.com/questions/712931/%D0%97%D0%B0%D0%BF%D1%83%D1%81%D0%BA-postgresql-%D0%B2-docker/779716#779716) и
[этим](https://toster.ru/q/534239) материалами. В данном случае докер — возможность быстро опробовать наши утилиты.

2. Вам также потребуется клиент к postgres-11, pgdbf:

```
    sudo apt-get install postgresql-client pgdbf
```

В результате, будет доступна утилита `psql`. Присоединиться к БД можно так:

    psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB

3. Скачать [архив](https://fias.nalog.ru/Updates.aspx) с DBF-файлами сайта ФИАС. Он весит примерно 6 ГБ на момент
обновления
4. Распаковать его в любую директорию

5. Запустить скрипт init.sh. При запуске можно указать список регионов для загрузки, список типов адресных объектов для загрузки, список справочников для загрузки
```
    ./init.sh "01 02" "ADDROB STEAD HOUSE ROOM" "SOCRBASE ESTSTAT STRSTAT OPERSTAT FLATTYPE ROOMTYPE" - для загрузки всех адресных объектов и справочников 1 и 2 регионов
```
5.1. Скрипт вызовет create_ao.sh и создаст таблицу для всех адресных объектов "AO" (если не существует)
5.2. Вызовет import_dict.sh для загрузки справочников
5.3. Вызовет import_by_region.sh для загрузки адресных объектов
5.4. Скрипт import_by_region.sh вызовет import_ao_by_region.sh для каждого типа адресных объектов
5.5. Скрипт import_ao_by_region.sh для каждого региона импортирует таблицу для заданного типа адресного объекта
5.6. Запустит SQL скрипт трансформации таблицы init_<название типа адресного объекта, например "addrob">.sql
5.7. Загрузит данные в таблицу <название типа адресного объекта, например "addrob">
5.8. Вызовет скрипт приведения адресного объекта к единому формату и фильтрации исторических записей clean_<название типа адресного объекта, например "addrob">.sql
5.9. Добавит записи в таблицу "AO"

```
-- примеры использования скриптов для частичной загрузки
    -- загрузить справочники
    ./import_dict.sh  "SOCRBASE ESTSTAT STRSTAT OPERSTAT"
    
    -- загрузить адресные объекты нескольких типов по регионам
    ./import_by_region.sh  "01 02" "ADDROB HOUSE"
    
    -- загрузить объекты одного типа по регионам
    ./import_ao_by_region.sh  ADDROB "01 02"
    
    -- удалить все созданные таблицы
    ./delete_all.sh
```

6. Проверить скорость выполнения следующих запросов::

```
    -- вывести полный адрес
    WITH RECURSIVE child_to_parents AS (
    SELECT ao.* FROM ao
        WHERE guid = '0c5b2444-70a0-4932-980c-b4dc0d3f02b5'
    UNION ALL
    SELECT ao.* FROM ao, child_to_parents
        WHERE ao.guid = child_to_parents.parentguid
    )

```

### Проблемы и ошибки


