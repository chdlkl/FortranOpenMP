! File: di.f
      program debug_idbc
      implicit none
      integer :: a,b,c,d

      a=1
      b=2
      c=3

      call change(a,b,c,d)

      b=-a
      c=-d

      print *,'a,b,c,d=',a,b,c,d

      end program debug_idbc

C----------------------------------------------------------
      subroutine change(x,y,z,u)
      implicit none
      integer :: x,y,z,u

      y=10*x
      z=100*x+y
      u=1000*x+y+z

      return
      end subroutine change
