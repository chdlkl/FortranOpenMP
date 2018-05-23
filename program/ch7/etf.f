!File: etf.f     
      program example_time_function
      implicit none
      real (kind=4) :: t0,t1

      real (kind=4) :: cpu_start, cpu_finish

      integer :: count_rate, count_max
      integer :: count1, count2

C -----function secnd
      t0 = secnds(0.0)
      call delay
      t1 = secnds(t0)
      print *, 'secnd=',t1, 'seconds.'
      print *

C -----subroutine cpu_time
      call cpu_time(cpu_start)
      call delay
      call cpu_time(cpu_finish)
      print *,"cpu_time = ",cpu_finish-cpu_start," seconds."
      print *

C -----subroutine system_clock
      call system_clock(count1, count_rate, count_max)
      call delay
      call system_clock(count2, count_rate, count_max)
      print *,"system_clock=",real(count2-count1)/real(count_rate),"s."

      end program example_time_function

C----------------------------------------------------------
      subroutine delay
      implicit none
      integer (kind=4) :: i,j,m
      real (kind=4) :: x

      m=10000
      do i=1, m
      do j=1, m
        x=sin(cos(log(real(j))))
      end do
      end do
      print *, 'sub delay is called', x

      return
      end subroutine delay
