import os
import sys
import random
import time
import re

def read_photos(directory):
    photos = []
    for filename in os.listdir(directory):
        if re.search(r"\.(jpg|png|svg)$", filename, re.IGNORECASE):
            photos.append(os.path.join(directory, filename))
    return photos

def get_photo(photos):
    choice = random.choice(photos)
    photos.remove(choice)
    return choice

def change_wallpaper(photo):
    os.system(f"pkill swaybg")
    os.system(f"swaybg -i {photo} -m fill &")

def main():
    if len(sys.argv) < 3:
        print('Usage: python autopaper.py [wallpaper_directory] [time_between_wallpaper_change]')
        sys.exit(1)

    directory = sys.argv[1]
    sleep_time = int(sys.argv[2])

    photos = read_photos(directory)
    while True:
        photo = get_photo(photos)
        change_wallpaper(photo)

        if len(photos) == 0:
            photos = read_photos(directory)

        time.sleep(sleep_time)

if __name__ == "__main__":
    main()
