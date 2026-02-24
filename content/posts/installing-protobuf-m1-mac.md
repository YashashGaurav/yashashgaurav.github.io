---
title: "Installing Protobuf Compiler on M1 Mac"
date: 2022-07-07
draft: false
tags: ["Protobuf", "Homebrew", "M1 Mac"]
categories: ["Programming"]
author: "Yashash Gaurav"
showToc: true
description: "Step-by-step guide to installing the Protocol Buffers compiler from source on Apple M1 Macs."
cover:
  image: "/images/posts/installing-protobuf-m1-mac_cover.png"
  alt: "Protocol Buffers logo"
---

## Prerequisites

Make sure you have Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow [Saurabh Bajaj's Homebrew setup guide](https://sourabhbajaj.com/mac-setup/Homebrew/) for a complete Mac dev environment setup.

Add Homebrew to your path by adding this to `~/.zshrc` and `~/.bash_profile`:

```bash
PATH="/usr/local/bin:$PATH"
```

## Install Protobuf from Source

Restart your terminal instance and run:

```bash
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf
brew install autoconf automake libtool
autoreconf -i
./configure --prefix=/opt/usr/local
make
make install
```

## Final Configuration

Add this to your `~/.zshrc` too:

```bash
PATH=/opt/usr/local/bin:$PATH
```

Restart your terminal and verify the installation with `protoc --version`.
