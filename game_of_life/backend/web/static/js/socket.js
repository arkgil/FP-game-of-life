import {Socket} from "phoenix"

let socket = new Socket("/socket")

socket.connect()

let channel = socket.channel("visualization", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
                    .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("new:generation", data => {
  console.log("Got new generation", data)
})

export default socket
