# Reaper Auto Render

Render all projects within a directory or only the latest project in each directory. Will use the rendering settings (filename etc) already set up for your Reaper project.

**Usage:**

`./auto-render.sh -s <folder> -p -l | -a`

-s source-directory: The root folder to search recursively for projects (defaults to the current directory)
-a : renders all Reaper projects within the source directory
-l : renders only the latest (by modification date) project in each sub-directory
-p : renders the first 30 seconds of each project, ignore the project's rendering settings

**Example**

Render only the latest project in each sub-folder of "album"

`./auto-render.sh -s ~/Documents/Music/album -l`