{pkgs}: let
  zellijConfig = pkgs.writeText "zellij-config.kdl" ''
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
    }

    theme "gruvbox-dark"

    ui {
        pane_frames false
    }

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

  bugBountyLayout = pkgs.writeText "bug-bounty-layout.kdl" ''
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
                }
                pane name="Results" {
                    command "$SHELL"
                    args "-l"
                }
            }
        }

        tab name="Web" {
            pane split_direction="vertical" {
                pane name="Browser/Burp" size="60%" {
                    command "$SHELL"
                    args "-l"
                }
                pane name="Notes" {
                    command "nvim"
                    args "/tmp/bug-notes.md"
                }
            }
        }

        tab name="Shell" {
            pane {
                command "$SHELL"
                args "-l"
            }
        }
    }
  '';

  # Create a directory with the layout file
  layoutDir = pkgs.runCommand "zellij-layouts" {} ''
    mkdir -p $out/layouts
    cp ${bugBountyLayout} $out/layouts/bug-bounty.kdl
  '';
in {
  config = zellijConfig;
  layoutDir = layoutDir;
}
