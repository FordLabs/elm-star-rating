# elm-star-rating

## Overview
A simple 5 star rating component. 
Uses unicode star characters(U+2605 & U+2606) to render stars.

## Usage
 * Add a Rating.State to your model
 * Initialize it with Rating.initialState
 * Add a type to your message containing a Rating.Msg
 * Use Html.map with your rating message and Rating.classView or Rating.styleView to render the component
    - Rating.classView takes a list of css class names to style the component
    - Rating.styleView takes a list of css styles (string tuples) to style the component
 * Use Rating.update to update your Rating.State
 
## Example
  - Coming soon 
