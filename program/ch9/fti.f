! File: fti.f
      program fibonacci_task_if 
      implicit none
      include 'omp_lib.h'

      integer :: n,fib
      real (kind=8) :: start_time,end_time,used_time

      start_time=OMP_GET_WTIME()

      n=45

      CALL OMP_SET_DYNAMIC(.FALSE.)
      CALL OMP_SET_NUM_THREADS(8)

!$OMP PARALLEL SHARED(n)
!$OMP SINGLE
      print'(a,i3,a,i20)','fib(',n,')=',fib(n)
!$OMP END SINGLE
!$OMP END PARALLEL

      end_time=OMP_GET_WTIME()

      used_time=end_time-start_time
      print '(a,f13.7,a)','used_time=',used_time,'  seconds'

      end program fibonacci_task_if 

C----------------------------------------------------------
      recursive function fib(n) result(fib_result)
      implicit none
      include 'omp_lib.h'

      integer :: fib_result
      integer :: i,j,n

      if(n<2)then
        fib_result=n
      else

!$OMP TASK SHARED(i) FIRSTPRIVATE(n) IF(n>30)
        i=fib(n-1)
!$OMP END TASK

!$OMP TASK SHARED(j) FIRSTPRIVATE(n) IF(n>30)
        j=fib(n-2)
!$OMP END TASK

!$OMP TASKWAIT

        fib_result=i+j

      end if

      return
      end function fib
