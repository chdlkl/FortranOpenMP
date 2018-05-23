!File: hh.f
      program hello_hi

      print '(a)', 'Hello 1'

!$OMP PARALLEL

      print '(a)', 'Hi'

!$OMP END PARALLEL

      print '(a)', 'Hello 2'

      end program hello_hi

