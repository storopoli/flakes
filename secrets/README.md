# Secrets with YubiKey and `age`

I am using [`ryantm/agenix`](https://github.com/ryantm/agenix) with YubiKey support
([`str4d/age-plugin-yubikey`](https://github.com/str4d/age-plugin-yubikey))
to generate [`age`](https://github.com/FiloSottile/age) secrets.

## Configuring YubiKeys with `age-plugin-yubikey`

Just run `age-plugin-yubikey` and follow the instructions.
This will generate a public/private key pair in one of your
[Personal Identity Verification (PIV)](https://www.yubico.com/authentication-standards/smart-card/) slots.

## Creating Secrets

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
