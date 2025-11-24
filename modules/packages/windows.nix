# Microsoft infrastructure and Windows-related tools, incl. SMB
{pkgs}: let
  evil-winrm-krb = pkgs.evil-winrm.overrideAttrs (oldAttrs: let
    openssl_conf = pkgs.writeText "openssl.conf" ''
      openssl_conf = openssl_init

      [openssl_init]
      providers = provider_sect

      [provider_sect]
      default = default_sect
      legacy = legacy_sect

      [default_sect]
      activate = 1

      [legacy_sect]
      activate = 1
    '';
  in {
    nativeBuildInputs = oldAttrs.nativeBuildInputs or [] ++ [pkgs.makeWrapper];

    postFixup = ''
      ${oldAttrs.postFixup or ""}
      wrapProgram $out/bin/evil-winrm \
        --prefix OPENSSL_CONF : ${openssl_conf} \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [pkgs.krb5]}"
    '';
  });
in
  with pkgs; [
    adidnsdump
    adreaper
    # autobloody
    azurehound
    bloodhound-py
    breads-ad
    certi
    certipy
    certsync
    chainsaw
    coercer
    donpapi
    enum4linux
    enum4linux-ng
    erosmb
    evil-winrm-krb # Use the patched version
    go365
    gomapenum
    kerbrute
    knowsmore
    krb5
    lil-pwny
    nbtscan
    nbtscanner
    offensive-azure
    powerview
    pre2k
    # python314Packages.lsassy (don't build)
    # python314Packages.pypykatz (check later)
    rdwatool
    samba
    sccmhunter
    smbclient-ng
    smbmap
    smbscan
  ]
