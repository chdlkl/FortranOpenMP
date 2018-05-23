! File: fib.f
      program fibonacci 
      implicit none

      integer :: n,fib

      n=45

      print'(a,i3,a,i20)','fib(',n,')=',fib(n)

      end program fibonacci

C----------------------------------------------------------
      recursive function fib(n) result(fib_result)
      implicit none

      integer :: fib_result
      integer :: i,j,n

      if(n<2)then
        fib_result=n
      else
        i=fib(n-1)
        j=fib(n-2)
        fib_result=i+j
      end if

      return
      end function fib
