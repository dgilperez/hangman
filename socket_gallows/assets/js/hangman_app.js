import HangmanServer from "./hangman_server"

const RESPONSES = {
    won:          [ "success", "¡Has ganado!" ],
    lost:         [ "danger",  "¡Oooh! Has perdido ..." ],
    good_guess:   [ "success", "¡Bien! ¡Has acertado!" ],
    bad_guess:    [ "warning", "¡Oh - oh! Inténtalo de nuevo ..." ],
    already_used: [ "info",    "Esa ya la has probado" ],
    initializing: [ "info",    "¡A jugar!" ]
}

let view = function(hangman) {
  let app = new Vue({
    el: "#app",
    data: {
      tally: hangman.tally,
    },
    computed: {
      game_over: function() {
        let state = this.tally.game_state
        return (state == "won") || (state == "lost")
      },
      game_state_message: function() {
        let state = this.tally.game_state
        return RESPONSES[state][1]
      },
      game_state_class: function() {
        let state = this.tally.game_state
        return RESPONSES[state][0]
      },
    },
    methods: {
      guess: function(letter) {
        hangman.make_move(letter)
      },
      new_game: function() {
        hangman.new_game()
      },
      already_used: function(letter) {
        return this.tally.used.indexOf(letter) >= 0
      },
      correct_guess: function(letter) {
        return this.already_used(letter) &&
               this.tally.letters.indexOf(letter) >= 0
      },
      turns_gt: function(left) {
        return this.tally.turns_left > left
      },
    }
  })
  return app;
}

window.onload = function() {
  let tally = {
    turns_left: 7,
    letters: [],
    game_state: "initializing",
    used: [],
  }

  let hangman = new HangmanServer(tally)
  let app     = view(hangman)

  hangman.connect_to_hangman()
}
