shallot image for docker

This image provide a shallot binary with predefined params and continuos
execution.

# Usage

Simple:

    $ docker run -it --rm -v $(pwd)/results:/data -e PATTERN="^mysite" exoslpm/shallot

This will to generate files in `./results` with the format
`{timestamp}.{nanoseconds}` with the onion and private key.

## ENV vars

### PATTERN

The pattern to generate, by default use `^test` for testing, for more
information about shallot check [the repo](https://github.com/katmagic/Shallot).

### THREADS

Number of CPU's/cores to use, by default use all.

### OUTPUT

Output pattern, use a command like `/data/\$(date +%s)`, by default use
`/data/\$(date +%s.%N)`.

You can used `/dev/stdout` too.

### EXTRA_PARAMS

Add extra params to shallot command.

# Build 

To build it yourself, clone the repository and run docker build:

    $ git clone https://github.com/exos/docker-shallot.git
    $ cd docker-shallot
    $ docker build -t shallot .

## Build ARGS

### VERSION

Use `VERSION` argument to build a particular version of shallot, for example:

    $ docker build --build-arg VERSION=0.0.2 -t shallot .


