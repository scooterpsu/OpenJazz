# OpenJazz makefile

CROSS_COMPILE=mipsel-linux-
CC=$(CROSS_COMPILE)gcc
CXX=$(CROSS_COMPILE)g++
SYSROOT=$(shell $(CC) --print-sysroot)
INCLUDE=$(SYSROOT)/usr/include

include openjazz.mk

OpenJazz: $(OBJS)
	$(CXX) -Wall -I$(INCLUDE) -I$(INCLUDE)/libmodplug -I$(INCLUDE)/SDL $(OBJS) -o OpenJazz -lSDL -lmodplug -lz -lpthread -lstdc++ 

OpenJazz-static: $(OBJS)
	$(CXX) -Wall -I$(INCLUDE) -I$(INCLUDE)/libmodplug -I$(INCLUDE)/SDL $(OBJS) -o OpenJazz -Wl,-Bstatic -lSDL -lmodplug -lz -Wl,-Bdynamic -lpthread -lstdc++ 

%.o: %.cpp
	$(CXX) -Wall -DRS97 -DUSE_MODPLUG -DHOMEDIR -I$(INCLUDE) -I$(INCLUDE)/libmodplug -I$(INCLUDE)/SDL -Isrc -O3 -c $< -o $@
# 
#-DGFX8TO16BIT
#-DUSE_MODPLUG
#-DUSE_SOCKETS

clean:
	rm -f OpenJazz $(OBJS)
