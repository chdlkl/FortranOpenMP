! File: ps.f
      program print_sections
      implicit none
      include 'omp_lib.h'

      integer :: i
      integer, dimension(1:100) :: a

      call OMP_SET_NUM_THREADS(6)

      do i=1,100
         a(i)=i
      end do               

!$OMP PARALLEL PRIVATE(i) SHARED(a) 
!$OMP SECTIONS
!$OMP SECTION
         i=1
         call print_task(a(i))
!$OMP SECTION
         i=2
         call print_task(a(i))
!$OMP SECTION
         i=3
         call print_task(a(i))
!$OMP SECTION
         i=4
         call print_task(a(i))
!$OMP END SECTIONS
!$OMP END PARALLEL 

      end program print_sections

C----------------------------------------------------------
      subroutine print_task(i)
      implicit none
      include 'omp_lib.h'

      integer :: i, tid, nthreads

      tid=OMP_GET_THREAD_NUM() 
      nthreads=OMP_GET_NUM_THREADS()
      print '(a,i8,i8,i8)','print task: nthreads,tid,i=',nthreads,tid,i

      return
      end subroutine print_task
