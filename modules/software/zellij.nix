{pkgs}: let
  zellijConfig = pkgs.writeTextFile {
    name = "zellij-config.kdl";
    text = ''
      themes {
          gruvbox-dark {
              fg "#D5C4A1"
              bg "#282828"
              black "#3C3836"
              red "#CC241D"
              green "#98971A"
              yellow "#D79921"
              blue "#458588"
              magenta "#B16286"
              cyan "#689D6A"
              white "#A89984"
              orange "#D65D0E"
          }
        napalm-green {
              fg "#d5d5ca"
              bg "#0a0f0c"
              black "#1c1c1c"
              red "#e55a4f"
              green "#8dba64"
              yellow "#dba336"
              blue "#6a8cef"
              magenta "#a47de9"
              cyan "#56d9ad"
              white "#a3a39a"
              orange "#e5a55c"
          }
      }

      theme "napalm-green"
      pane_frames false
      copy_on_select false
      default_cwd "./temp"

      keybinds {
          normal {
              bind "Alt h" { MoveFocusOrTab "Left"; }
              bind "Alt l" { MoveFocusOrTab "Right"; }
              bind "Alt j" { MoveFocus "Down"; }
              bind "Alt k" { MoveFocus "Up"; }
              bind "Alt =" { Resize "Increase"; }
              bind "Alt -" { Resize "Decrease"; }
              bind "Alt q" { Detach; }
          }
      }

      on_force_close "detach"

      plugins {
          tab-bar { path "tab-bar"; }
          status-bar { path "status-bar"; }
          strider { path "strider"; }
      }
    '';
  };

  bugBountyLayout = pkgs.writeTextFile {
    name = "bug-bounty.kdl";
    text = ''
      layout {
          default_tab_template {
              pane size=1 borderless=true {
                  plugin location="zellij:tab-bar"
              }
              children
              pane size=2 borderless=true {
                  plugin location="zellij:status-bar"
              }
          }

          tab name="Recon" focus=true {
              pane split_direction="vertical" {
                  pane name="Recon Tools" size="60%" {
                      command "$SHELL"
                      args "-l"
                      cwd "./temp"
                  }
                  pane name="Results" {
                      command "$SHELL"
                      args "-l"
                      cwd "./temp"
                  }
              }
          }

          tab name="Web" {
              pane split_direction="vertical" {
                  pane name="Browser/Burp" size="60%" {
                      command "$SHELL"
                      args "-l"
                      cwd "./temp"
                  }
                  pane name="Notes" {
                      command "nvim"
                      args "./temp/bug-notes.md"
                      cwd "./temp"
                  }
              }
          }

          tab name="Shell" {
              pane {
                  command "$SHELL"
                  args "-l"
                  cwd "./temp"
              }
          }
      }
    '';
  };

  layoutDir = pkgs.runCommand "zellij-layouts" {} ''
    mkdir -p $out/layouts
    cp ${bugBountyLayout} $out/layouts/bug-bounty.kdl
  '';
in {
  config = zellijConfig;
  layoutDir = layoutDir;
}
