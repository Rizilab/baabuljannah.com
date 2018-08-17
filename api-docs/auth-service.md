## PATCH /api/v1/auth/edit

### Authentication

This part of the API is protected by JSON Web Tokens ([JWTs](https://en.wikipedia.org/wiki/JSON_Web_Token))


Clients must supply the following data
A JWT Token signed with this server's key


### Request:

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"username_id":"CobaUser","username_pass":"CobaPassword"}
    ```

### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"patch_message":"Mengubah data telah berhasil","patch_date":"2018-04-24T00:55:25Z"}
    ```

## GET /api/v1/auth/user

### Authentication

This part of the API is protected by JSON Web Tokens ([JWTs](https://en.wikipedia.org/wiki/JSON_Web_Token))


Clients must supply the following data
A JWT Token signed with this server's key


### Request:

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"user_role":"Member","user_id":"12","user_name":"CobaUser"}
    ```

### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"detail_login":"CobaUser","detail_profile":{"user_role":"Member","user_id":"12","user_name":"CobaUser"}}
    ```

## POST /api/v1/login

### Request:

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"username_id":"CobaUser","username_pass":"CobaPassword"}
    ```

### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"user_jwt":"Bearer 1231823776123hhatoeud9123792837914","user_profile":{"user_role":"Member","user_id":"12","user_name":"CobaUser"}}
    ```

## POST /api/v1/register

### Request:

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"user_fcard":"5141495847","user_phone":"081767637267","user_birthdate":"1996-10-25","user_cred":{"username_id":"CobaUser","username_pass":"CobaPassword"}}
    ```

### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

    ```javascript
{"registration_date":"2018-04-24T00:55:25Z","registration_message":"Selamat CobaUser telah berhasil didaftarkan"}
    ```

