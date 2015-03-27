# sketch_3DCube

![alt tag](https://raw.githubusercontent.com/williamahartman/sketch_3DCube/master/processing_cube.gif)

Use the arrow keys to rotate things and the space bar to enable/disable color cycling.

  This is just another little experiment I did a little while ago in Processing. It's a little parallel projection renderer.
  
  This will work fine with any polyhedron or whatever. Models are just stored as an array of faces. Faces are just an array of 3D points. Only wireframe rendering is supported. The program doesn't do anything fancy to figure out which faces are in the back, so it would be pretty tough to add in nicer rendering.
  
  The program uses none of the 3D stuff in processing, just regular 2D lines and trig. The method for converting 3D points to 2D points on the screen is a little atypical. Instead of just ignoring one axis and placing the model at an angle, each axis is viewed in perspective. The axes are at 120 degrees from eachother (so Z points straight up, X goes towards the bottom left, and Y goes towards the bottom right). Points are placed based on a distored grid between these axis.
  
  This is certainly way slower than the normal way, but hey, it was fun to write.
