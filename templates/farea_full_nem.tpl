:Description: ASCEM 2012 F-Area benchmark problem, 1-d fixed velocity flow w/ full chemistry

:=========================== chemistry ========================================
CHEMISTRY
  PRIMARY_SPECIES
    H+
    Al+++
    Ca++
    Cl-      : charge balance
    Fe+++
    CO2(aq)
    K+       : conservative tracer
    Mg++
    Na+
    SiO2(aq)
    SO4--
    Tritium  : tracer w/ radioactive decay for calibrating flow
    NO3-
    UO2++
!    Sr++
    Tracer
  /
  SECONDARY_SPECIES
    OH-
    HCO3-
!    CO2(aq)
    CO3--
    NaHCO3(aq)
    NaCO3-
    NaOH(aq)
    AlOH++
    Al(OH)2+
    Al(OH)3(aq)
    Al(OH)4-
    CaOH+
    CaHCO3+
    CaCO3(aq)
    MgOH+
    MgHCO3+
    MgCO3(aq)
    (UO2)2(OH)2++  
    (UO2)2CO3(OH)3-
    (UO2)2OH+++
    (UO2)3(CO3)6(6-)
    (UO2)3(OH)4++
    UO2(OH)4--
    (UO2)3(OH)5+
    (UO2)3(OH)7-
    (UO2)3O(OH)2(HCO3)+
    (UO2)4(OH)7+
    UO2NO3+
    UO2OH+
    UO2(OH)2(aq)
    UO2(OH)3-
    UO2CO3(aq)
    UO2(CO3)2--
    UO2(CO3)3----
    CaUO2(CO3)3--
    Ca2UO2(CO3)3(aq)
    MgUO2(CO3)3--
    UO2OSi(OH)3+
  /

  DECOUPLED_EQUILIBRIUM_REACTIONS
    Fe+++
  /

!  GAS_SPECIES
  PASSIVE_GAS_SPECIES
    CO2(g)
  /

  MINERALS
    Quartz
    Goethite
    Kaolinite
    Schoepite
    Gibbsite
    Jurbanite
    Basaluminite
    Opal
  /

  GENERAL_REACTION
    REACTION Tritium <-> 
    FORWARD_RATE 1.78577e-09 
    BACKWARD_RATE 0.d0
  /

  MINERAL_KINETICS
    Quartz
      RATE_CONSTANT -13.3450 mol/cm^2-sec
    /   
    Goethite
      RATE_CONSTANT -7.9400 mol/cm^2-sec
    /   
    Kaolinite
!      RATE_CONSTANT -12.967 mol/cm^2-sec

      PREFACTOR
       RATE_CONSTANT -12.967 mol/cm^2-sec
       PREFACTOR_SPECIES H+
          ALPHA 0.777
        /   
      /   
    /  
    Schoepite
      RATE_CONSTANT 2.0000 mol/cm^2-sec
    /   
    Gibbsite
      RATE_CONSTANT -11.5000 mol/cm^2-sec
    /   
    Jurbanite
      RATE_CONSTANT -8.0000 mol/cm^2-sec
    /   
    Basaluminite
      RATE_CONSTANT -8.0000 mol/cm^2-sec
    /   
    Opal
      RATE_CONSTANT -12.1350 mol/cm^2-sec
    /   
  /

  SORPTION

! This is the original surface complexation implemented by Haruko (site density is fitted) 

!    SURFACE_COMPLEXATION_RXN
!      EQUILIBRIUM
!!      :MINERAL bulk sediment
!      SITE >davis_OH 1.56199E-01  : [mol/m^3 bulk]
!      COMPLEXES
!        (>davis_O)UO2+
!      /
!    /

! Non-electrostatic Model (NEM) from Arora et al., 2018, Groundwater, Table 7 and 9 (Competitive H+ and U sorption)
! Calculated by 7.0e-7 (site density, moles/m2) * 9.78 (ssa-sediment, m2/kg) * 1.0e+6(bulk density, kg/m3-water) * 0.39 (porosity)
! TOUGH-react used specific surface area of 9.78 m2/g-water (from Bhavna)
! site density (moles/m3-bulk) = Ns/V = Ns/Ss * Ss/Mw * \pho_water * Vw/V 
! Ns/Ss: site density (moles/m2-mineral or site) 
! Ss/Mw: mineral or site specific surface area (m2/g-water)
! \pho_water: density of water (g/m3)
! Vw/V-bulk : porosity


    SURFACE_COMPLEXATION_RXN
      EQUILIBRIUM
      SITE >xu_TOH  2.66994E-3  : [mol/m^3 bulk] 
      COMPLEXES
         (>xu_T)OH2+
         (>xu_T)O-
      /
    /

    SURFACE_COMPLEXATION_RXN
      EQUILIBRIUM
      SITE >xu_XOH  6.10272E-3  : [mol/m^3 bulk] 
      COMPLEXES
         (>xu_X)OH2+
         (>xu_X)OUO2+
      /
    /
 
    SURFACE_COMPLEXATION_RXN
      EQUILIBRIUM
      SITE >xu_YOH  3.432783E-3  : [mol/m^3 bulk] 
      COMPLEXES
         (>xu_Y)OH2+
      /
    /

! Non-competitive U sorption, similar as Davis 
! Non-competitive U soprtion is not used because competitive U sorption is implemented as (>xu_X)OUO2+ 

! site density (moles/m3-bulk) = Ns/V = Ns/Ss * Ss/Ms * Ms/Vs * Vs/V
! Ns/Ss: site density (moles/m2-mineral or site) 
! Ss/Ms: mineral or site specific surface area (m2/g-mineral or site)
! Ms/Vs: grain density (g/m3-mineral or site) = \phi*\pho / (1-\phi) : \phi: porosity, \pho: mass density per pore volume
! Vs/V: 1-porosity (m3-mineral or site/m3-bulk) 
! Calculated by 3.84e-6 (site density, moles/m2-mineral) * 0.059 (effective sa, m2-mineral/g-mineral) * 2.661e+6 (bulk density, g/m3 bulk) * 0.39 (porosity) 

!    SURFACE_COMPLEXATION_RXN
!      EQUILIBRIUM
!!      SITE >xu_ZOH 1.56199E-01  : [mol/m^3 bulk] 
!      SITE >xu_ZOH 0.23512  : [mol/m^3 bulk]
!      COMPLEXES
!        (>xu_Z)OUO2+
!      /
!    /


    ION_EXCHANGE_RXN
!      MINERAL Kaolinite
      CEC 2.75  : [mol/m^3 bulk]
      CATIONS
        Na+   1.0  REFERENCE
        Ca++  3.16227766017d0
        Al+++ 0.584341413374d0
        H+    39.8107170553d0
      /
    /

  END
! :sorption


  DATABASE farea-full-new-nem.dat
  LOG_FORMULATION
  MAX_RESIDUAL_TOLERANCE 1.0e-18
  ACTIVITY_COEFFICIENTS TIMESTEP

!  OUTPUT
!    primary_species
!    total_sorbed
!    Quartz
!    Goethite
!    Kaolinite
!    Schoepite
!    Gibbsite
!    Jurbanite
!    Basaluminite
!    Opal

   OUTPUT
     All
     TOTAL

  /

END

:=========================== constraints ======================================
CONSTRAINT background
!  : initial condition
! The concentrations are mostly consistent with Bea et al., 2013, Table 7
! Except NO3- concentration is adjusted as 1e-4 moles/kg_h2o   

  CONCENTRATIONS  : total aqueous [moles/kg_h2o]
    H+       5.4        P   
    Al+++    2.21e-8  T
    Ca++     1.00e-5    T   
    Cl-      9.98e-3    T
    Fe+++    2.52e-16   T   
    CO2(aq)  1.21e-05   T   
    K+       3.32e-5    T   
    Mg++     5.35e-3    T   
    Na+      2.78e-4    T   
    SiO2(aq) 1.77e-04   T   
    SO4--    2.25e-5    T   
    Tritium  1.0e-15    T   
    NO3-     1.0e-4     T   
    UO2++    1.25e-10   T   
    Tracer   1.0e-15    T
  /

! volume fraction and mineral reaction are from Bea et al., 2013, Table 6
! SSA are calculated as below (Note that the SSA values are different from the 1d-farea geochemistry benchmarking case) 
! SSA (m2-mineral/m3-bulk) = SSA (m2-mineral/g-mineral) * mineral density (g-mineral/cm3-minereal) * vol fraction (cm3-mineral/cm3-bulk) * unit converter (cm3-bulk/m3-bulk)

  MINERALS : volume_fraction   SSA [m^2 mineral/m^3 bulk]
    Quartz        0.9496    352035 
    Goethite      0.0093    643811
    Kaolinite     0.0412    2213335 
    Schoepite     0.0      10  
    Gibbsite      0.0      10  
    Jurbanite     0.0      10  
    Basaluminite  0.0      10  
    Opal          0.0      10  
/
END

CONSTRAINT seepage
!  : west BC

! The concentrations are mostly consistent with Bea et al., 2013, Table 7
! Except pH=1.54, the lower bound of the sensitivity analysis
! Na+ is used as total concentration instead of charge balance used in the 1d-farea geochemistry benchmarking case

  CONCENTRATIONS  : total aqueous [moles/kg_h2o]
    H+       @ph_seepage@     P
    Al+++    @al_conc_seepage@    T
    Ca++     1.00e-5    T
    Cl-      3.39e-4    T
    Fe+++    2.75e-6    T
    CO2(aq)  1.21e-05   T
    K+       1.72e-6    T
    Mg++     2.47e-5    T
    Na+      6.82e-5    T   
    SiO2(aq) 1.18e-4    T   
    SO4--    4.80e-5    T   
    Tritium  @tri_conc_seepage@   T   
    NO3-     1.00e-2    T   
    UO2++    @uran_conc_seepage@    T   
    Tracer   2.17e-9    T
  /
!  MINERALS : volume_fraction   SSA [m^2 mineral/m^3 bulk]
!    Quartz        0.9496    352035 
!    Goethite      0.0093    643811
!    Kaolinite     0.0412    2213335 
!    Schoepite     0.0      10  
!    Gibbsite      0.0      10  
!    Jurbanite     0.0      10  
!    Basaluminite  0.0      10  
!    Opal          0.0      10  
!  /
END

CONSTRAINT recharge
  CONCENTRATIONS  : total aqueous [moles/kg_h2o]
    H+       5.4        P   
    Al+++    2.21e-8  T
    Ca++     1.00e-5    T   
    Cl-      9.98e-3    T   
    Fe+++    2.52e-16   T   
    CO2(aq)  1.21e-05   T   
    K+       3.32e-5    T   
    Mg++     5.35e-3    T   
    Na+      2.78e-4    T   
    SiO2(aq) 1.77e-04   T   
    SO4--    2.25e-5    T   
    Tritium  1.0e-15    T   
    NO3-     1.0e-4     T   
    UO2++    1.25e-10   T   
    Tracer   1.0e-15    T
  /

 MINERALS : volume_fraction   SSA [cm^2 mineral/cm^3 bulk]
    Quartz        0.9496    352035 
    Goethite      0.0093    643811
    Kaolinite     0.0412    2213335 
    Schoepite     0.0      10  
    Gibbsite      0.0      10  
    Jurbanite     0.0      10  
    Basaluminite  0.0      10  
    Opal          0.0      10  
/
END



