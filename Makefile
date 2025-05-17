ifeq ($(STATIC),1)
  PKG_CONFIG_STATIC_FLAG = --static
  CXXFLAGS_ALL += -static
endif

CXXFLAGS_ALL += -MMD -MP -MF objects/$*.d $(shell pkg-config --cflags $(PKG_CONFIG_STATIC_FLAG) sdl2 vorbisfile vorbis) $(CXXFLAGS) 
LDFLAGS_ALL += $(LDFLAGS)
LIBS_ALL += $(shell pkg-config --libs $(PKG_CONFIG_STATIC_FLAG) sdl2 vorbisfile vorbis) -pthread $(LIBS)

SOURCES = \
  RSDKv2/Animation.cpp \
  RSDKv2/Audio.cpp \
  RSDKv2/Collision.cpp \
  RSDKv2/Debug.cpp \
  RSDKv2/Drawing.cpp \
  RSDKv2/Ini.cpp \
  RSDKv2/Input.cpp \
  RSDKv2/main.cpp \
  RSDKv2/Math.cpp \
  RSDKv2/ModAPI.cpp \
  RSDKv2/Object.cpp \
  RSDKv2/Palette.cpp \
  RSDKv2/Player.cpp \
  RSDKv2/Reader.cpp \
  RSDKv2/RetroEngine.cpp \
  RSDKv2/Scene.cpp \
  RSDKv2/Script.cpp \
  RSDKv2/Sprite.cpp \
  RSDKv2/String.cpp \
  RSDKv2/Text.cpp \
  RSDKv2/Userdata.cpp \
  RSDKv2/Video.cpp

	  
ifeq ($(FORCE_CASE_INSENSITIVE),1)
  CXXFLAGS_ALL += -DFORCE_CASE_INSENSITIVE
  SOURCES += RSDKv2/fcaseopen.c
endif

ifeq ($(USE_HW_REN),1)
  CXXFLAGS_ALL += -DUSE_HW_REN
  LIBS_ALL += -lGL -lGLEW
endif

OBJECTS = $(SOURCES:%=objects/%.o)
DEPENDENCIES = $(SOURCES:%=objects/%.d)

all: bin/RSDKv2

include $(wildcard $(DEPENDENCIES))

objects/%.o: %
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS_ALL) -std=c++17 $< -o $@ -c

bin/RSDKv2: $(OBJECTS)
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS_ALL) $(LDFLAGS_ALL) $^ -o $@ $(LIBS_ALL)

install: bin/RSDKv2
	install -Dp -m755 bin/RSDKv2 $(prefix)/bin/RSDKv2

clean:
	 rm -r -f bin && rm -r -f objects
