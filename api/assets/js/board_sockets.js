// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

document.addEventListener("DOMContentLoaded", function(event) {
  let channel                 = socket.channel("board:1", {})
  let boardTestButton        = document.querySelector("#boardTest")


  boardTestButton.addEventListener( 'click', function ( event ) {
    console.log("doing boardTest")
    channel.push("board_test", {body: "board_test"});
  }, false );

  channel.on("board_output", payload => {
    console.log()
    console.log("board_test from server: " + payload.body);
  })

  channel.join()
    .receive("ok", resp => {
      console.log("Joined successfully in board_sockets.js", resp);
      var event = new Event("initBoard");
      event.board = resp.board;
      window.dispatchEvent(event);
   })
    .receive("error", resp => { console.log("Unable to join", resp) })
});

console.log('board_sockets');
document.addEventListener( 'keydown', function(event) {
  console.log('keydown');
  switch( event.keyCode ) {
    case 78: /*I*/
      console.log("pushing board_test");
      channel.push("board_test", {body: "board_test"});
      break;
  }
}, false);


export default socket
