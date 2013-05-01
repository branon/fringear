# Aurburn Ambiance

A mobile application that utalizes the sounds of Aubrun Avenue, along with user location tracking to guide individuals down the avenue and to engage users in an auditory, historical experience. As users move throughout the avenue, ambient sounds are presented, simulating the auditory experience of those who walked the avenue in its bustling past. Relevant voiceovers and textual information are also presented to the explorer as they reach destinations of noted historical significance, making for a truly immersive auditory adventure along Auburn Avenue.

## Dependancies
* Node.js >= 0.8.14
* Heroku toolbelt (https://toolbelt.heroku.com/)[toolbelt.heroku.com]

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

## Notes on Argon
While the Argon system is looking quite promising, Auburn Ambiance does not leverage many of the visual aspects the argon browser is built for. This augmented experience is an audio one, leveraging mainly GPS / Compass and Audio APIs, leaving the camera unused completely (at this time).

Because of this, the Argon AR Browser would not afford us and advantages above the default Safari browser shipped with all iPhones and iPods. Additionally, many phones including Android and Windows phones have browsers capable of supplying the application with the nessisary APIs, allowing for the application to be run on many phones.

The page is still built to be Argon compatable (it can load in the Argon Browser and contains the proper meta tags), but is not limited to being viewed in Argon.

## Basic file archetecture
### Views
For this application, there is only one main view file. This file is located at `/views/index.ejs`

### Javascripts
This is where the buildout of the application can become a little more complicated to trace. Aubrun Ambiance uses (http://backbonejs.org/)[Backbone.js] and (http://coffeescript.org/)[CoffeeScript] for the main javascript components. Backbone allows us to sepreate out the client-side controlers, models, and views, thus greatly simplifying the code development process. CoffeeScript allows us to write .. what some may call JavaScript shorthand, using simplified and enhanced syntax.

All the javascript files can be found in `public/scripts`.

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

