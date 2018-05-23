! File: pd.f
      program print_do
      implicit none
      include 'omp_lib.h'

      integer :: i,m
      integer, dimension(1:100) :: a,b

      call OMP_SET_NUM_THREADS(6)

      m=4

      do i=1,100
         a(i)=i
         b(i)=1
      end do               

!$OMP PARALLEL PRIVATE(i) SHARED(a,m) 
!$OMP DO
      do i=1,m
         call print_task(a(i))
      end do
!$OMP END DO
!$OMP END PARALLEL 

      end program print_do

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
