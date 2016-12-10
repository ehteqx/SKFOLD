! SKFOLD - Self-organizing Kohonen principal-mainFOLD-approximation map
! Copyright (c) 2016 Emanuele Ballarin
! Software released under the terms of the MIT License

! The purpose of the script is to build and drive a Self-Organizing Map (SOM)
! which generalizes the Principal Component Analysis (PCA) approach in the
! elaboration of data points, arbitrarily distributed in 2 dimensions.
! The net is bidimensional, and at the end of the self-training process it
! displaces itself so as it lies on the principal plane that best explains
! the overall dataset variance.
! The net has a fixed structure and evolves following Teuvo Kohonen's
! algorithm, in an exponentially-decaying time- and learning-rate- adaptive
! fashion.

! This file contains the Fortran 95 source code, based on the Python version.
! This program re-implements all the features of the Python equivalent, with
! a remarkable performance gain.

!#######################################################################################################################

MODULE GLPREC   ! GLobal PRECision

    implicit none

! TWEAKABLES OF THE ENVIRONMENT:
    integer, parameter 	                :: ik = selected_int_kind(38)		! Integer precision limit (MAX: 38)
    integer, parameter 	                :: rk = selected_real_kind(12)		! Real precision limit (MAX: 33)

END MODULE GLPREC

MODULE DISTANCES    ! Implementation of some geometrical distances

    use GLPREC
    implicit none

contains

    FUNCTION EUDIST (a, b) result(dist)     ! Euclidean Distance

        implicit none

        real (kind = rk), dimension(2), intent(in) :: a, b
        real (kind = rk)                           :: dist

        dist = SQRT((a(1) - b(1))**2 + (a(2) - b(2))**2)

    END FUNCTION EUDIST


    FUNCTION MHDISTSQ (a, b) result(dist)   ! Manhattan Squared Distance

        implicit none

        integer (kind = ik), dimension(2), intent(in) :: a, b
        real (kind = rk)                              :: dist

        dist = ((a(1) - b(1))**2 + (a(2) - b(2))**2)

    END FUNCTION MHDISTSQ

END MODULE DISTANCES

!#######################################################################################################################

PROGRAM SKFOLD

    use GLPREC
    use DISTANCES
    implicit none

! TWEAKABLES OF THE NET:
	integer (kind = ik), parameter		:: Nrow = 4        ! Number of rows in the map
    integer (kind = ik), parameter		:: Ncol = 25       ! Number of columns in the map

	real (kind = rk), parameter         :: epsilon  = 0.2   ! Normalized learning rate (starting)
    real (kind = rk), parameter         :: sigma    = 18    ! Gaussian spread index (starting)
    real (kind = rk), parameter         :: epsdecay = 0.999 ! N.L.R. (epsilon) exponential decay factor
    real (kind = rk), parameter         :: sigdecay = 0.96  ! G.S.I. (sigma) exponential decay factor
    real (kind = rk), parameter         :: thresh   = 500   ! Iterations before decay enactment
    real (kind = rk), parameter         :: effzero  = 0.05  ! Learning ends when N.L.R. is equal (or less) to it

! VARIABLES:
    ! Indexes
    integer (kind = ik)                 :: n, i

    ! Dataset
    integer (kind = ik)                           :: datarows
    real (kind = rk), dimension(:,:), allocatable :: dataset

    ! Seeds
    integer (kind = 4) :: inputseed

    ! Dummy Variables
    real (kind = rk), dimension(2)         :: dummybuffer
    integer (kind = ik)                    :: iostatus

    print*, " "                 ! Some printed info
    print*, "Program started! Now probing data file..."
    print*, " "

! DATA ACQUISITION:
    ! Determining input size
    open(unit=1, file='datagen.txt', status='old', action='read')
    n = 0_ik

    do
        read(1,*, iostat=iostatus)dummybuffer ! The file contains bidimensional arrays.
        if(iostatus /= 0) then ! If the file ends...
            exit               ! ...the cycle is exited.
        else
            n = n+1            ! Else, the row is counted
        end if
    end do

    close(unit=1)

    datarows = n

    print*, " "                 ! Some printed info
    print*, "Data file probe successful! Now acquiring data..."
    print*, " "

    ! Reading data from file, given size
    allocate (dataset(datarows,2))  ! (ROWS, COLUMNS)

    open(unit=1, file='datagen.txt', status='old', action='read')

    do i = 1, datarows, 1
        read(1,*)dataset(i,:)
    end do

    print*, " "                 ! Some printed info
    print*, "Data acquired! Starting ML engine..."
    print*, " "

! NEURAL DRIVE
    ! Randomness
        ! Seed acquisition
        print*, 'Insert a number of exactly 7 figures to use as random seed... '
        read*, inputseed
        print*, ' '

        ! Initialization
        CALL RANDOM_SEED(inputseed)

END PROGRAM SKFOLD
