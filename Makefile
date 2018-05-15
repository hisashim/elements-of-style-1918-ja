PACKAGE = elementsofstyle

.PHONY: ChangeLog
ChangeLog:
	svn log -rHEAD:0 -v > ChangeLog
	# For real ChangeLog style, try svn2cl.xsl at http://tiefighter.et.tudelft.nl/~arthur/svn2cl/

elementsofstyle.en.html: elementsofstyle.html
	rm -f elementsofstyle.en.html
	ruby -e 'print ARGF.read.gsub(/<([a-z]+) +(?:lang="ja"|title="ja").*?>.*?<\/\1>[\r\n]?/m, "")' elementsofstyle.html > elementsofstyle.en.html
elementsofstyle.ja.html: elementsofstyle.html
	rm -f elementsofstyle.ja.html
	ruby -e 'print ARGF.read.gsub(/<([a-z]+) +(?:lang="en"|title="en").*?>.*?<\/\1>[\r\n]?/m, "")' elementsofstyle.html > elementsofstyle.ja.html

document: ChangeLog elementsofstyle.en.html elementsofstyle.ja.html

clean:
	rm -f ChangeLog
	rm -f elementsofstyle.en.html
	rm -f elementsofstyle.ja.html
