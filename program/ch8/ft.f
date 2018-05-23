!File: ft.f
      program fibonacci_task 
      implicit none
      include 'omp_lib.h'

      integer :: n,fib

      n=45

      CALL OMP_SET_DYNAMIC(.FALSE.)
      CALL OMP_SET_NUM_THREADS(8)

!$OMP PARALLEL SHARED(n)
!$OMP SINGLE
      print'(a,i3,a,i8)','fib(',n,')=',fib(n)
!$OMP END SINGLE
!$OMP END PARALLEL

      end program fibonacci_task 

C----------------------------------------------------------
      recursive function fib(n) result(fib_result)
      implicit none
      include 'omp_lib.h'

      integer :: fib_result
      integer :: i,j,n

      if(n<2)then
        fib_result=n
      else

!$OMP TASK SHARED(i) FIRSTPRIVATE(n)
        i=fib(n-1)
!$OMP END TASK

!$OMP TASK SHARED(j) FIRSTPRIVATE(n)
        j=fib(n-2)
!$OMP END TASK

!$OMP TASKWAIT

        fib_result=i+j

      end if

      return
      end function fib
