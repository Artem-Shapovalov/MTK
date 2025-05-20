CXXFLAGS += ${shell fltk-config --cxxflags}
CXXFLAGS += ${shell fltk-config --ldstaticflags}
CXXFLAGS += -I./
CXXFLAGS += -g3 -ggdb

SOURCES += mtk.cpp
SOURCES += font/font_img.cpp
SOURCES += font/font.cpp
SOURCES += images/images_img.cpp
SOURCES += images/images.cpp

STYLE += --max-code-length=80
STYLE += --break-after-logical
STYLE += --style=allman
STYLE += --indent=spaces=2
STYLE += --min-conditional-indent=0
STYLE += --break-blocks
STYLE += --pad-include
STYLE += --delete-empty-lines
STYLE += --align-pointer=type
STYLE += --align-reference=type
STYLE += --break-one-line-headers
STYLE += --add-braces

example: clean doc metrics font images format
	g++ ${SOURCES} mock_lcd.cpp example.cpp -o example ${CXXFLAGS}

doc:
	doxygen

metrics:
	cccc mtk.cpp mtk.hpp --outdir=metrics 2> /dev/null

font: clean imutil
	cd font; ../imutil font ${shell ls font}

images: clean imutil
	cd images; ../imutil images ${shell ls images}

imutil: clean
	g++ imutil.cpp -o imutil

format:
	astyle ${STYLE} ${SOURCES}
	rm -rf *.orig images/*.orig font/*.orig

clean:
	rm -rf imutil
	rm -rf font/font_img.cpp font/font_img.hpp
	rm -rf font/font.cpp font/font.hpp
	rm -rf images/images_img.cpp images/images_img.hpp
	rm -rf images/images.cpp images/images.hpp
	rm -rf metrics
	rm -rf doc html latex
	rm -rf example
