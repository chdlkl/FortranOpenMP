! File: pt.f
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
!$OMP SINGLE
      do i=1,m
!$OMP TASK FIRSTPRIVATE(i) SHARED(a)
         call print_task(a(i))
!$OMP END TASK
      end do
!$OMP END SINGLE
!$OMP END PARALLEL 

      end program print_do

C----------------------------------------------------------
      subroutine print_task(i)
      implicit none
      include 'omp_lib.h'

      integer :: i, tid, nthreads

      tid=OMP_GET_THREAD_NUM() 
      nthreads=OMP_GET_NUM_THREADS()
      call pause_seconds(2)
      print '(a,i8,i8,i8)','print task: nthreads,tid,i=',nthreads,tid,i

      return
      end subroutine print_task

C----------------------------------------------------------
      subroutine pause_seconds(i)
      implicit none
      include 'omp_lib.h'

      integer :: i
      real (kind=8) :: start_time,end_time,used_time,pause_time

      pause_time=abs(i)

      start_time=OMP_GET_WTIME()
      used_time=-1.0

      do while(used_time < pause_time)
         end_time=OMP_GET_WTIME()
         used_time=end_time-start_time
      end do

      return
      end subroutine pause_seconds
