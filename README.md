# terraria

Automatically-updated Terraria dedicated server container.

## How to use

__IMPORTANT:__
First, run the container in interactive mode to create your first world:
```
docker run -it --rm -v terraria:/data snw35/terraria
```
Answer the prompts to create your world. Once complete, it will ask you to choose a world, but instead hit 'Ctrl-C' to exit the container.

Now run the container in detached mode with your world selected and a password set:
```
docker run -dit --name terraria -v terraria:/data -p 7777:7777 -e "TERRARIA_WORLD=world1" -e "TERRARIA_PASSWORD=supersecretpassword snw35/terraria"
```

The server will now run in the background and be available on port 7777 with your password required to log in. You will need to forward this port on your router to the machine running the container, or set `TERRARIA_UPNP=1` if your router supports UPNP.

To stop the server, issue a 'docker stop' command, which will gracefully shut it down and allow it to save the world state:
```
docker stop terraria
```

## Docker Compose

An example docker-compose setup using environment variables to configure the server:
```
version: "3.5"
services:
  terraria:
    image: snw35/terraria:latest
    restart: always
    volumes:
      - terraria:/data
    ports:
      - '7777:7777'
    environment:
      - TERRARIA_WORLD=world1
      - TERRARIA_PASSWORD=supersecretpassword
```

## Environment Variables

The container takes the following Environment Variables.

More information on each configuration option can be found at: https://terraria.gamepedia.com/Server

| Variable | Default Value | | Description |
| ---- | ---- | ---- |
| TERRARIA_JOURNEYPERMISSION_BIOMESPREADSETFROZEN | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_GODMODE | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE | 1| 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_TIME_SETNOON | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH | 1 | 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone |
| TERRARIA_LANGUAGE | en/US | Sets the server language from its language code |
| TERRARIA_MAXPLAYERS | 16 | Sets the max number of players allowed on a server. Value must be between 1 and 255 |
| TERRARIA_MOTD | "Welcome to the server!" | Set the message of the day |
| TERRARIA_NPCSTREAM | 0 | Reduces enemy skipping but increases bandwidth usage. The lower the number the less skipping will happen, but more data is sent. 0 is off |
| TERRARIA_PASSWORD | N/A | Set the server password, none if undefined |
| TERRARIA_PORT | 7777 | Set the port number |
| TERRARIA_PRIORITY | 3 | Default system priority 0:Realtime, 1:High, 2:AboveNormal, 3:Normal, 4:BelowNormal, 5:Idle |
| TERRARIA_SECURE | 0 | Adds additional cheat protection (0=off, 1=on) |
| TERRARIA_UPNP | 0 | Automatically forward ports with uPNP (0=off, 1=on) |
| TERRARIA_WORLD | N/A | Name of the world to use for automatic server startup, none if undefined |

## Note on 'autocreate'

The terraria dedicated server supports an 'autocreate' mode, where you can supply defaults that it uses to create a world if it doesn't exist. This doesn't work in my experience and results in null-pointer exceptions, which is why I haven't used it here.
