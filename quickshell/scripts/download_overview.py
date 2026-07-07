import urllib.request
import zipfile
import os

url = "https://github.com/Shanu-Kumawat/quickshell-overview/archive/refs/heads/main.zip"
zip_path = "/home/boing/.config/quickshell/overview.zip"
extract_path = "/home/boing/.config/quickshell/"

urllib.request.urlretrieve(url, zip_path)

with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(extract_path)

os.rename(os.path.join(extract_path, "quickshell-overview-main"), os.path.join(extract_path, "overview"))
os.remove(zip_path)
print("Done!")
