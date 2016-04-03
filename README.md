# Software
Jekyll webserver/blogging platform dockerized with a shared volume to the host

## Installation

The `start.sh` supposes that the directory that will contain your blog data is in **$HOME/blog/data** and the port number that makes the main page accessible is **80**. Edit at your convenience in the `start.sh` file. 
```
git clone https://github.com/sofianinho/jekyll.git
cd jekyll
chmod +x start.sh
./start.sh
```

## Usage

You have to add files inside you data directory in **_posts** to see them in your main page at: (`localhost:80` or simply `localhost`).

