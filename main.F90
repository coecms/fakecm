#define MODULENAME MODEL ## _state_mod

program main
    use driver_mod
    use mpi
    use MODULENAME
    type(state_t) :: state
    integer :: x, y
    integer :: i
    integer :: err
    x = 1440
    y = 1080
#if MODEL == atmos
x=1000
#endif

    call setup(ONAME, x, y)
    call init(state, x, y)
    do i=0,2400,1200
    call mpi_barrier(MPI_COMM_WORLD, err)
#if MODEL == atmos
    call put(state, i)
    call mpi_barrier(MPI_COMM_WORLD, err)
    call get(state, i)
#else
    call get(state, i)
    call mpi_barrier(MPI_COMM_WORLD, err)
    call put(state, i)
#endif
    end do
    call teardown()
end program
