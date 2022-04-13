SRCD = sourceFonts
DIST = dists
TMPD = tmp
VERSION = $(shell date '+%Y%m%d%H%M%S')
all: build

build: download
	@[ -d $(TMPD) ] || mkdir -p $(TMPD)
	@[ -d $(DIST) ] || mkdir -p $(DIST)
	@PYTHONPATH=$(CURDIR)/scripts \
	  python3 -c "import sys;import build; sys.exit(build.build('$(VERSION)'))"

download: dl_agave dl_bizud dl_twemoji dl_icons

dl_agave:
	@[ -d $(SRCD) ] ||  mkdir -p $(SRCD)
	@if [ ! -f $(SRCD)/Agave-Regular.ttf ] ; then\
	  echo "Download Agave" ;\
	  wget https://github.com/blobject/agave/releases/download/v37/Agave-Regular-slashed.ttf \
	    -O $(SRCD)/Agave-Regular.ttf ;\
	  wget https://github.com/blobject/agave/releases/download/v37/Agave-Bold-slashed.ttf \
	    -O $(SRCD)/Agave-Bold.ttf ;\
	fi

dl_bizud:
	@[ -d $(SRCD) ] ||  mkdir -p $(SRCD)
	@if [ ! -f $(SRCD)/BIZUDGothic-Regular.ttf ] ; then\
	  echo "Download Morisawa BIZ UD Gothic" ;\
	  wget https://github.com/googlefonts/morisawa-biz-ud-gothic/raw/v1.002/fonts/ttf/BIZUDGothic-Regular.ttf \
	    -O $(SRCD)/BIZUDGothic-Regular.ttf;\
	  wget https://github.com/googlefonts/morisawa-biz-ud-gothic/raw/v1.002/fonts/ttf/BIZUDGothic-Bold.ttf \
	    -O $(SRCD)/BIZUDGothic-Bold.ttf;\
	fi

dl_twemoji:
	@[ -d $(SRCD) ] ||  mkdir -p $(SRCD)
	@if [ ! -f $(SRCD)/TwitterColorEmoji-SVGinOT-ThickFallback.ttf ] ; then\
	  echo "Download Twitter Color Emoji SVG in OpenType" ;\
          wget https://github.com/eosrei/twemoji-color-font/releases/download/v13.0.1/TwitterColorEmoji-SVGinOT-ThickFallback-13.0.1.zip ;\
          unar TwitterColorEmoji-SVGinOT-ThickFallback-13.0.1.zip ;\
          cp -v TwitterColorEmoji-SVGinOT-ThickFallback-13.0.1/*.ttf $(SRCD)/ ;\
	  rm -fr TwitterColorEmoji-SVGinOT-ThickFallback-13.0.1 ;\
          rm -f TwitterColorEmoji-SVGinOT-ThickFallback-13.0.1.zip ;\
	fi

dl_icons:
	@if [ ! -f $(SRCD)/isfit-plus.ttf ] ; then\
	  wget https://github.com/uwabami/isfit-plus/raw/master/dists/isfit-plus.ttf -O $(SRCD)/isfit-plus.ttf ;\
	fi

clean:
	@rm -f scripts/*.pyc
	@rm -fr scripts/__pycache__

distclean: clean
	rm -fr $(SRCD)/*.ttf
	rm -fr $(SRCD)/*.otf
	rm -fr $(DIST)/*.ttf
	rm -fr $(TMPD)
	rm -fr $(SRCD)
	rm -fr $(DIST)
