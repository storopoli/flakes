let
  yubikey1 = "age1yubikey1q0t2yru3afkn6y2k79ypedg92ya4gtys39zgap4xe74fuys6puwjkd3nuuq";
  yubikey2 = "age1yubikey1qf85namdsrxlvqvlgxrzcsefxnyem56jenkycxy7du87medwwsp35t3958e";
  keys = [ yubikey1 yubikey2 ];
in
{
  "secrets/reserves1.age".publicKeys = keys;
  "secrets/reserves2.age".publicKeys = keys;
}
