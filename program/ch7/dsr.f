! File: dsr.f
      program do_schdule_runtime
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=10
      integer :: nthreads,tid,i,j
      real :: a

      a=0.0

!$OMP PARALLEL DO PRIVATE(i) SCHEDULE(runtime)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,3(i6))','nthreads,id,i=',nthreads,tid,i
      end do
!$OMP END PARALLEL DO

      end program do_schdule_runtime
