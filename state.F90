#define MODULENAME MODEL ## _state_mod

module MODULENAME
    type state_t
#define FIELD(source, dest, intent) REAL(kind=8), ALLOCATABLE :: source(:,:)
#include XFILE
#undef FIELD
#define FIELD(source, dest, intent) INTEGER :: oid_ ## source
#include XFILE
#undef FIELD
    end type

contains

    subroutine init(state, x, y)
        use mod_oasis
        use driver_mod
        type(state_t), intent(out) :: state
        integer, intent(in) :: x, y
        integer :: oerr

#define FIELD(source, dest, intent) ALLOCATE(state%source(x,y))
#include XFILE
#undef FIELD

#define IN OASIS_in
#define OUT OASIS_out
#define FIELD(source, dest, intent) CALL def_var(state%oid_##source, #source, x, y, intent)
#include XFILE
#undef FIELD
#undef IN
#undef OUT

        CALL oasis_enddef(oerr)
    end subroutine

    subroutine put(state, date)
        use mod_oasis
        type(state_t), intent(inout) :: state
        integer, intent(in) :: date
        integer :: info
#define IN(x)
#define OUT(x) x
#define FIELD(source, dest, intent) intent(CALL oasis_put(state%oid_##source, date, state%##source, info))
#include XFILE
#undef FIELD
#undef IN
#undef OUT
    end subroutine

    subroutine get(state, date)
        use mod_oasis
        type(state_t), intent(inout) :: state
        integer, intent(in) :: date
        integer :: info
#define IN(x) x
#define OUT(x)
#define FIELD(source, dest, intent) intent(CALL oasis_get(state%oid_##source, date, state%##source, info))
#include XFILE
#undef FIELD
#undef IN
#undef OUT
    end subroutine
end module
