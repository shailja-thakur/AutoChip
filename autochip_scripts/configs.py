import configparser

config = configparser.ConfigParser()
config.read('config.ini')

def parse_defaults():
    for key in config['DEFAULT']:
        print(key, config['DEFAULT'][key])

def parse_iverilog():
    for key in config['iverilog']:
        print(key, config['iverilog'][key])

def parse_vcs():
    for key in config['vcs']:
        print(key, config['vcs'][key])

def parse_other_compilation_tools():
    for key in config['other compilation tool']:
        print(key, config['other compilation tools'][key])
