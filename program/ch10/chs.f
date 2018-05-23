! File: chs.f
      module check_hot
      integer, save :: loop1_times=0 
      integer, save :: fun1_times=0, fun2_times=0
      integer, save :: fun3_times=0
      real(kind=4), save :: loop1_cal_time=0.0
      real(kind=4), save :: fun1_cal_time=0.0, fun2_cal_time=0.0
      real(kind=4), save :: fun3_cal_time=0.0
      real(kind=4), save :: t0,t1,t00,t01,tsum=0
      end module check_hot

C----------------------------------------------------------
      program check_hot_spot
      use check_hot
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z

C  Calculation time for whole program, t00: reference time
      call cpu_time(t00)

      m=1000000
      x=0.0
      y=0.0
      z=0.0

C  Loop1 frequency and calculation_time, t0: reference time
      call cpu_time(t0)

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+cos(log(dble(m)))-sin(log(dble(m)))
      end do

      call cpu_time(t1)
      loop1_times=loop1_times+1
      loop1_cal_time=loop1_cal_time+(t1-t0)

      call func1(x,y,z,m)

      do i=1,10
         call func2(x,y,z,m)
      end do

      do i=1,20
         call func3(x,y,z,m)
      end do

      print *,'x,y,z=',x,y,z

C Statistic for calculational time
C  Calculation time for whole program, t00: reference time
      call cpu_time(t01)
      tsum=t01-t00

      print *
      print *,'---------analysis result---------'
      print *,'Total calculatal time=',tsum,'seconds'
      print *

      print *,'loop&func  frequency, cal_time(%)'
      print *,'loop 1', loop1_times, loop1_cal_time/tsum*100.
      print *,'func 1', fun1_times, fun1_cal_time/tsum*100.
      print *,'func 2', fun2_times, fun2_cal_time/tsum*100.
      print *,'func 3', fun3_times, fun3_cal_time/tsum*100.

      end program check_hot_spot

C----------------------------------------------------------
      subroutine func1(x,y,z,m)
      use check_hot
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z

C  Fun1 frequency and calculation_time, t0: reference time
      call cpu_time(t0)

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+cos(log(dble(m)))-exp(sin(log(dble(m))))
      end do

      call cpu_time(t1)
      fun1_times=fun1_times+1
      fun1_cal_time=fun1_cal_time+(t1-t0)

      return
      end subroutine func1

C----------------------------------------------------------
      subroutine func2(x,y,z,m)
      use check_hot
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z

C  Fun2 frequency and calculation_time, t0: reference time
      call cpu_time(t0)

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+cos(log(dble(m)))-sin(log(dble(m)))
      end do

      call func1(-x,y,z,m)

      call cpu_time(t1)
      fun2_times=fun2_times+1
      fun2_cal_time=fun2_cal_time+(t1-t0)

      return
      end subroutine func2

C----------------------------------------------------------
      subroutine func3(x,y,z,m)
      use check_hot
      implicit none
      integer(kind=4) :: i,m
      real(kind=8) :: x,y,z
C  Fun3 frequency and calculation_time, t0: reference time
      call cpu_time(t0)

      do i=1,m
         x=x+sin(log(dble(m)))
         y=y-cos(log(dble(i)))
         z=x+y+exp(sin(cos(log(dble(m)))))-cos(sin(log(dble(m))))
      end do

      call func2(x,-y,z,m)

      call cpu_time(t1)
      fun3_times=fun3_times+1
      fun3_cal_time=fun3_cal_time+(t1-t0)

      return
      end subroutine func3
