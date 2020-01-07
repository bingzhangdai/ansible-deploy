import argparse
import sys
import os
import glob


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


parser = argparse.ArgumentParser(description='Set necessary vars', epilog="Set both variables and default lower priority variables associated with the roles")
parser.add_argument('-r', '--roles', nargs='+', default=[])
parser.add_argument('--include-default-vars', action='store_true')
parser.add_argument('--group-vars', action='store_true')

if sys.version_info.major == 2:
    input = raw_input

GREEN = '\033[01;32m'
RED = '\033[0;31m'
YELLOW = '\033[1;33m'
NC = '\033[0m'

def main():
    args = parser.parse_args(sys.argv[1:])
    editor = os.getenv('EDITOR')
    if not editor:
        editor = 'vi'
    for role in args.roles:
        if not os.path.exists(f'roles/{role}'):
            eprint(f'{RED}cannot find the role:{NC} {role}')
            sys.exit(-1)
    for role in args.roles:
        print(f'{GREEN}inspecting:{NC} {role}')
        files = glob.glob(f'roles/{role}/vars/**/*.yml', recursive = True)
        if args.include_default_vars:
            files += glob.glob(f'roles/{role}/defaults/**/*.yml', recursive = True)
        if not files:
            print(f'{YELLOW}no variables need to be set for{NC} {role}')
        for file in files:
            input(f'{GREEN}processing vars in file:{NC} {file}')
            os.system(f'{editor} {file}')
    if args.group_vars:
        files = glob.glob(f'group_vars/**/*', recursive = True)
        for file in files:
            input(f'{GREEN}processing group vars in file:{NC} {file}')
            os.system(f'{editor} {file}')


if __name__ == '__main__':
    main()
