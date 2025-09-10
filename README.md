# PscgBuildOS Extra Layers

A place to add more layers and examples to PscgBuildOS.

## Including layers in a build

You can use one of the following options:
* set `config_distro__extra_layers` to the full path of the layer directory you would like to include. Separate each layer path with *space(s)*
* set `config_distro__extra_layers_file` to the full path of a file, containing each layer path on a *line*

You can of course also change the code in PscgBuildOS to include a layer, but it is not recommended. This has been separated out for a reason.

Note: it is also a good place to include some out-of-tree, or staging code.


## Video examples:
- [Adding Realtek 8821cu to *pscg_alpineos*](https://www.youtube.com/watch?v=WfoMf0H3Hag&list=PLBaH8x4hthVysdRTOlg2_8hL6CWCnN5l-&index=113)
