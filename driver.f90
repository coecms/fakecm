!> 
!! Copyright 2016 ARC Centre of Excellence for Climate Systems Science
!!
!! \author  Scott Wales <scott.wales@unimelb.edu.au>
!!
!! Licensed under the Apache License, Version 2.0 (the "License");
!! you may not use this file except in compliance with the License.
!! You may obtain a copy of the License at
!!
!!     http://www.apache.org/licenses/LICENSE-2.0
!!
!! Unless required by applicable law or agreed to in writing, software
!! distributed under the License is distributed on an "AS IS" BASIS,
!! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!! See the License for the specific language governing permissions and
!! limitations under the License.

module driver_mod
    integer compid
    integer partid
    integer comm_local
contains
    subroutine setup(name, x, y)
        use mpi
        use mod_oasis
        character(len=*), intent(in) :: name
        integer, intent(in) :: x, y
        integer mpierr
        integer oerr
        integer size
        size = x * y
        call mpi_init(mpierr)
        call oasis_init_comp(compid, name, oerr)
        call check_err(oerr)
        call oasis_get_localcomm(comm_local, oerr)
        call check_err(oerr)
        call oasis_def_partition(partid, [0,0,size], oerr)
        call check_err(oerr)
    end subroutine

    subroutine teardown()
        use mpi
        use mod_oasis
        integer mpierr
        integer oerr
        call oasis_terminate(oerr)
        call check_err(oerr)
        call mpi_finalize(mpierr)
    end subroutine

    subroutine check_err(err)
        use ifcore
        use mpi
        integer, intent(in) :: err
        integer :: merr
        if (err /= 0) then
            call tracebackqq(user_exit_code=-1)
            call mpi_abort(MPI_COMM_WORLD, err, merr)
        end if
    end subroutine

    subroutine def_var(id, name, x, y, intent)
        use mod_oasis
        integer, intent(out) :: id
        character(len=*), intent(in) :: name
        integer, intent(in) :: x,y
        integer, intent(in) :: intent
        integer oerr
        CALL oasis_def_var(id, name, partid, [2,1], intent, [1,x,1,y], OASIS_real, oerr)
        CALL check_err(oerr)
    end subroutine

end module
