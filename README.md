# Illuminate Wisconsin
This repo houses the code for [our digital lighthouse
experience](https://illuminate-wisc.github.io/Lighthouse).


## About
At its core, the experience uses the [Godot game
engine](https://godotengine.org) for control-flow, state management, and
rendering scenes to the screen.

As with all Godot apps, our project uses scenes to logically group nodes (i.e.,
the 3D assets on the screen, the UI, sound players, etc.) which we then compose
to create the different rooms you see in the experience. Some of these nodes
also have scripts attached to them, which allow us to imbue them with dynamic
behaviors (e.g., animation or interactivity).

For more details on how Godot apps work, check out Godot's [getting started
page](https://docs.godotengine.org/en/stable/getting_started/introduction/index.html).

### Custom Technology

#### Focus Observers
Users interact with the experience mostly by looking at special objects in
scenes and then pressing a key or the mouse. Focus Observers are the technology
we set up to facilitate this interaction.

In a nutshell, a Focus Observer works by taking a ray cast from where the user
is looking, seeing if the ray cast hits any special objects in the world, and,
if it hits one, then triggering these special objects to emit a signal that we
listen for and handle accordingly.

This is what allows us to have the floating navigation arrows and
point-of-interest question marks.


#### Point of Interest Text Box
When users interact with points of interest, a text box appears at the bottom of
the screen and gets filled with relevant text about the point of interest. This
process involves loading the text about each point of interest from a JSON file
then dynamically inserting this text into the text box. The text box then nicely
displays the text gradually to not overwhelm the user.


#### Continuous Deployment
You may have noticed that we've deployed our experience to the internet
(https://illuminate-wisc.github.io/Lighthouse) using
GitHub Pages.

To accomplish this, we set up a GitHub workflow that automatically builds and
deploys the experience to GitHub Pages. This automation required us to create a
bespoke Docker image containing all the necessary tools to build the project and
a service worker to enable Cross-Origin Isolation, which Godot needs to run in
web browsers.


## Getting Started
Once you've set up the Godot game engine (see how to
[here](https://godotengine.org/download/)), clone this repository to your
machine. Then, open the `project.godot` file with Godot, and you're set!

**Note:** these steps only let you run the project in "development". If you want to
export the project to share with other people (who don't want to set up the
Godot game engine to run it), follow [these
steps](https://docs.godotengine.org/en/stable/tutorials/export/exporting_projects.html)
on how to export the experience
to various platforms.


## Features
- User can rotate 360º and look up and down
- World navigation with arrow nodes
- Four functional, decorated interior/exterior lighthouse scenes
- Seven points of interests with relevant information
- Audio feedback from user interaction


## Future Features
- Create additional rooms with relevant points of interest
- Add more decorations to each scene
- Enable 3D shadows (available in browsers now with Godot 4.2)
- Volume options in the settings menu
