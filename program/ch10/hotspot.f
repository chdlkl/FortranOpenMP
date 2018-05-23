! File: hotspot.f
      program hot_spot
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z

      m=1000000
      x=0.0
      y=0.0
      z=0.0

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+cos(log(dble(m)))-sin(log(dble(m)))
      end do

      call func1(x,y,z,m)

      call func2(x,y,z,m)

      call func3(x,y,z,m)

      print *,'x,y,z=',x,y,z

      end program hot_spot

C----------------------------------------------------------
      subroutine func1(x,y,z,m)
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+cos(log(dble(m)))-exp(sin(log(dble(m))))
      end do

      return
      end subroutine func1

C----------------------------------------------------------
      subroutine func2(x,y,z,m)
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+cos(log(dble(m)))-sin(log(dble(m)))
      end do

      call func1(-x,y,z,m)

      return
      end subroutine func2

C----------------------------------------------------------
      subroutine func3(x,y,z,m)
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+exp(sin(cos(log(dble(m)))))-cos(sin(log(dble(m))))
      end do

      call func1(-x,y,z,m)

      return
      end subroutine func3
