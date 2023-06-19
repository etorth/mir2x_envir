import sys
import chardet
print(chardet.detect(open(sys.argv[1], 'rb').read())['encoding'])
