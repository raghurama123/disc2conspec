program spectrum

  implicit none

  character(len=100)            :: filename, units, arg
                                
  integer                       :: rwstat, i_line, N_lines
  double precision              :: Ek, eps_total, E_nm, sigma
  double precision, allocatable :: Ek_nm(:), fk(:)
  double precision, external    :: eps_k
  double precision, parameter   :: ev2cmi =   8065.54464585453d0
  double precision, parameter   :: au2cmi = 219474.6314739536d0

  call getarg(1, arg)
  filename=trim(arg)

  call getarg(2, arg)
  units=trim(arg)

  call getarg(3, arg)
  open(unit=10, file='scr')
  write(10,*)trim(arg)
  close(10)
  open(unit=10, file='scr')
  read(10,*)sigma
  close(10)

  open(unit=10, file=trim(filename))
  N_lines=0
  l1: do 
      read(10,*,iostat=rwstat)Ek, Ek
      if ( rwstat .ne. 0) exit l1
      N_lines=N_lines+1
  enddo l1
  close(10)
  
  allocate(Ek_nm(1:N_lines), fk(1:N_lines))

  open(unit=10, file=trim(filename))
  do i_line = 1, N_lines
    read(10,*) Ek, fk(i_line)
    select case(units)
    case('au2nm')
      Ek_nm(i_line) = 1d7 / (Ek * au2cmi)
    case('ev2nm')
      Ek_nm(i_line) = 1d7 / (Ek * ev2cmi)
    case('cmi2nm')
      Ek_nm(i_line) = 1d7 / Ek
    case('nm')
      Ek_nm(i_line) = Ek    
    case default
      write(*,'(a)') " ERROR: Unknown choice for the unit"
    end select
  enddo
  close(10)

  open(unit=10, file='spectrum.dat')
  E_nm   = 0d0
  loop1: do
    if ( E_nm .gt. 500d0 ) exit loop1
    eps_total = 0.0d0
    do i_line = 1, N_lines
      eps_total = eps_total + eps_k(Ek_nm(i_line), fk(i_line), E_nm, sigma)
    enddo
    E_nm = E_nm + 0.01d0
    write(10,'(2f15.8)') E_nm, eps_total
  enddo loop1
  close(10)

  open(unit=10, file='spectrumstick.dat')
  do i_line = 1, N_lines
    E_nm = Ek_nm(i_line)
    write(10,'(2f25.8)') E_nm, 10000d0
  enddo
  close(10)

  deallocate(Ek_nm, fk)  
end program spectrum


double precision function eps_k(Ek_nm, fk, E_nm, sigma_ev)
  
  implicit none

  double precision, intent(in) :: Ek_nm, fk, E_nm, sigma_ev

  double precision, parameter  :: ev2cmi =  8065.54464585453d0
  !double precision, parameter  :: sigma_ev = 0.4d0
  double precision             :: sigma_cmi, sigma_nm

  sigma_cmi = sigma_ev * ev2cmi
  sigma_nm = 1d7 / sigma_cmi

  eps_k = 1.3062974d8 * (fk/sigma_nm) * dexp(-((1d0/E_nm-1d0/Ek_nm)/(1.0d0/sigma_nm))**2)

end function
