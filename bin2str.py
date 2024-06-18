import sys

with open(sys.argv[1], "rb") as file:
    data = file.read()

header = """
unsigned char shellcode[] = """

line_chunk = 16
lines = [[i-line_chunk,i] for i in range(line_chunk, len(data), line_chunk)]
if lines[-1][1] < len(data) - 1:
    lines.append([lines[-1][1], len(data)])


for rang in lines:
    header += "\n\t\""+"\\x" + "\\x".join(map(lambda x: f"{x:02x}", data[rang[0]:rang[1]]))+"\""
header += ";\n"

print(header)
