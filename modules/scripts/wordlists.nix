{pkgs}:
pkgs.writeScriptBin "wordlists" ''
  #!${pkgs.nushell}/bin/nu

  let wordlists_dir = if ($env | columns | any {|it| $it == "WORDLISTS" }) {
    $env.WORDLISTS
  } else {
    "${pkgs.wordlists}/share/wordlists"
  }

  def print_help [] {
    print ""
    print "Wordlists Utility for Bug Bounty Hunting"
    print "========================================"
    print ""
    print "Usage:"
    print "  wordlists list                    - List all wordlist categories"
    print "  wordlists list <category>         - List wordlists in a category"
    print "  wordlists search <pattern>        - Search wordlists by name or content"
    print "  wordlists path <category/file>    - Get full path to a wordlist"
    print "  wordlists preview <category/file> - Preview the first 10 lines of a wordlist"
    print "  wordlists count <category/file>   - Count lines in wordlist(s)"
    print "  wordlists help                    - Show this help"
    print ""
    print "Examples:"
    print "  wordlists list wfuzz              # List files in wfuzz category"
    print "  wordlists search password         # Search for wordlists with 'password' in name"
    print "  wordlists path wfuzz/general/common.txt  # Get path to specific wordlist"
    print ""
  }

  def list [category?: string] {
    if ($category == null) {
      ls -D $wordlists_dir
        | sort-by name
        | each {|dir|
            {
              category: ($dir.name | path basename),
              path: $dir.name,
              count: (ls $dir.name | where type == file | length)
            }
        }
        | sort-by category
        | table -e
    } else {
      let category_path = $wordlists_dir | path join $category

      if not ($category_path | path exists) {
        print $"Category '($category)' not found in ($wordlists_dir)"
        exit 1
      }

      ls $category_path
        | where type == file
        | each {|file|
            {
              filename: ($file.name | path basename),
              size_kb: ($file.size | into float) / 1024 | format "%.2f",
              lines: (open $file.name | lines | length)
            }
        }
        | sort-by filename
        | table -e
    }
  }

  def search [pattern: string, --content(-c), --case-sensitive(-s)] {
    let search_pattern = if $case-sensitive {
      $pattern
    } else {
      $"(?i)($pattern)"
    }

    if not $content {
      print $"Searching for wordlists with '($pattern)' in filename..."

      find $wordlists_dir -type file
        | where name =~ $search_pattern
        | each {|path|
            let rel_path = $path | str replace -r $"^($wordlists_dir)/" ""
            let size_kb = (($path | path stat | get size) / 1024)
            {
              wordlist: $rel_path,
              size_kb: $size_kb | format "%.2f",
              path: $path
            }
        }
        | sort-by wordlist
        | table -e
    } else {
      print $"Searching for wordlists containing '($pattern)'..."
      print "This may take a while for large wordlists..."

      find $wordlists_dir -type file -size -5M
        | where {|path|
            open $path --raw
              | str contains -i $pattern
              | if $case-sensitive {
                  $in
                } else {
                  $in | str downcase | str contains ($pattern | str downcase)
                }
          }
        | each {|path|
            let rel_path = $path | str replace -r $"^($wordlists_dir)/" ""
            let size_kb = (($path | path stat | get size) / 1024)
            {
              wordlist: $rel_path,
              size_kb: $size_kb | format "%.2f",
              path: $path
            }
        }
        | sort-by wordlist
        | table -e
    }
  }

  def path [wordlist_path: string] {
    let full_path = $wordlists_dir | path join $wordlist_path

    if ($full_path | path exists) {
      $full_path
    } else {
      print $"Wordlist '($wordlist_path)' not found in ($wordlists_dir)"
      exit 1
    }
  }

  def preview [wordlist_path: string, --lines(-n): int = 10] {
    let full_path = $wordlists_dir | path join $wordlist_path

    if not ($full_path | path exists) {
      print $"Wordlist '($wordlist_path)' not found in ($wordlists_dir)"
      exit 1
    }

    print $"Preview of first ($lines) lines of ($wordlist_path):"
    print "---------------------------------------------------"
    open $full_path | lines | first $lines
    print "---------------------------------------------------"
  }

  def count [wordlist_path: string] {
    let full_path = $wordlists_dir | path join $wordlist_path

    if not ($full_path | path exists and ($full_path | path type) == "file") {
      let dir_path = $full_path
      if ($dir_path | path exists and ($dir_path | path type) == "dir") {
        ls $dir_path
          | where type == file
          | each {|file|
              let line_count = (open $file.name | lines | length)
              {
                wordlist: ($file.name | path basename),
                lines: $line_count,
                size_kb: ($file.size / 1024) | format "%.2f"
              }
          }
          | sort-by -r lines
          | table -e
      } else {
        print $"Path '($wordlist_path)' not found in ($wordlists_dir)"
        exit 1
      }
    } else {
      let line_count = (open $full_path | lines | length)
      print $"($wordlist_path): ($line_count) lines"
    }
  }

  def main [command?: string, arg?: string, --content(-c), --case-sensitive(-s), --lines(-n): int = 10] {
    if ($command == null) {
      print_help
      exit 0
    }

    match $command {
      "list" => { list $arg },
      "search" => {
        if ($arg == null) {
          print "Error: search requires a pattern"
          print "Usage: wordlists search <pattern> [--content] [--case-sensitive]"
          exit 1
        }
        search $arg --content=$content --case-sensitive=$case-sensitive
      },
      "path" => {
        if ($arg == null) {
          print $wordlists_dir
        } else {
          path $arg
        }
      },
      "preview" => {
        if ($arg == null) {
          print "Error: preview requires a wordlist path"
          print "Usage: wordlists preview <category/file> [--lines <number>]"
          exit 1
        }
        preview $arg --lines $lines
      },
      "count" => {
        if ($arg == null) {
          print "Error: count requires a wordlist path"
          print "Usage: wordlists count <category/file>"
          exit 1
        }
        count $arg
      },
      "help" => { print_help },
      _ => {
        print $"Unknown command: ($command)"
        print_help
        exit 1
      }
    }
  }

  main $rest.0 $rest.1 --content=$rest | any { $it == "--content" } --case-sensitive=$rest | any { $it == "--case-sensitive" } --lines=($rest | each { |v| if ($v | str starts-with "--lines=") { ($v | str replace "--lines=" "") | into int } } | compact | first | default 10)
''
