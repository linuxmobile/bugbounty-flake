#!/usr/bin/env nu

def main [package] {
    if not ($"pkgs/($package)" | path exists) {
        echo $"Package ($package) not found"
        echo "Available packages:"
        fd --type directory --max-depth 1 . pkgs/ | path basename
        exit 1
    }

    echo $"Updating ($package)..."
    
    let pkg_file = (open $"pkgs/($package)/default.nix")
    
    let owner = ($pkg_file | rg 'owner = "([^"]+)";' -r '$1' | str trim)
    let repo = ($pkg_file | rg 'repo = "([^"]+)";' -r '$1' | str trim)
    
    echo $"Checking for updates to ($owner)/($repo)..."
    
    let tags = (run-external "curl" "-s" $"https://api.github.com/repos/($owner)/($repo)/tags" | complete)
    
    if $tags.exit_code != 0 {
        echo "Failed to fetch tags from GitHub"
        exit 1
    }
    
    let latest_tag = ($tags.stdout | from json | first | get name)
    
    echo $"Latest tag: ($latest_tag)"
    
    let current_version = ($pkg_file | rg 'version = "([^"]+)";' -r '$1' | str trim)
    
    echo $"Current version: ($current_version)"
    
    if $latest_tag == $"v($current_version)" {
        echo "Package is already at the latest version"
        exit 0
    }
    
    let new_version = if ($latest_tag | str starts-with "v") {
        $latest_tag | str substring 1..
    } else {
        $latest_tag
    }
    
    echo $"Updating to version ($new_version)..."
    
    let fetch_expr = $"
    with import <nixpkgs> {};
    fetchFromGitHub {
      owner = \"($owner)\";
      repo = \"($repo)\";
      rev = \"($latest_tag)\";
      sha256 = \"\";
    }
    "
    
    $fetch_expr | save -f fetch-expr.nix
    
    let hash_result = (run-external "nix-build" "fetch-expr.nix" "--no-out-link" | complete)
    rm -f fetch-expr.nix
    
    let new_hash = if $hash_result.exit_code == 0 {
        let prefetch_result = (run-external "nix-prefetch-url" "--unpack" $"https://github.com/($owner)/($repo)/archive/($latest_tag).tar.gz" | complete)
        $prefetch_result.stdout | str trim
    } else {
        $hash_result.stderr | rg 'got:\s+sha256-([A-Za-z0-9+/=]+)' -r '$1' | str trim
    }
    
    if ($new_hash | str length) == 0 {
        echo "Could not extract hash. Running direct prefetch..."
        let prefetch_result = (run-external "nix-prefetch-github" $owner $repo "--rev" $latest_tag | complete)
        let new_hash = ($prefetch_result.stdout | from json | get sha256)
        $new_hash
    }
    
    echo $"New hash: sha256-($new_hash)"
    
    let updated_file = ($pkg_file | lines | each { |line| 
        if ($line | str contains "version = ") {
            $"  version = \"($new_version)\";"
        } else {
            $line
        }
    } | str join "\n")
    
    $updated_file | save -f $"pkgs/($package)/default.nix"
    
    let updated_file = (open $"pkgs/($package)/default.nix" | lines | each { |line| 
        if ($line | str contains "hash = ") {
            $"    hash = \"sha256-($new_hash)\";"
        } else {
            $line
        }
    } | str join "\n")
    
    $updated_file | save -f $"pkgs/($package)/default.nix"
    
    echo "Testing the build..."
    run-external "nix" "build" $".#($package)" "--no-link"
    
    echo $"Successfully updated ($package) to version ($new_version)"
}
