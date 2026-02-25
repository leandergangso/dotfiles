import subprocess

def main(args):
    command = "curl -sL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin installer=nightly launch=n 2>/dev/null"
    
    print("🚀 Starting kitty nightly update...")
    
    try:
        subprocess.run(command, shell=True, check=True)
        print("✅ Update complete! Please restart kitty to see changes.")
    except subprocess.CalledProcessError as e:
        print(f"❌ Update failed: {e}")
