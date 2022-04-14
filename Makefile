.PHONY: all clean

all:
	$(MAKE) -j1 -C Hanoi
	$(MAKE) -j1 -C Topsort
	$(MAKE) -j1 -C WaterPuzzle

clean:
	$(MAKE) -C Hanoi clean
	$(MAKE) -C Topsort clean
	$(MAKE) -C WaterPuzzle clean
