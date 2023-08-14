# F1 Spline Analysis
***An attempt to mathematically model the fastest path around a track using splines.***

## Optimisation Problem Statement:
- Minimum travel time for defined spline.
  - Velocity at each point can be calculated from derivating the spline at each point (Curvature); Smaller radius --> Less Speed
  - Travel time can be calculated from the velocity map.
- **Constraints**
  - Turning Radius < Minimum turning radius
  - Acceleration of body < Maximum acceleration / deceleration
  - Spline must be within the track at all time.

## Work till now:
- Simple prototype to create and save a track. (```map_builder_main```)
- Simple spline control to create and save a path. (```Spline_Test1```)

## How to use.
- The map builder and Spline testing work independently.
- Map Builder:
  1. set ```trackFile``` value to a filename that you'll save the track to. Default to ```track1.txt```.
  2. run the script.
  3. click on the screen to place vertices for the path. Edges are generated between consequtive vertices.
  4. ```q```: toggles between creating the inside edge and outside edge of the track. By default inside edge.
  5. ```z```: Undo last placement on the edge.
  6. ```s```: Save track to file.
- Splines Testing:
  1. set ```trackFile``` as done previously. Ensure file exists in the dir.
  2. run the script
  3. click on the screen to add a new anchor point to path. This generates a new anchor point along with two control points.
  4. Bezier curve is lerped in the following way: anchor1 -> control2 for anchor 1 -> control1 for anchor2 -> anchor2.
  5. All placed points can be clicked and dragged around interactively.
  6. ```q```: Complete the track by connecting the last and first anchors.
  7. ```w```: Toggle being able to add new points to track.  **DEPRECATED**
  8. ```g```: Display Grid.
  9. ```c```: Hide/Show anchor and control points. Always views path.
  10. ```s```: Save path to file
  11. ```r```: Remove all points and start over.
  12. ```z```: Undo last placed point.
