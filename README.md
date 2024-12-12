# work in progres...

This is an effort to build a portable dev environment that runs inside a docker container.

It is a slightly misguided attempt to have a portable, immutable, and reproducible development environment. With this environment I can have a consistent enviornment with my favorite tools and key binds anywhere that I can access Docker. The setup also contains a simple custom caching web proxy to speed up apt package installation. Locally caching apt packages between environment rebuilds greatly speeds up build times during heavy development on the environment itself.

I run the environment on either Windows laptops or on arch baremetal N100 minipcs.

The environment is Ubuntu based with Sway/Wayland. The GUI can be accessed via VNC through the use of wayvnc.

nvim and kitty come configured.

The Docker-compose file uses "host" networking mode to simplify networking while on WiFi connected laptops.
