# Project 1 - *Movie Connoisseur (MC)*

**MC** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **6** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] Customize the UI.

The following **additional** features are implemented:

- [x] You can click on image to another view to get more information

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Api to get showtimes
2. Change from table to collectionview

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/n21cws7.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I ran into two big issues making this app. One was the collection view. My first issue was in the storyboard I had to make the size of the collection view less than the screen so all of the items would fit on the screen. The second issue was selecting the (action:) paramater had to be changed for Swift 3.

## License

    Copyright [2017] [Peter Le]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
# Project 2 - *Movie Connoisseur (MC) (Version 2)*

**MC** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **4** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view movie details by tapping on a cell
- [x] User can select from a tab bar for either Now Playing or Top Rated movies
- [x] Customize the selection effect of the cell

The following **optional** features are implemented:

- [x] For the large poster, load the low resolution image first then switch to the high resolution image when complete
- [x] Customize the navigation bar

The following **additional** features are implemented:

- [x] You can see the runtime of the movie
- [x] Customizes tab bar as well
- [x] Made the poster the background of the segue view
- [x] Added blur effect to background to emphasize information

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Customizing tabbar and navbar
2. Change from table to collectionview with button using appdelegate methods

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/Cvxiwtz.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Some issues I ran into was I accidentally put the identifier for the navigation controller on the movie viewcontroller instead. Also I ran into the issue of coloring the navbar and tabbar. I had to go through most of the methods until the colors finally stuck. 

## License

    Copyright [2017] [Peter Le]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

