# Firewalk

Firewalk determines which layer-4 protocols a packet-filtering gateway passes.
It sends probes with a TTL one hop past the gateway and analyzes the returning
ICMP messages.

## Build on Linux

```sh
sudo apt install build-essential autoconf automake libpcap-dev libnet1-dev libdumbnet-dev
autoreconf -fi
./configure && make
sudo make install
```

Run `src/firewalk` as root. See `man/firewalk.8` for usage.

## Changes for modern systems

- Replaced `configure.in` with `configure.ac` (current autoconf, no `acconfig.h`) and regenerated the autotools files.
- Detects `libdumbnet` on Debian/Ubuntu, falling back to `libdnet`.
- Standard automake rules: builds `src/firewalk`, installs the binary and man page, and supports out-of-tree builds.
- Source fixes for modern compilers and libnet: explicit system headers, const-correctness, signal handler signatures, and correct `u_long` comparisons.
- Capture retries on `EINTR` and re-arms `select()` each loop; fixed a fallthrough from ICMP into TCP response verification.
- Dropped the obsolete Debian `libdumbnet` patch.

## CI and releases

`.github/workflows/ci.yml` builds, runs `make distcheck`, and packages a `.deb`
in a Debian stable container on every push to `master` and on pull requests.

`.github/workflows/release.yml` runs on any `v*` tag, collects the source
tarball, `.deb`, debug symbols, `.buildinfo`, `.changes`, and `SHA256SUMS`, then
publishes them as a GitHub Release. To cut one, bump `VERSION`, `AC_INIT` in
`configure.ac`, and `debian/changelog`, then tag and push:

```sh
git tag -a v5.0.2 -m "Firewalk 5.0.2" && git push origin v5.0.2
```

<br>
<br>

---

## Original README

```text
===============================================================================
    $Id: README,v 1.2 2002/05/14 23:28:37 route Exp $
    FIREWALK 5.0 (c) 1998 - 2002 Mike D. Schiffman <mike@infonexus.com>
                                 http://www.packetfactory.net/firewalk
===============================================================================


    5.0 README

    Firewalk is now fully and completely documented both in theory, practice
    and line by line of code in my book: "Building Open Source Network Security
    Tools" published by Wiley.  You may pick it up here:
    http://www.amazon.com/exec/obidos/tg/detail/-/0471205443/qid=1035158109/sr=8-1/ref=sr_8_1/102-4873217-0082545?v=glance&n=507846

    More information here:
    http://www.wiley.com/cda/product/0,,0471205443,00.html

    Installation:
    -------------
    You'll need:
    - a recent libpcap release (http://www.tcpdump.org)
    - libnet 1.1.0 or better (http://www.packetfactory.net/libnet)
    - libdnet, packaged as libdumbnet on Debian and Ubuntu
    Build and install these.

    0. nroff -man man/firewalk.8 | less
    1. ./configure && make && make install

    The binary is built as src/firewalk.
    Building from git requires autoconf and automake:
    autoreconf -fi && ./configure && make

EOF
```
