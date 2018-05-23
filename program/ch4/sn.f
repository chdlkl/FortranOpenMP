! File: sn.f
      program set_nested
      implicit none
      include 'omp_lib.h'

      integer :: nest_set,nthreads_set
      integer :: nid,nnest,nthreads,tid

      call OMP_SET_NESTED(.TRUE.)
      print *,'nested region(true or false):',OMP_GET_NESTED()
      print *

      nest_set=2
      nthreads_set=3

!$OMP PARALLEL PRIVATE(nnest,nid) NUM_THREADS(nest_set)
      nid=OMP_GET_THREAD_NUM() 
      nnest=OMP_GET_NUM_THREADS()
      print '(2(a,i3))','nested region number=',nnest,'   nid=',nid

!$OMP PARALLEL PRIVATE(nthreads,tid) NUM_THREADS(nthreads_set)
      tid=OMP_GET_THREAD_NUM() 
      nthreads=OMP_GET_NUM_THREADS()
      print '(a,i3,a,i3)','number of threads:',nthreads,'   tid=',tid
!$OMP END PARALLEL
      print *,'------------------'

!$OMP END PARALLEL

      end program set_nested
