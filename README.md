# elm-star-rating

## Overview
A simple 5 star rating component. 
Uses radio buttons to represent stars for accessibility.
Uses unicode star characters ★ & ☆ (U+2605 & U+2606) to render stars by default.
Can use custom html elements by using the initialCustomState initializer function

## Usage
 * Add a Rating.State to your model
 * Initialize it with Rating.initialState or Rating.initialCustomState
 * Add a type to your message containing a Rating.Msg
 * Use Html.map with your rating message and Rating.classView or Rating.styleView to render the component
    - Rating.classView takes a list of css class names to style the component
    - Rating.styleView takes a list of css styles (string tuples) to style the component
 * Use Rating.update to update your Rating.State
 
## Example
  - [Example on Ellie-app](https://ellie-app.com/fSjtyPfCCLma1) 
