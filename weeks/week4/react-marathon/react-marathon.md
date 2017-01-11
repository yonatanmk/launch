### Getting Started

This exercise is designed to take you through creating a multi-component stateless app from the ground up, step by step, while collaborating on the creation of components.

### Setup

From your challenges directory, run the following:

```sh
$ et get react-marathon
$ cd react-marathon
$ npm install
$ webpack-dev-server
```
If you go to <http://localhost:8080>, there will be nothing displayed on the page and there should be no errors in your console.

### Step 1

**Note: You will not see your Playlists listed in localhost:8080 until after Step 3**

The first step is to create the architecture for our list of playlists, of which the component will be named `PlaylistCollection` (trust me, this is better than `PlaylistList`). Let's create a `<div>` tag that resides within the div `"App"` in our `App.js` file. This div will contain two things: a header tag indicating that this is the playlist portion of our application, and a `PlaylistCollection` component that has not been created yet, but we will need to pass in `playlists` as a property to the component. These will be set to the playlists from `data` in order to use them in our `PlaylistCollection` component through props.

This portion of the app will take a half of the page, so be sure to give the `<div>` an appropriate class name. (Remember Foundation?)

### Step 2

Let's create our `PlaylistCollection.js` react component in our `src/components` folder of our application. This component will be stateful and also take in `props` passed down from `App.js`. We can now use the data from `playlists` to map out individual `Playlist` components (which we have not created yet) and assign it to a `playlists` React fragment. Each `Playlist` component should have the key and the playlist data passed in as properties. The `PlaylistList.js` component will ultimately return a `<ul>` element that solely returns the `playlists` fragment at the end of the `render()` method.

Don't forget to import react and export PlaylistCollection from this component!

### Step 3

We're going to render a few `Playlist` components in our `PlaylistCollection` component, so now let's build the structure of our `Playlist` component. Create your `/src/components/Playlist.js` file and create a stateful component `Playlist` that will take in `props` and render the name of the playlist in an `<li>` tag.

**Note: After this step, you should see your Playlists listed in localhost:8080**

### Step 4

**Note: You will not see your Songs listed in localhost:8080 until after Step 6**

Now let's work on getting our songs to appear for a given playlist. Let's go back to `src/components/App.js` and prepare our `SongCollection` component, which will be similarly structured like our `PlaylistCollection` component. Keep in mind that these will not be all the songs from data, but only the songs listed in a given playlist. (Can you spot the variable that we can pass into props instead of `data.songs`?)

### Step 5

Continuing with our list of songs, let's now create our `SongCollection` component. This will also take in props given from `App.js`, map them into `Song` components, and return a `<ul>` element with the list of our `Song` components as a React fragment `songs`.

### Step 6

Now let's create our `Song` component. This will be very similar to our `Playlist` component, taking in props and returning an `<li>` element with the respective song name and artist separated by a `-`.

**Note: After this step, you should see your Songs listed in localhost:8080**

### Step 7

We need to visually see which song is being played. This means that in `App.js`, `selectedSongId` should be passed into `SongCollection` from `data` as another property. In `SongCollection.js` in our map function, we have to create a variable `className` and change it to `"selected"` if the song in question's id matches the `selectedSongId`. This variable should be passed into the `Song` component as a property. Finally, the `className` of the `<li>` tag should be set to the className variable passed from `SongList.` If done correctly, you should see the selected song be highlighted at <http://localhost:8080>.

### Step 8

Do the same as Step 7 but with `selectedPlaylistId`

### Step 9

Getting the selected song to be highlighted is pretty cool. But you know what would be even cooler? Let's enable an onClick on each Song so that the highlighted song changes to the song that is clicked.
- In `App.js`, the constructor needs state. This state should contain the `selectedSongId`, which should initially be set to the selectedSongId from data (which is passed down from `props`)
- We need to define a function, `handleSongSelect`, that should take in an id and change selectedSongId in state to that id with `this.setState({})`
- The `handleSongSelect` method should be binded in the constructor.
- We need to modify the props passed into the `SongCollection` component so that the selectedSongId now depends on state instead of props, and the handleSongSelect function should be passed in as another property.
- In `SongCollection.js`, `handleSongSelect` should be defined for each individual song as an arrow function set to the function passed in through props with the song id as the argument.
- `handleSongSelect` now should be passed in to each `Song` component as a property.
- In `Song.js`, the `handleSongSelect` passed down as a property should be set to an `onClick` attribute on the `<li>` tag.

### Step 10

Do the same thing as Step 9 but for changing Playlists! There are two main differences from Step 9.
- `selectedPlaylistSongIds` should depend on state instead of props.
- Changing the `selectedPlaylistId` in state should also cause the `selectedSongId` in state to change, either to a random song from the selected playlist or the first song from the selected playlist (take a look at `constants/data.js` to see where the relationship between songs and playlists exits.)
