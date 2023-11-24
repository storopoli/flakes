{ config, pkgs, lib, ... }:
{
  config = {
    age.secrets.reserves1.file = ../secrets/reserves1.age;
    age.secrets.reserves2.file = ../secrets/reserves2.age;
    age.secrets.luks.file = ../secrets/luks.age;
    age.secrets.password.file = ../secrets/password.age;
  };
}
