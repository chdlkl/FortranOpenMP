! File: spc.f
      program single_private_copyprivate
      implicit none
      include 'omp_lib.h'

      integer :: tid,nthreads

      integer :: a

      CALL OMP_SET_NUM_THREADS(3)

!$OMP PARALLEL PRIVATE(a,tid)
      tid=OMP_GET_THREAD_NUM() 
      a=tid
      print '(a,i5,a,i5,a)', 'a=',a,'  id=',tid,'  before single'
!$OMP SINGLE
      print *
      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM() 
      a=a+2**tid+10
      print '(a,i5,i5)','single:  nthreads=',nthreads
      print '(a,i5,a,i5,a)', 'a=',a,'  id=',tid,'  during single'
      print *
!$OMP END SINGLE COPYPRIVATE(a)
      tid=OMP_GET_THREAD_NUM() 
      print '(a,i5,a,i5,a)', 'a=',a,'  id=',tid,'  after single'
!$OMP END PARALLEL

      end program single_private_copyprivate
