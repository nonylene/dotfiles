import os
import json

SWAP_NUMBERS_SYMBOLS_JSON = '.config/karabiner/assets/complex_modifications/swap_numbers_symbols.json'

file_path = os.path.dirname(__file__)
json_path = os.path.join(file_path, os.pardir, SWAP_NUMBERS_SYMBOLS_JSON)

with open(json_path, 'r') as f:
    dic = json.loads(f.read())

for manipulator in  dic['rules'][0]['manipulators']:
    manipulator['conditions'][0]['bundle_identifiers'].append('^com\\.jetbrains\\.pycharm$')

with open(json_path, 'w') as f:
    json.dump(dic, f)
