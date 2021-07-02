# Project 3 - TWITTER

Twitter is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 15 hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User sees app icon in home screen and styled launch screen
- [X] User can sign in using OAuth login flow
- [X] User can Logout
- [X] User can view last 20 tweets from their home timeline
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] User can pull to refresh.
- [X] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [X] User can compose a new tweet by tapping on a compose button.
- [X] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [X] User should display the relative timestamp for each tweet "8m", "7h"
- [X] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet and favorite.

The following **optional** features are implemented:

- [X] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [X] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [X] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Using delegates in more classes
2. Becoming more comfortable with models and views

## Video Walkthrough

![ezgif com-gif-maker (4)](https://user-images.githubusercontent.com/65196174/124212138-0b17a700-dab4-11eb-9dee-b0113c99df69.gif)

![ezgif com-gif-maker (5)](https://user-images.githubusercontent.com/65196174/124214219-8038ab80-dab7-11eb-9d66-662c3a0fa68e.gif)

![ezgif com-gif-maker (6)](https://user-images.githubusercontent.com/65196174/124213401-179cff00-dab6-11eb-8d12-896a4389ca0f.gif)


## Notes

Challenges building this app:
  - A lot of the instruction was much more hands off than last week's assignment, so I had to recall how to use segue identifiers and use models to abstract away Tweet and User objects. 
  - The retweeting, unretweeting, liking, and unliking functionality gave me some difficulty as I had to change my api call per request. To do this, I looked up the required documentation and changed the network url request to match whichever feature I was implementing. This meant adding a /retweet or /favorite to the url and creating a function for each of the four request types
  - Autolayout on the tweet cell was difficult for me and after the following the tutorial video my constraints still had errors. I ended up having to physically write down each component on a piece of paper and track whether or not I had assigned an x, y, width, and height for every one. This made it much easier for me to keep track of which components were still unassigned and which components were dependent on others. 
  - Using an external Pod/library called DateTools took me a bit to fully understand. My pod install worked correctly, however I forgot to add the library in my projects folder. This then let me add the correct .h file and I ended up with another problem of the .timeAgo function not being allowed. After doing an NSLog of my data I realized I needed to use a dataFormatter on my data because it was being saved in a specific format as a string and needed to be an NSDate. After adding this in I was able to properly view the time ago on each tweet cell. 
  - My biggest issue was adding in the profiles page. I realized early on that I couldn't a segue from an ImageView and had two options: I could either replace the ImageView with a button and redo all of the autolayout OR I could put an invisible button on top of the imageView and figure out the segue logic that way. Due to time constraints I opted with putting an invisible button and worked from there. At the deadline, I wasn't able to completely debug my code. Essentially, the problem was that clicking a button does not trigger the TappedCell request which renders the issue of the segue not knowing exactly which cell you should populate the profile page with. If I had more time, I was refactor my storyboard with an button that has the profile picture as the background image instead of an invisible button overlayed on top. 
  - Time was again a challenge in terms of completing optional tasks, but I feel more prepared and excited to work on my own app
## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright 2021 Dylan Fernandez de Lara

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
