# Command Line Interface Chess

This is a simple implementation of chess in command line interface (not so polished yet like a ruby) written exclusively on ruby.

### Usage

Use the `bundle` gem in ruby to run the program as there is already a `Gemfile` containing all the dependencies.

```cli
bundle exec ruby main.rb
```

To properly run the program, you need a true color terminal.

### Features

- [x] A simple `UI` in the command line interface. 
- [x] Collision handlings.
- [x] Correct captures and setting the bounds.
- [x] Save and reload feature.
- [x] Correct icons and ease of playing.
- [x] Checkmate, stalemate and other win conditions.
- [x] Files serializations.
- [x] Added tests.

### Planned to be implemented

- [ ] More beautiful `UI`.
- [ ] Reduction of loops used, improve overall code quality, try to reduce perceived complexity of the overall program.
- [ ] Knight Promotions.
- [ ] Special moves like En passant.
- [ ] Castling of king with the rook.
- [ ] More tests to encapsulate all behavior.
