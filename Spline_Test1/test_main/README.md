## How to use
  1. set ```trackFile``` as done previously. Ensure file exists in the dir.
  2. run the script
  3. click on the screen to add a new anchor point to path. This generates a new anchor point along with two control points.
  4. Bezier curve is lerped in the following way: anchor1 -> control2 for anchor 1 -> control1 for anchor2 -> anchor2.
  5. All placed points can be clicked and dragged around interactively.

### Keybinds
- ```q```: Complete the track by connecting the last and first anchors.
- ```w```: Toggle being able to add new points to track.  **DEPRECATED**
- ```g```: Display Grid.
- ```c```: Hide/Show anchor and control points. Always views path.
- ```s```: Save path to file
- ```r```: Remove all points and start over.
-  ```z```: Undo last placed point.
