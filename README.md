# 🌋 Magmasnap

**Ultra-minimal snapshot backups** - Perfect for backing up before dangerous git operations!

Copy-paste ready • Zero config • Works anywhere • Just 200 lines of pure bash

> **Quick command:** Use `mgms` instead of `magmasnap` to save typing!

## ⚡ Quick Start

### Option 1: One-Liner Install (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/maximedelvaux/magmasnap/main/install.sh | bash
```

This will:
- Download and install `magmasnap` to `~/bin` or `/usr/local/bin`
- Create `mgms` shortcut (symlink)
- Add to your PATH automatically
- Ready to use immediately: `mgms save`

### Option 2: Manual Download (Copy-Paste Ready)
```bash
curl -O https://raw.githubusercontent.com/maximedelvaux/magmasnap/main/magmasnap
chmod +x magmasnap

# Use it immediately
./magmasnap save
./magmasnap list
./magmasnap restore 1
```

### Option 3: Copy File Manually
Just copy the [magmasnap](magmasnap) file anywhere and run it. That's it!

## ✨ Features

- 🚀 **Zero Config** - Works out of the box, no installation needed
- ⚡ **Fast** - Uses rsync for efficient incremental backups
- 🎯 **Simple** - Core commands: save, list, restore, diff, rm, clean, clear, auto
- 🌍 **Portable** - Single file, works on any Unix system (Linux/macOS/WSL)
- 🏷️ **Tagged Snapshots** - Optional labels for important saves
- 📊 **Diff Support** - See what changed since a snapshot
- 💾 **Size Aware** - Shows snapshot sizes automatically
- 🧹 **Smart Exclusions** - Auto-excludes .git, node_modules, build artifacts
- 🗑️ **Granular Cleanup** - Remove specific snapshots or clean entire projects
- 🤖 **Auto-Snapshot** - Automatic periodic backups while you work

## 📖 Usage

### Save a Snapshot
```bash
mgms save                         # Quick snapshot
mgms save before-rebase           # With descriptive tag
mgms s                            # Ultra-short form
```

### List Snapshots
```bash
mgms list                         # Shows all snapshots with sizes
mgms l                            # Short form
```

Output:
```
📋 Snapshots for my-project:
  1. my-project_20250107_143022_before-rebase (45M)
  2. my-project_20250107_142015 (44M)
  3. my-project_20250107_135530 (43M)
```

### Restore a Snapshot
```bash
mgms restore 1                    # Restore latest (with confirmation)
mgms r 1                          # Short form
```

### See What Changed
```bash
mgms diff 1                       # Compare current state to snapshot #1
mgms d 1                          # Short form
```

### Remove Specific Snapshot
```bash
mgms rm 3                         # Delete snapshot #3
```

### Clean Up Current Project
```bash
mgms clean                        # Delete all snapshots for current project
mgms c                            # Short form
```

### Clear All Snapshots (All Projects)
```bash
mgms clear                        # Delete ALL snapshots from ALL projects
```

### Auto-Snapshot Mode
```bash
mgms auto 3                       # Auto-snapshot every 3 minutes
mgms auto                         # Auto-snapshot every 5 minutes (default)
```
Press `Ctrl+C` to stop. Creates snapshots tagged with `_auto`.

### Configuration
```bash
mgms config                       # View current settings
```

## 🎯 Real-World Examples

### Before Git Rebase
```bash
mgms save before-rebase
git rebase -i HEAD~5
# If something goes wrong:
mgms restore 1
```

### Before Complex Refactoring
```bash
mgms save pre-refactor
# Make your changes...
mgms diff 1                   # See what changed
# If you want to start over:
mgms restore 1
```

### Before Dangerous Operations
```bash
mgms save
rm -rf src/                   # Oops!
mgms restore 1                # Phew! 💨
```

### Experimenting with Code
```bash
mgms save stable-version
# Try experimental changes...
mgms diff 1                   # Review changes
# Keep or revert based on results
```

### Long Coding Session with Auto-Backups
```bash
# Start auto-snapshots in the background
mgms auto 10 &                # Snapshot every 10 minutes
# Work on your code...
# Snapshots happen automatically
# Stop with: kill %1 or Ctrl+C if in foreground
```

## ⚙️ Configuration

Magmasnap works with **zero configuration**, but you can customize it:

### Change Backup Location
```bash
# Default: ~/.magmasnap
export MAGMASNAP_DIR=/mnt/backups/snapshots
```

### Customize Exclusions
Edit the `EXCLUDE_PATTERNS` variable at the top of the script:
```bash
EXCLUDE_PATTERNS=".git node_modules dist build vendor .next target __pycache__"
```

### Install Globally (Optional)
```bash
# Copy to your PATH
sudo cp magmasnap /usr/local/bin/
# Or to user bin
mkdir -p ~/bin
cp magmasnap ~/bin/
export PATH="$HOME/bin:$PATH"
```

## 🛠️ How It Works

- **Snapshots** are stored with timestamps: `project-name_YYYYMMDD_HHMMSS[_tag]`
- **Storage**: `~/.magmasnap/` by default (configurable via `MAGMASNAP_DIR`)
- **Efficiency**: Uses `rsync` for incremental, space-efficient copying
- **Smart**: Auto-excludes `.git`, `node_modules`, `dist`, `build`, and other artifacts
- **Safe**: Always asks for confirmation before restoring

## 📦 What Gets Excluded

By default, magmasnap excludes common build artifacts and dependencies:
- `.git` - Git repository data
- `node_modules` - Node.js dependencies
- `dist`, `build` - Build outputs
- `vendor` - PHP/Composer dependencies
- `.next` - Next.js cache
- `target` - Rust/Cargo builds
- `__pycache__`, `.venv`, `venv` - Python artifacts

This saves **tons of space** and makes snapshots **lightning fast**!

## 🚀 Distribution

Three ways to distribute:

### 1. Copy-Paste (Simplest)
Just copy the `magmasnap` file anywhere and run it. That's it!

### 2. One-Liner Install
```bash
curl -fsSL https://example.com/magmasnap -o magmasnap && chmod +x magmasnap
```

### 3. Global Installation
```bash
sudo install -m 755 magmasnap /usr/local/bin/
```

## 📋 Requirements

- **Bash** shell (pre-installed on Linux/macOS/WSL)
- **rsync** (usually pre-installed, script checks automatically)
- **Unix-like OS** (Linux, macOS, WSL on Windows)

If rsync is missing:
```bash
# Ubuntu/Debian
sudo apt-get install rsync

# macOS (usually built-in)
brew install rsync

# Fedora/RHEL
sudo dnf install rsync
```

## 🆚 Why Magmasnap?

| Feature | Magmasnap | Git Stash | Time Machine | Manual Copy |
|---------|-----------|-----------|--------------|-------------|
| Setup | None | Git only | macOS only | Manual |
| Speed | ⚡⚡⚡ | ⚡⚡⚡ | ⚡ | ⚡⚡ |
| Works Anywhere | ✅ | Git repos only | macOS only | ✅ |
| Multiple Projects | ✅ | Per-repo | System-wide | Manual |
| Tagged Snapshots | ✅ | ✅ | ❌ | Manual |
| Visual Diff | ✅ | ✅ | Limited | ❌ |
| Excludes Build Files | ✅ | ❌ | ❌ | Manual |

**Magmasnap is perfect when you want:**
- Quick snapshots outside of git workflow
- To backup non-git projects
- To save space by excluding build artifacts
- A simple, portable, no-setup solution

## 📄 License

**MIT** - Copy it, modify it, share it, do whatever you want!

## 🤝 Contributing

It's a single ~200-line bash script! Feel free to:
- Fork it and customize
- Submit PRs for improvements
- Create your own variants

Keep it simple, keep it portable, keep it minimal! 🌋

## 💡 Tips

- Use **tags** for important snapshots: `mgms save before-big-refactor`
- Run `mgms diff 1` before restore to see what you'll lose
- Snapshots are **per-project** (based on directory name)
- Set `MAGMASNAP_DIR` to a fast SSD for best performance
- Combine with `watch`: `watch -n 60 'mgms save auto'` for auto-snapshots
- The `mgms` command is just a symlink - both `mgms` and `magmasnap` work!

---

Made with 🌋 for developers who hate losing work
