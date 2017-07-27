# Midi Sequencer

This application is designed to sequence, and output midi data to an external midi instrument, or have it routed to a digital audio workstation such as Ableton. The midi I/O features of this application were handled using Ari Russo's <a href="https://github.com/arirusso/micromidi">MicroMidi</a> gem.

![]()

### Dependencies
* Ruby >= 2.3.1
* Rails >= 5.1.2
* postgres
* bundler

### Installation
```
$ postgres
$ git clone https://github.com/teustice/midi-sequencer
$ cd midi-sequencer
$ bundle install
$ rails db:setup
$ rails db:seed
$ rails s
```

visit <a href="https://localhost:3000">localhost:3000</a> in your browser

### Midi Setup
* Midi channel designation is accessible in the Sequence model.
* Currently the application will use the first Midi I/O that it finds.

### Authors
Tanner Eustice

### License
MIT &copy; 2017
