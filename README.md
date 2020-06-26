Group 1 Project - README 
===

# TripXperience #
 
## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
The app will allow the user to save information on places they have been, and/or would like to go in the future.

### App Evaluation

- **Category:** Travel / Social / Lifestyle
- **Mobile:** Mobile App only / Mobile first experience
- **Story:** Allows users to write a journal about their trips in text and pictures.
- **Market:** Users can list the places they wish to travel to, and add information about the places they've traveled to.
- **Habit:** Users can share their trips at any given time of the day, (optional) as well as see other people's trips and suggestions of points of interest.
- **Scope:** First we will start with people using this as a personal travel journal, adding things that they liked or want to go back to in the future. Yet, as an optional for the team, we can make this public/sharing platform.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can login
* User can register
* User profile
* User can plan new trips
* User can add photos of the trips they've taken
* User can create journal for trip
* User can view journal for trip

**Optional Nice-to-have Stories**

* User can view other user's trips
* Get suggesting places to visit during the trip
* Geo-caching(?) / Geolocation


### 2. Screen Archetypes

* Login
   * User can login
* Register 
    * User can register
* Stream
    * User can view other user's trips
    * Get suggesting places to visit during the trip
* Detail
    * User can view journal for trip
* Creation
    * User can plan new trips
    * User can add photos of the trips they've taken
    * User can create journal for trip
* Profile
    * User profile
* Maps
    * Geo-caching

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed
* My Trips
* Logout

**Flow Navigation** (Screen to Screen)


* Forced Log-in -> Account creation if no log in is available
* My trips -> Specific trip name
   * If they click the edit button, it would allow them to edit the page
* Add trip -> Add photos from camera roll
    * The users will use a button on the top right hand side to add photos

## Wireframes

<a href="https://ibb.co/b6q8rbH"><img src="https://i.ibb.co/VLrPvwH/IMG-5602.jpg" alt="IMG-5602" border="0"></a>

### [BONUS] Digital Wireframes & Mockups

<img src='https://media.giphy.com/media/ZczhtknUMcKV5Q0BOm/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### [BONUS] Interactive Prototype
https://www.figma.com/file/ecrw1lEfBX7tz5476mINgTaW/Untitled?node-id=2%3A2

## Schema 
[This section will be completed in Unit 9]
### Models

| Property   | Type     | Description |
| --------   | -------- | --------    |
| trip   | Object | List of trips    |
| author     | Pointer to User | Author of post |
| image   | File | image that a user adds to post    |
| createdAt   | Datetime | date when post is created (default field)|
| updatedAt   | Datetime | date when post is last updated (default field)|
| description   | String | description of trip    |


### Networking
[Add list of network requests by screen ]
* Stream (Home Feed Screen)
    * (Read/GET) Query all posts where user is author

       ```swift
       let query = PFQuery(className:"Post")
       query.whereKey("author", equalTo: currentUser)
       query.order(byDescending: "createdAt")
       query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
          if let error = error { 
             print(error.localizedDescription)
          } else if let posts = posts {
             print("Successfully retrieved \(posts.count) posts.")
         // TODO: Do something with posts...
          }
       }
       ```
       
    * (Create/POST) Create a new trip
    * (Delete) Delete existing trip
    * (Create/POST) Create new pictures on trips
    * (Delete) Delete existing photo
* Create Post Screen
    * (Create/POST) Create a new post object
* Profile Screen
    * (Read/GET) Query of user's trips
    * (Update/PUT) Update user story

[Create basic snippets for each Parse network request]
[OPTIONAL: List endpoints if using existing API such as Yelp]

### User Stories
- [x] Log in lay out 
- [x] Register lay out
- [x] Log in takes the user to the main view
- [x] User has two options once being logged in, which are My trip and Add trip


### Progress

Here's a walkthrough for Week 10:

<img src='http://g.recordit.co/bhGuJAoae5.gif' title='Video Walkthrough (Week 10)' width='' alt='Video Walkthrough' />
