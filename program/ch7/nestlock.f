! File: nestlock.f
      program nestlock 
      implicit none
      include 'omp_lib.h'
      integer (OMP_NEST_LOCK_KIND) :: lck
      integer :: x

      x=1000
      call OMP_INIT_NEST_LOCK(lck)

!$OMP PARALLEL SECTIONS SHARED(X,LCK)
!$OMP SECTION
      call add(x,20,lck)
      print '(a)'
!$OMP SECTION
      call substract(x,10,lck)
!$OMP END PARALLEL SECTIONS

      call OMP_DESTROY_NEST_LOCK(lck)

      end program nestlock

C----------------------------------------------------------
      subroutine add(x,dx,lck)
      implicit none
      include 'omp_lib.h'
      integer (OMP_NEST_LOCK_KIND) :: lck
      integer :: x,dx

      if (dx .gt. 0.0)then
         print '(a)','sub add'
      else
         print '(a)','sub add for sub substract'
      end if

      call OMP_SET_NEST_LOCK(lck)
      print '(a)','set nested lock for + operation'
           x=x+dx
      call OMP_UNSET_NEST_LOCK(lck)
      print '(a)','unset nested lock for + operation'

      return
      end subroutine add

C----------------------------------------------------------
      subroutine substract(x,dx,lck)
      implicit none
      include 'omp_lib.h'
      integer (OMP_NEST_LOCK_KIND) :: lck
      integer :: x,dx

      print '(a)','sub substract'

      call OMP_SET_NEST_LOCK(lck)
      print '(a)','set nested lock for - operation'
           call add(x,-dx,lck)
      call OMP_UNSET_NEST_LOCK(lck)
      print '(a)','unset nested lock for - operation'

      return
      end subroutine substract
