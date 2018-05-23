! File: cc.f
      program copyin_copyprivate
      implicit none
      include 'omp_lib.h'

      integer :: tid

      integer :: a,x
      common /cvar/ x

!$OMP THREADPRIVATE(/cvar/) 

      CALL OMP_SET_NUM_THREADS(4)
      tid=OMP_GET_THREAD_NUM() 

      a=-1
      x=-2
      print '(a)','******1st serial region'
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  id=',tid
      print *

      print '(a)', '---1st parallel region---'
!$OMP PARALLEL FIRSTPRIVATE(a) PRIVATE(tid) COPYIN(/cvar/)
      tid=OMP_GET_THREAD_NUM() 
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  id=',tid

      a = a+tid+10
      x = x+tid+100
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  a&x changed,  id=',tid
      print *
!$OMP END PARALLEL 

      tid=OMP_GET_THREAD_NUM() 
      print '(a)', '******2st serial region' 
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  id=',tid
      print *

      a = a+tid+10
      x = x+tid+100
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  a&x changed,  id=',tid
      print *

      print '(a)', '---2nd parallel region---'

!$OMP PARALLEL FIRSTPRIVATE(a)PRIVATE(tid) 
      tid=OMP_GET_THREAD_NUM() 
      print '(a,2(i5),a,i3)', '2nd parallel: a,x=',a,x,'  id=',tid

!$OMP SINGLE
      print *
      print '(a)', '---2st parallel region single block' 

      tid=OMP_GET_THREAD_NUM() 
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  id=',tid

      a = a+tid+10
      x = x+tid+100
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  a&x changed,  id=',tid
      print *
!$OMP END SINGLE COPYPRIVATE(/cvar/,a)

      print '(a)', '---2st parallel region after single' 

      tid=OMP_GET_THREAD_NUM() 
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  id=',tid

!$OMP END PARALLEL 

      print *
      print '(a)','******3rd serial region'
      print '(a,2(i5),a,i3)', 'a,x=',a,x,'  id=',tid

      end program copyin_copyprivate
