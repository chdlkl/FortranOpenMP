! File: dap.f
      program do_array_plus
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=10
      integer :: nthreads,tid,i
      integer, dimension(1:m) :: a,b,c

      call omp_set_num_threads(3)

      do i=1,m
         a(i)=10*i
         b(i)=i
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,4(i6))','nthreads,tid,i,a(i)=',nthreads,tid,i,a(i)
      end do

      print '(a)','------before parallel'
      print *

!$OMP PARALLEL PRIVATE(i,tid,nthreads) DEFAULT(SHARED)
!$OMP DO
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         c(i)=a(i)+b(i)
         print '(a,4(i6))','nthreads,tid,i,c(i)=',nthreads,tid,i,c(i)
      end do
!$OMP END DO
!$OMP END PARALLEL

      print *
      print '(a)','------after parallel'

      tid=OMP_GET_THREAD_NUM() 
      nthreads=OMP_GET_NUM_THREADS()
      print '(a,4(i6))','nthreads,tid         =',nthreads,tid

      end program do_array_plus

