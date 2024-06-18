import re
from sys import argv

input_file = argv[1]
output_file = argv[2] if len(argv) >= 3 else input_file
output = 'global main\n'

with open(input_file, "r") as file:
    for line in file:
        if not re.match(r'\s+\.[a-z]', line):  # Skip lines starting with directives or comments
            # Replace %gs:QWORD PTR ds:96 with gs:[96]
            line = re.sub(r'%gs:QWORD PTR ds:96', r'gs:[96]', line)
            # Remove comments, paths, PTR, and call __main
            line = re.sub(r'(/.+)|(#.+)|PTR |\s+call\s+__main.*', '', line)
            # Replace movabs with mov and convert decimals to hex
            line = re.sub(r'\b\d+\b', lambda match: hex(int(match.group(0))), line)
            line = re.sub('movabs', 'mov', line)
            
            output += line  # Append modified line to output

with open(input_file, "w") as file:
    file.write(output)
