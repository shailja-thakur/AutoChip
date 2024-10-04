import os

def get_subdirectories(directory):
    subdirs = set()
    for root, dirs, files in os.walk(directory):
        for subdir in dirs:
            subdirs.add(os.path.relpath(os.path.join(root, subdir), directory))
    return subdirs

def main(dir1, dir2):
    subdirs1 = get_subdirectories(dir1)
    subdirs2 = get_subdirectories(dir2)

    only_in_dir1 = subdirs1 - subdirs2
    only_in_dir2 = subdirs2 - subdirs1

    print("Subdirectories in dir1 but not in dir2:")
    for subdir in only_in_dir1:
        print(subdir)

    print("\nSubdirectories in dir2 but not in dir1:")
    for subdir in only_in_dir2:
        print(subdir)

if __name__ == "__main__":
    dir1 = input("Enter the path for dir1: ")
    dir2 = input("Enter the path for dir2: ")
    main(dir1, dir2)

