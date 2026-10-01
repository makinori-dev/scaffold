# Scaffold

This is a minimal sample project integrated with the **makinori** framework.

## Quickstart

To get started, you will need the following prerequisites:

1. [git](https://git-scm.com/),
1. [make](https://www.gnu.org/software/make/), and
1. [CMake](https://cmake.org/).

Afterwards, you can run `make` to produce the `manage` executable. Use it like so:

```sh
$ ./manage -c configs/debug.lua run
```

## Documentation

If interested in building documentation locally, install
[Sphinx](https://www.sphinx-doc.org/en/master/). Then run the following:

```sh
$ make docs
$ ./docs
```
