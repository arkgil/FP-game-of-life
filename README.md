## Game of Life

Implemenation of [Conway's Game of Life]() cellular automaton with browser visualization.

Project for Functional Programming classes.

Project files can be found in `game_of_life` directory. `hs-exercises` contains some Haskell QuickCheck and HUnit exercises.

### Running the project

To run the project, you'll need Elixir >= 1.4.0, Erlang >= 18.3, sbt >= 0.13.0, and NodeJS >= 5.0.0.

In `game_of_life/backend` directory:

```bash
$ mix do deps.get, compile
$ npm install
```

...then in `game_of_life/frontend`:

```bash
$ ./update_frontend.sh
```

...and back in `game_of_life/backend`:

```bash
$ iex -S mix phoenix.server
```

This command will open iex, Elixir interactive shell. Here you can start the visualization, e.g.:

```elixir
## start the visualization
iex> GameOfLife.start GameOfLife.Examples.gosper_glider_gun, 100
## stop the visualization
iex> GameOfLife.stop
```

Now point you browser to `localhost:4000` and enjoy the view :)

`GameOfLife.start/2` accepts two arguments: the first one is a description of initial automaton board -
this is the return value of every function from `GameOfLife.Examples` module; the second one is a time
between automaton transitions in milliseconds.
