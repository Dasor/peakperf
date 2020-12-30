CXX=gcc

SANITY_FLAGS=-Wall -Wextra -Werror -fstack-protector-all -pedantic -Wno-unused -Wfloat-equal -Wshadow -Wpointer-arith -Wformat=2
CXXFLAGS_GENERIC=-std=c99 -O2 $(SANITY_FLAGS)
CXXFLAGS_LINK=-lm -fopenmp
CXXFLAGS_SANDY_BRIDGE    = -DAVX_256_3_NOFMA -march=sandybridge    $(CXXFLAGS_GENERIC)
CXXFLAGS_IVY_BRIDGE      = -DAVX_256_3_NOFMA -march=ivybridge      $(CXXFLAGS_GENERIC)
CXXFLAGS_HASWELL         = -DAVX_256_10      -march=haswell        $(CXXFLAGS_GENERIC)
CXXFLAGS_SKYLAKE_256     = -DAVX_256_8       -march=skylake        $(CXXFLAGS_GENERIC)
CXXFLAGS_SKYLAKE_512     = -DAVX_512_8       -march=skylake-avx512 $(CXXFLAGS_GENERIC)
CXXFLAGS_BROADWELL       = -DAVX_256_8       -march=broadwell      $(CXXFLAGS_GENERIC)
CXXFLAGS_KABY_LAKE       = -DAVX_256_8       -march=skylake        $(CXXFLAGS_GENERIC)
CXXFLAGS_COFFE_LAKE      = -DAVX_256_10      -march=skylake        $(CXXFLAGS_GENERIC)
CXXFLAGS_CANNON_LAKE_256 = -DAVX_256_10      -march=cannonlake     $(CXXFLAGS_GENERIC)
CXXFLAGS_CANNON_LAKE_512 = -DAVX_256_10      -march=cannonlake     $(CXXFLAGS_GENERIC)
CXXFLAGS_ICE_LAKE_256    = -DAVX_256_8       -march=icelake-client $(CXXFLAGS_GENERIC)
CXXFLAGS_ICE_LAKE_512    = -DAVX_256_10      -march=icelake-server $(CXXFLAGS_GENERIC)
CXXFLAGS_KNL             = -DAVX_512_12      -march=knl            $(CXXFLAGS_GENERIC)
CXXFLAGS_ZEN             = -DAVX_256_5       -march=znver1         $(CXXFLAGS_GENERIC)
CXXFLAGS_ZEN_PLUS        = -DAVX_256_5       -march=znver1         $(CXXFLAGS_GENERIC)

ARCH_DIR=Arch
CPUFETCH_DIR=cpufetch
MAIN=main.c getarg.c $(CPUFETCH_DIR)/cpu.c $(CPUFETCH_DIR)/cpuid.c $(CPUFETCH_DIR)/uarch.c $(ARCH_DIR)/Arch.c

SANDY_BRIDGE=$(ARCH_DIR)/256_3_nofma.c
SANDY_BRIDGE_HEADERS=$(ARCH_DIR)/256_3_nofma.h $(ARCH_DIR)/Arch.h

IVY_BRIDGE=$(ARCH_DIR)/256_3_nofma.c
IVY_BRIDGE_HEADERS=$(ARCH_DIR)/256_3_nofma.h $(ARCH_DIR)/Arch.h

HASWELL=$(ARCH_DIR)/256_10.c
HASWELL_HEADERS=$(ARCH_DIR)/256_10.h $(ARCH_DIR)/Arch.h

SKYLAKE_256=$(ARCH_DIR)/256_8.c
SKYLAKE_256_HEADERS=$(ARCH_DIR)/256_8.h $(ARCH_DIR)/Arch.h

SKYLAKE_512=$(ARCH_DIR)/512_8.c
SKYLAKE_512_HEADERS=$(ARCH_DIR)/512_8.h $(ARCH_DIR)/Arch.h

BROADWELL=$(ARCH_DIR)/256_8.c
BROADWELL_HEADERS=$(ARCH_DIR)/256_8.h $(ARCH_DIR)/Arch.h

KABY_LAKE=$(ARCH_DIR)/256_8.c
KABY_LAKE_HEADERS=$(ARCH_DIR)/256_8.h $(ARCH_DIR)/Arch.h

COFFE_LAKE=$(ARCH_DIR)/256_10.c
COFFE_LAKE_HEADERS=$(ARCH_DIR)/256_10.h $(ARCH_DIR)/Arch.h

CANNON_LAKE_256=$(ARCH_DIR)/256_10.c
CANNON_LAKE_256_HEADERS=$(ARCH_DIR)/256_10.h $(ARCH_DIR)/Arch.h

CANNON_LAKE_512=$(ARCH_DIR)/256_10.c
CANNON_LAKE_512_HEADERS=$(ARCH_DIR)/256_10.h $(ARCH_DIR)/Arch.h

ICE_LAKE_256=$(ARCH_DIR)/256_8.c
ICE_LAKE_256_HEADERS=$(ARCH_DIR)/256_8.h $(ARCH_DIR)/Arch.h

ICE_LAKE_512=$(ARCH_DIR)/256_10.c
ICE_LAKE_512_HEADERS=$(ARCH_DIR)/256_10.h $(ARCH_DIR)/Arch.h

KNL=$(ARCH_DIR)/512_12.c
KNL_HEADERS=$(ARCH_DIR)/512_12.h $(ARCH_DIR)/Arch.h

ZEN=$(ARCH_DIR)/256_5.c
ZEN_HEADERS=$(ARCH_DIR)/256_5.h $(ARCH_DIR)/Arch.h

ZEN_PLUS=$(ARCH_DIR)/256_5.c
ZEN_PLUS_HEADERS=$(ARCH_DIR)/256_5.h $(ARCH_DIR)/Arch.h

OUT_SANDY_BRIDGE=sandy_bridge.o
OUT_IVY_BRIDGE=ivy_bridge.o
OUT_HASWELL=haswell.o
OUT_SKYLAKE_256=skylake_256.o
OUT_SKYLAKE_512=skylake_512.o
OUT_BROADWELL=broadwell.o
OUT_KABY_LAKE=kaby_lake.o
OUT_COFFE_LAKE=coffe_lake.o
OUT_CANNON_LAKE=cannon_lake.o
OUT_ICE_LAKE_256=ice_lake_256.o
OUT_ICE_LAKE_512=ice_lake_512.o
OUT_KNL=knl.o
OUT_ZEN=zen.o
OUT_ZEN_PLUS=zen_plus.o
ALL_OUTS=$(OUT_SANDY_BRIDGE) $(OUT_IVY_BRIDGE) $(OUT_HASWELL) $(OUT_SKYLAKE_256) $(OUT_SKYLAKE_512) $(OUT_BROADWELL) $(OUT_KABY_LAKE) $(OUT_CANNON_LAKE_256) $(OUT_CANNON_LAKE_512) $(OUT_ICE_LAKE_256) $(OUT_ICE_LAKE_512) $(OUT_KNL) $(OUT_ZEN) $(OUT_ZEN_PLUS)

peakperf: $(MAIN) $(ALL_OUTS)
	$(CXX) $(CXXFLAGS_GENERIC) -mavx $(CXXFLAGS_LINK) $(MAIN) $(ALL_OUTS) -o $@
	@rm $(ALL_OUTS)

$(OUT_SANDY_BRIDGE): Makefile $(SANDY_BRIDGE) $(SANDY_BRIDGE_HEADERS)
	$(CXX) $(CXXFLAGS_SANDY_BRIDGE) $(SANDY_BRIDGE) -c -o $@
	
$(OUT_IVY_BRIDGE): Makefile $(IVY_BRIDGE) $(IVY_BRIDGE_HEADERS)
	$(CXX) $(CXXFLAGS_IVY_BRIDGE) $(IVY_BRIDGE) -c -o $@
	
$(OUT_HASWELL): Makefile $(HASWELL) $(HASWELL_HEADERS)
	$(CXX) $(CXXFLAGS_HASWELL) $(HASWELL) -c -o $@
	
$(OUT_SKYLAKE_256): Makefile $(SKYLAKE_256) $(SKYLAKE_256_HEADERS)
	$(CXX) $(CXXFLAGS_SKYLAKE_256) $(SKYLAKE_256) -c -o $@
	
$(OUT_SKYLAKE_512): Makefile $(SKYLAKE_512) $(SKYLAKE_512_HEADERS)
	$(CXX) $(CXXFLAGS_SKYLAKE_512) $(SKYLAKE_512) -c -o $@	
	
$(OUT_BROADWELL): Makefile $(BROADWELL) $(BROADWELL_HEADERS)
	$(CXX) $(CXXFLAGS_BROADWELL) $(BROADWELL) -c -o $@
	
$(OUT_KABY_LAKE): Makefile $(KABY_LAKE) $(KABY_LAKE_HEADERS)
	$(CXX) $(CXXFLAGS_KABY_LAKE) $(KABY_LAKE) -c -o $@
	
$(OUT_COFFE_LAKE): Makefile $(COFFE_LAKE) $(COFFE_LAKE_HEADERS)
	$(CXX) $(CXXFLAGS_COFFE_LAKE) $(COFFE_LAKE) -c -o $@
	
$(OUT_CANNON_LAKE_256): Makefile $(CANNON_LAKE_256) $(CANNON_LAKE_256_HEADERS)
	$(CXX) $(CXXFLAGS_CANNON_LAKE_256) $(CANNON_LAKE_256) -c -o $@
	
$(OUT_CANNON_LAKE_512): Makefile $(CANNON_LAKE_512) $(CANNON_LAKE_512_HEADERS)
	$(CXX) $(CXXFLAGS_CANNON_LAKE_512) $(CANNON_LAKE_512) -c -o $@	
	
$(OUT_ICE_LAKE_256): Makefile $(ICE_LAKE_256) $(ICE_LAKE_256_HEADERS)
	$(CXX) $(CXXFLAGS_ICE_LAKE_256) $(ICE_LAKE_256) -c -o $@

$(OUT_ICE_LAKE_512): Makefile $(ICE_LAKE_512) $(ICE_LAKE_512_HEADERS)
	$(CXX) $(CXXFLAGS_ICE_LAKE_512) $(ICE_LAKE_512) -c -o $@	
	
$(OUT_KNL): Makefile $(KNL) $(KNL_HEADERS)
	$(CXX) $(CXXFLAGS_KNL) $(KNL) -c -o $@
	
$(OUT_ZEN): Makefile $(ZEN) $(ZEN_HEADERS)
	$(CXX) $(CXXFLAGS_ZEN) $(ZEN) -c -o $@
	
$(OUT_ZEN_PLUS): Makefile $(ZEN_PLUS) $(ZEN_PLUS_HEADERS)
	$(CXX) $(CXXFLAGS_ZEN_PLUS) $(ZEN_PLUS) -c -o $@	
	
clean:
	@rm peakperf $(ALL_OUTS)	
