! File: hp.f
      program hello_parallel
      implicit none
      include 'omp_lib.h'

      integer :: tid,mcpu

      call OMP_SET_NUM_THREADS(3)

      tid=OMP_GET_THREAD_NUM() 
      mcpu=OMP_GET_NUM_THREADS()
      print '(a,i4,a,i4,a)','Hello from thread',tid,' in',mcpu,' CPUs'
      print '(a)','------before parallel'
      print *

!$OMP PARALLEL DEFAULT(NONE) PRIVATE(tid,mcpu)
      print '(a)','------during parallel'
      tid=OMP_GET_THREAD_NUM() 
      mcpu=OMP_GET_NUM_THREADS()
      print '(a,i4,a,i4,a)','Hello from thread',tid,' in',mcpu,' CPUs'
!$OMP END PARALLEL

      print *
      print '(a)','------after parallel'
      print '(a,i4,a,i4,a)','Hello from thread',tid,' in',mcpu,' CPUs'

      end program hello_parallel

