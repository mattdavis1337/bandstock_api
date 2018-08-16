<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/_logo.png">
    <Board msg=""/>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import Board from './components/Board.vue'

export default {
  name: 'app',
  components: {
    HelloWorld,
    Board
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

html, body {
  height: 100%;
  margin: 0;
  padding: 0;
  background-color:#000;
}
</style>
