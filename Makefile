all : rawdraw ogltest

#for X11 consider:             xorg-dev
#for X11, you will need:       libx-dev
#for full screen you'll need:  libxinerama-dev libxext-dev
#for OGL You'll need:          mesa-common-dev libglu1-mesa-dev

#-DRASTERIZER
#  and
#-CNFGOGL
#  are incompatible.


MINGW32:=/usr/bin/i686-w64-mingw32-

rawdraw.exe : rawdraw.c CNFGFunctions.c CNFGWinDriver.c CNFG3D.c
	$(MINGW32)gcc -m32 -o $@ $^  -lgdi32

rawdraw_egl : rawdraw.c CNFGFunctions.c CNFGEGLDriver.c CNFG3D.c
	gcc -o $@ $^ -lMali -lpthread -lm -O3

rawdraw : rawdraw.c CNFGFunctions.c CNFGXDriver.c CNFG3D.c
	gcc -o $@ $^ -lX11 -lm -lpthread -lXinerama -lXext -lGL -g -DRASTERIZER

rawdraw_ogl : rawdraw.c CNFGFunctions.c CNFGXDriver.c CNFG3D.c
	gcc -o $@ $^ -lX11 -lm -lpthread -lXinerama -lXext -lGL -g -DCNFGOGL

osdtest : osdtest.c CNFGFunctions.c CNFGXDriver.c
	gcc -o $@ $^ -lX11 -lm -lpthread -lXinerama -lXext -DHAS_XINERAMA -DHAS_XSHAPE


ontop : ontop.c CNFGFunctions.c CNFGXDriver.c
	gcc -o $@ $^ -lpthread -lX11 -lm -lXinerama -lXext -lGL

rawdraw_mac : rawdraw.c CNFGFunctions.c CNFGCocoaDriver.m CNFG3D.c
	gcc -o $@ $^ -x objective-c -framework Cocoa -framework OpenGL -lm -lpthread -DRASTERIZER

rawdraw_mac_soft : rawdraw.c CNFGFunctions.c CNFGCocoaNSImageDriver.m CNFG3D.c
	gcc -o $@ $^ -x objective-c -framework Cocoa -lm -lpthread

rawdraw_mac_cg : rawdraw.c CNFGFunctions.c CNFGCocoaCGDriver.m CNFG3D.c
	gcc -o $@ $^ -x objective-c -framework Cocoa -framework CoreGraphics -framework QuartzCore -lm -lpthread

rawdraw_mac_ogl : rawdraw.c CNFGFunctions.c CNFGCocoaOGLDriver.m CNFG3D.c
	gcc -o $@ $^ -x objective-c -framework Cocoa -framework OpenGL -lm -lpthread -DRASTERIZER

ogltest : ogltest.c CNFGFunctions.c CNFGXDriver.c
	gcc -o $@ $^  -lX11 -lXinerama -lGL   -DCNFGOGL

ogltest.exe : ogltest.c CNFGFunctions.c CNFGWinDriver.c
	$(MINGW32)gcc -o $@ $^ -lgdi32 -lkernel32 -lopengl32 -DCNFGOGL

clean : 
	rm -rf *.o *~ rawdraw.exe rawdraw ontop rawdraw_ogl rawdraw_mac rawdraw_mac_soft rawdraw_mac_cg rawdraw_mac_ogl ogltest ogltest.exe rawdraw_egl

