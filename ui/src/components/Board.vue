<template>
  <div class="board" style="width:60%;margin:0 auto">
  <h1>{{ msg }}</h1>
  <div class="count-section">
  </div>
  <h1 class="title">
  </h1>
  <!-- div class="speed-buttons">
    <button v-for="type in shuffleTypes"
            class="button is-small"
            :class="{ 'is-light': shuffleSpeed != `shuffle${type}` }"
            @click="shuffleSpeed = `shuffle${type}`">
      {{ type }}
    </button>
  </div -->
  <div class="main-buttons">
    <button v-if="isDeckShuffled" @click="displayInitialDeck" class="button is-primary is-outlined">
      Reset <i class="fas fa-undo"></i>
    </button>
    <button @click="shuffleDeck" class="button is-primary">
      Shuffle <i class="fas fa-random"></i>
    </button>
  </div>
  <transition-group :name="shuffleSpeed" tag="div" class="deck"   style="background-color:black">
    <div v-for="card in cards" :key="card.id"
         class="card"
         :class="suitColor[card.suit]">
      <span class="card__suit card__suit--top">{{ card.suit }}</span>
      <span class="card__number">{{ card.rank }} </span>
      <span class="card__suit card__suit--bottom">{{ card.suit }}</span>
    </div>
  </transition-group>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'Board',
    props: {
      msg: String,
      vue: Object
    },
    data: function() {
      return {
        ranks: ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'],
        suits: ['♥','♦','♠','♣'],
        cards: [],
        tiles: [],
        errors: [],
        suitColor: {
          '♠': 'black',
          '♣': 'black',
          '♦': 'red',
          '♥': 'red',
        },
        shuffleSpeed: 'shuffleMedium',
        shuffleTypes: ['Slow', 'Medium', 'Fast'],
        isDeckShuffled: false,
        shuffleCount: 0,
      }
    },
    created() {
      this.displayInitialDeck();
      this.loadTiles();
    },
    methods: {
      loadTiles() {
        axios.get(`http://localhost:4000/api/tiles`)
        .then(response => {
          // JSON responses are automatically parsed.
          this.tiles = response.data.data

          for( let i = 0; i < this.tiles.length; i++ ) {
            let card = {
              id: "tile" + this.tiles[i].id,
              rank: this.tiles[i].name,
              suit: this.tiles[i].hash
            }
            this.cards.push(card);
          }
        })
        .catch(e => {
          console.log(e);
          this.errors.push(e)
        })
      },
      displayInitialDeck() {
        let id = 1;
        this.cards = [];

        for( let s = 0; s < this.suits.length; s++ ) {
          for( let r = 0; r < this.ranks.length; r++ ) {
            let card = {
              id: id,
              rank: this.ranks[r],
              suit: this.suits[s]
            }
            this.cards.push(card);
            id++;
          }
        }

        this.isDeckShuffled = false;
        this.shuffleCount = 0;
      },
      shuffleDeck() {
        for(let i = this.cards.length - 1; i > 0; i--) {
          let randomIndex = Math.floor(Math.random() * i);

          let temp = this.cards[i];
          this.$set(this.cards, i, this.cards[randomIndex]);
          this.$set(this.cards, randomIndex, temp);
        }

        this.isDeckShuffled = true;
        this.shuffleCount = this.shuffleCount + 1;
      }
    }
  }
</script>

<style scoped>
  @import url("https://fonts.googleapis.com/css?family=Roboto+Slab:300,400,700");
  @import url("https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css");
  @import url("https://use.fontawesome.com/releases/v5.0.6/css/all.css");

  html, body, #app {
    height: 100%;
    background: ghostwhite;
  }

  .board {
    background-color:black;
  }

  .title {
    font-family: Roboto Slab, sans-serif;
    text-align: center;
    padding-top: 30px;
    margin-bottom: 0 !important;
    font-weight: 300;
    font-size: 3rem;
  }

  .vue-logo {
    height: 55px;
    position: relative;
    top: 10px;
  }

  .speed-buttons {
    text-align: center;
    padding-top: 30px;
  }
  .speed-buttons .button {
    height: 2.50em;
  }

  .main-buttons {
    display: block;
    margin: 0 auto;
    text-align: center;
    padding-top: 30px;
    margin-bottom: 0 !important;
  }

  .count-section {
    position: absolute;
    top: 10px;
    right: 10px;
  }

  .fas {
    padding-left: 5px;
  }

  .deck {
    margin-left: 30px;
    padding-top: 30px;
  }

  .card {
    width: 75px;
    height: 100px;
    float: left;
    margin-right: 5px;
    margin-bottom: 5px;
    border-radius: 2px;
    border: 1px solid #666;
    background-color:black;
  }

  .card__suit {
    width: 100%;
    display: block;
  }

  .card__suit--top {
    text-align: left;
    padding-left: 5px;
  }

  .card__suit--bottom {
    position: absolute;
    bottom: 0px;
    text-align: left;
    transform: rotate(180deg);
    padding-left: 5px;
  }

  .card__number {
    width: 100%;
    position: absolute;
    top: 38%;
    text-align: left;
  }

  .red {
    color: #6e3d34;
  }

  .black {
    color: #D4AF37;
  }

  .twitter-section {
    position: absolute;
    bottom: 10px;
    right: 10px;
  }
  .twitter-section .fa-twitter-square {
    color: #00d1b2;
    font-size: 30px;
  }

  .shuffleSlow-move {
    transition: transform 2s;
  }

  .shuffleMedium-move {
    transition: transform 1s;
  }

  .shuffleFast-move {
    transition: transform 0.5s;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }

  .fade-enter, .fade-leave-to {
    opacity: 0;
  }

  @media (max-width: 1210px) {
    .deck {
      position: initial;
      top: 0;
    }

    .twitter-section {
      display: none;
    }
  }

</style>
