FC=mpif90
FCFLAGS=-warn all -g -traceback
LDLIBS=-lpsmile.MPI1 -lmct -lscrip -lmpeu -lnetcdff -lnetcdf
CPPFLAGS+=-DONAME=\'$@\' -DMODEL=${MODEL}

all: matmxx cicexx mom5xx

matmxx: MODEL=atmos
matmxx: driver.o atmos_state.o main.F90
	${FC} ${CPPFLAGS} ${FCFLAGS} ${LDFLAGS} -o $@ $^ ${LDLIBS}

cicexx: MODEL=ice
cicexx: driver.o ice_state.o main.F90
	${FC} ${CPPFLAGS} ${FCFLAGS} ${LDFLAGS} -o $@ $^ ${LDLIBS}

mom5xx: MODEL=ocean
mom5xx: driver.o ocean_state.o main.F90
	${FC} ${CPPFLAGS} ${FCFLAGS} ${LDFLAGS} -o $@ $^ ${LDLIBS}

%.o: %.f90
	${FC} -c ${FCFLAGS} -o $@ $< 

%_state.o: state.F90 %.x
	${FC} -c ${CPPFLAGS} -DXFILE=\"$*.x\" ${FCFLAGS} -o $@ $< 

atmos.o: atmos.x
