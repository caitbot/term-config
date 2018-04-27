import os
import shutil
import sys

SOURCE_DIR = os.getenv('HOME')
BACKUP_DIR = 'files'
FILES = ['.hyper.js', '.bash_profile', '.bashrc']


def touch(path):
    with open(dest_file, 'a'):
        os.utime(dest_file, None)


if __name__ == '__main__':
    if len(sys.argv) > 1:
        arg = sys.argv[1]
        print('Mode: {}'.format(arg))
        src = SOURCE_DIR if arg == 'save' else BACKUP_DIR
        dest = BACKUP_DIR if arg == 'save' else SOURCE_DIR
        for file_name in FILES:
            src_file = src + '/' + file_name
            dest_file = dest + '/' + file_name
            if os.path.isfile(src_file):
                if not os.path.isfile(dest_file):
                    touch(dest_file)
                shutil.copyfile(src_file, dest_file)


