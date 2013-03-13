# fringear

awesome auburn ambience


## Install
```
npm install
heroku create
```
and you are good to go.

## Configuration
Any evironmental variables you may need to set up are to be put in the `.env` file located in the root directory.

## Running
```
./run
```

It is safest to run this application using the `foreman` environement runner provided by the Heroku toolbelt.
As a shortcut you may use `./run` to run the project. This requires nodemon to be installed either locally or globally.

## Pieces

### Models
Mongoose models live in the `/models` directory.
They are included into the app in the `app.models` object.
This object will act as the container for all the models you create.


Model files export their Schema and a boot() function that accepts the `app` instance.
The model will bind itself to the `app.models` object in this function.

### Controllers
Controllers are included in from the `/controllers` directory.
Each controller file should export an anonamous function that accepts the `app` variable.
The function will then bind all the routes into that `app`.


========

