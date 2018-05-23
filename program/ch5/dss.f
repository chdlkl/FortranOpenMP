! File: dss.f
      program do_schdule_static
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=10
      integer :: nthreads,tid,i

      call OMP_SET_NUM_THREADS(2)

!$OMP PARALLEL DO PRIVATE(i) SCHEDULE(STATIC)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,3(i6))','nthreads,id,i=',nthreads,tid,i
      end do
!$OMP END PARALLEL DO
      print *

!$OMP PARALLEL DO PRIVATE(i) SCHEDULE(STATIC,2)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,3(i6))','nthreads,id,i=',nthreads,tid,i
      end do
!$OMP END PARALLEL DO

      end program do_schdule_static

