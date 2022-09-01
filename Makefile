.PHONY: all mount cap clean
FN=24
DFLAGS = '$$fn=$(FN)'

all: mount cap

%.stl: %.scad
	openscad $< -D ${DFLAGS} -o $@

mount: mount.stl

mount_ubolt: mount_ubolt.stl

cap: cap.stl

clean:
	rm -f *.stl *.gcode
