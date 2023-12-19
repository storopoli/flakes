# Secrets with YubiKey and `age`

I am using [`ryantm/agenix`](https://github.com/ryantm/agenix) with YubiKey support
([`str4d/age-plugin-yubikey`](https://github.com/str4d/age-plugin-yubikey))
to generate [`age`](https://github.com/FiloSottile/age) secrets.

## Configuring YubiKeys with `age-plugin-yubikey`

Just run `age-plugin-yubikey` and follow the instructions.
This will generate a public/private key pair in one of your
[Personal Identity Verification (PIV)](https://www.yubico.com/authentication-standards/smart-card/)
slots.

## Adding Keys to NixOS

Add public keys to your `secrets.nix` file:

```nix
let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILI6jSq53F/3hEmSs+oq9L4TwOo1PrDMAgcA1uo1CCV/";
  users = [ user1 user2 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJDyIr/FSz1cJdcoW69R+NrWzwGK/+3gJpqD1t8L2zE";
  system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  systems = [ system1 system2 ];
in
{
  "secret1.age".publicKeys = [ user1 system1 ];
  "secret2.age".publicKeys = users ++ systems;
}
```

These are the users and systems that will be able to decrypt the `.age` files
later with their corresponding private keys.

## Creating Secrets

create a secret file:

```bash
agenix -e secret1.age -i secrets/identities/age-yubikey-identity-*.txt
```

It will open a temporary file in the app configured in your `$EDITOR` environment variable.
When you save that file its content will be encrypted with
all the public keys mentioned in the `secrets.nix` file.

You can also generate secrets with `age` by listing all the recipients with `-r`.
To generate secrets, run in the root directory of this flake:

```bash
age -r age1yubikey1q0t2yru3afkn6y2k79ypedg92ya4gtys39zgap4xe74fuys6puwjkd3nuuq -r age1yubikey1qf85namdsrxlvqvlgxrzcsefxnyem56jenkycxy7du87medwwsp35t3958e -o secrets/password.age deleteme.txt
```

where the `age1yubikey1q*` are the YubiKey public keys,
`secrets/secret.age` is the desired encrypted secret file output,
and `deleteme.txt` is the unencrypted file.
As the name suggest, DON'T COMMIT this file, and DELETE IT afterwards.

To access secrets, run in the root directory of this flake:

```bash
agenix -d secrets/password.age -i secrets/identities/age-yubikey-identity-*.txt
# or
nix run github:ryantm/agenix -- -d secrets/password.age -i secrets/identities/age-yubikey-identity-*.txt
```

where `secrets/identities/age-yubikey-identity-*.txt` is the path to your YubiKey identity.
You can find these by plugging all your YubiKeys and running:

```bash
age-plugin-yubikey --identity
```

## Editing Secrets

To edit secrets, run in the root directory of this flake:

```bash
agenix -e secrets/password.age -i secrets/identities/age-yubikey-identity-*.txt
# or
nix run github:ryantm/agenix -- -e secrets/password.age -i secrets/identities/age-yubikey-identity-*.txt
```

## Adding YubiKeys

You will need to edit the `secrets.nix` file and add a new `yubikey*`
entry in the `let` block with the value of the public key.

You can find this by plugging your YubiKey and running:

```bash
age-plugin-yubikey --list-all
```

## Using Secrets

Add secret to a NixOS module config:

```nix
{
  age.secrets.secret1.file = ../secrets/secret1.age;
}
```

When the `age.secrets` attribute set contains a secret,
the `agenix` NixOS module will later automatically decrypt
and mount that secret under the default path `/run/agenix/secret1`.
Here the `secret1.age` file becomes part of your NixOS deployment,
i.e. moves into the Nix store.

Reference the secrets' mount path in your config:

```nix
{
  users.users.user1 = {
    isNormalUser = true;
    passwordFile = config.age.secrets.secret1.path;
  };
}
```

You can reference the mount path to the (later) unencrypted
secret already in your other configuration.
So `config.age.secrets.secret1.path` will contain the path
`/run/agenix/secret1` by default.

Also, you can use a whole file as a secret.
For example with a wireguard VPN config:

```nix
environment.etc = {
  # wireguard config used with `wg-quick up wg-example`
  "wireguard/wg-example.conf" = {
    source = config.age.secrets."wg-example.conf".path;
};
```

## Security

[`age` specs](https://github.com/C2SP/C2SP/blob/main/age.md) encripts files using
a 128-bit symmetric file key with `ChaCha20-Poly1305`.
It has tons of stars on GitHub and tons of people and organizations use it.

YubiKey's [Personal Identity Verification (PIV)](https://www.yubico.com/authentication-standards/smart-card/)
uses an Elliptic Curve ECDSA P-256 key as defined in the
[NIST SP 800-73 - “Cryptographic Algorithms and Key Sizes for PIV”](https://csrc.nist.gov/pubs/sp/800/73/final)
(NOTE: NIST SP 800-73 specifies both a RSA and a ECC protocol, however YubiKey uses the ECC).

As explained in [str4d/age-plugin-yubikey#73](https://github.com/str4d/age-plugin-yubikey/issues/73),
these YubiKey identities are "key grips",
encoding a serial number of the YubiKey and some other identifiers,
but no secret bits.
It's fine to display them publicly.

```

```
