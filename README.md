# cube-create

A bash script to create a development environment in [toolbox/toolbx](https://containertoolbx.org/) based off the Fedora toolbox image.

Designed for use on a Fedora Silverblue/Kinoite system, but any system with toolbox should work (untested).

Dependencies:
- toolbox
- podman

Installed CLI programs:
- [Helix Editor](https://helix-editor.com/)
    - with LSPs for HTML, JS, TS
- [Flutter](https://flutter.dev/) (and its dependencies for Linux app development)
- [Go](https://go.dev/)

Defaults:
- Output toolbox image is cube:39
- Temporary toolbox container name for creating the image is cube-create

Scripts:
- cube-create: The acutal script
- cube-reset: Stops and deletes the cube container
