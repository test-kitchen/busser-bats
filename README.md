# busser-bats

[![Gem Version](https://badge.fury.io/rb/busser-bats.svg)](https://badge.fury.io/rb/busser-bats)

A [Busser](https://github.com/test-kitchen/busser) runner plugin that runs
[Bats](https://github.com/bats-core/bats-core) test files.

Bats is a TAP-producing test harness for bash. This plugin vendors a copy of it,
installs that copy onto the machine under test during postinstall, and then runs
it against the suite's `bats` directory — so the machine under test needs
nothing beyond bash.

The vendored copy is [bats-core](https://github.com/bats-core/bats-core), which
is the maintained fork; `vendor/bats/VERSION.txt` records the exact release.
`rake bats:vendor` refreshes it, and `BATS_VERSION` selects a different tag.

## Status

This software project is no longer under active development as it has no active
maintainers. The software may continue to work for some or all use cases, but
issues filed in GitHub will most likely not be triaged. If a new maintainer is
interested in working on this project please come chat with us in #test-kitchen
on Chef Community Slack.

## Requirements

Ruby 3.2 or newer, and busser 0.9.0 or newer.

## Installation

Busser installs the plugin for you when Test Kitchen runs the suite, so there is
usually nothing to do. To install it by hand:

```bash
busser plugin install busser-bats
```

## Usage

Put your `.bats` files in the `bats` directory of a suite:

```text
test
`-- integration
    `-- default          # suite name
        `-- bats
            `-- default.bats
```

The whole directory is handed to `bats`, which picks up every `*.bats` file in
it. A test is a `@test` block, and it passes when every command in it succeeds:

```bash
@test "foobar.txt was created" {
  run cat /usr/local/foobar.txt
  [ "$status" -eq 0 ]
  [ "$output" = "hello" ]
}
```

See the [Bats documentation](https://bats-core.readthedocs.io) for the full
assertion and helper vocabulary.

Test Kitchen picks the plugin up from the suite directory name — no verifier
configuration is needed beyond the default busser verifier.

## Using it with Test Kitchen

This is how most people run it, and it needs no Busser commands of your own.
Select the verifier in `kitchen.yml`:

```yaml
verifier:
  name: busser

suites:
  - name: default
```

Then put your tests in a `bats` directory inside the suite:

```text
test/integration/default/bats/default.bats
```

`kitchen verify` installs Busser and this plugin on the instance and runs them.
The directory name is what selects this plugin -- there is nothing else to
configure.

## When nothing runs

If the suite files do not match what this plugin looks for, the run prints one
line and **exits `0`**:

```text
-----> Running bats test suite
```

No tests ran, and nothing said so. Work through these in order:

1. **Is the directory named `bats`?** That name alone selects this plugin.
   `batss/`, `tests/` or anything else is not picked up.
2. **Do the filenames match?** Every `*.bats` file in the directory is run
   -- `smoke.sh` is *not* picked up.
3. **Is the plugin installed?** `busser plugin list` shows what is available.
4. **Is `BUSSER_ROOT` what you think?** `busser suite path` prints where suites
   are actually being looked for.

## Contributing

Bug reports and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md) for how to set up the project, run the test
suite, and format your commits.

## License

Apache License 2.0. See [LICENSE](LICENSE).

The vendored copy of Bats is released under an MIT-style license, copyright Sam
Stephenson and the bats-core contributors.

Originally created by [Fletcher Nichol](https://github.com/fnichol).
