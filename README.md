# WEB приложение с базовыми CRUD операциями. Маленький блог.

## Модели
 
* User - с полями Имя, Дата регистрации, Количество постов(*)
* Post - с полями Заголовок, Текст, Картинка(*)
* Comment - с полями Оценка (числовое значение 1-5), Текст

## Связи

* Post -> User
* Comment -> Post
* Comment -> User

## HTTP-запросы:

### Запросы для пользователей
* GET /users - список пользователей, с двумя фильтрами (Зарегистрирован после/до, по аналогии с фильтром по цене в различных интернет магазинах) + пагинация

* GET /users/:id - получение конкретного пользователя, со списком его постов и комментариями к каждому посту. 
  Предусмотрена вложенность: User -> Posts -> Comments. Комментарии пользователя вложены в запись его поста.

* POST /users - создание пользователя
* PUT /users/:id - изменение конкретного пользователя
* DELETE /users/:id - удаление конкретного пользователя

### Запросы для постов
* POST /posts - создание поста
* PUT /posts/:id - изменение конкретного поста
* DELETE /posts/:id - удаление конкретного поста

### Запросы для комментариев
* POST /comments - создание комментария
* DELETE /comments/:id - удаление конкретного комментария

## Предусмотренная логика приложения

При удалении поста, все комментарии к нему удаляются.
При удалении пользователя приложение выдает ошибку, если у пользователя есть посты. Другими словами, можно удалить только пользователя без постов.
У всех сущностей все поля являются обязательными.
Предусмотрена валидацию полей на уровне модели.
Реализован счётчик постов у пользователя, который будет увеличиваться или уменьшаться при создании/удалении поста. 
 

## Примечания:

Приложение работает в режиме API only.
Приложение принимает в запросах json, и в отвечает тоже json'ом.
