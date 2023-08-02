<amanzi_input type="unstructured" version="2.3.0">
  <echo_translated_input format="unstructured_native" file_name="oldspec.xml"/>

  <model_description name="Farea 5layer 2D">
    <comments>Example input file</comments>
    <author>Konstantin Lipnikov</author>
    <units>
      <length_unit>m</length_unit>
      <time_unit>s</time_unit>
      <mass_unit>kg</mass_unit>
      <conc_unit>molar</conc_unit>
    </units>
  </model_description>

  <definitions>
    <macros>
      <time_macro name="Phase1">
        <start>1956.0 y</start>
        <timestep_interval>5.0 y</timestep_interval>
        <stop>2023.0 y</stop>
      </time_macro>

       <time_macro name="every month">
        <start>1956.0 y</start>
        <timestep_interval>2.592e+06</timestep_interval>
        <stop>2023.0 y</stop>
      </time_macro>

      <time_macro name="Every five year">
	<start>1956.0 y</start>
	<timestep_interval>5.0 y</timestep_interval>
	<stop>2023.0 y</stop>
      </time_macro>
    </macros>
  </definitions>

  <process_kernels>
    <flow model="richards" state="on" />
    <transport state="on" />
    <chemistry database="xmls/farea-full-new-nem.dat" engine="pflotran" state="on" input_filename="xmls/farea-full_nem@idx@.in"/>
  </process_kernels>

  <phases>
    <liquid_phase name="water">
      <viscosity>1.002e-3</viscosity>
      <density>998.2</density>
      <dissolved_components>
        <primaries>
          <primary coefficient_of_diffusion="1.0E-9">H+</primary>
          <primary coefficient_of_diffusion="1.0E-9">Al+++</primary>
          <primary coefficient_of_diffusion="1.0E-9">Ca++</primary>
          <primary coefficient_of_diffusion="1.0E-9">Cl-</primary>
          <primary coefficient_of_diffusion="1.0E-9">Fe+++</primary>
          <primary coefficient_of_diffusion="1.0E-9">CO2(aq)</primary>
          <primary coefficient_of_diffusion="1.0E-9">K+</primary>
          <primary coefficient_of_diffusion="1.0E-9">Mg++</primary>
          <primary coefficient_of_diffusion="1.0E-9">Na+</primary>
          <primary coefficient_of_diffusion="1.0E-9">SiO2(aq)</primary>
          <primary coefficient_of_diffusion="1.0E-9">SO4--</primary>
          <primary backward_rate="0.0" coefficient_of_diffusion="1.0E-9" first_order_decay_constant="1.78577e-09 ">Tritium</primary>          
          <primary coefficient_of_diffusion="1.0E-9">NO3-</primary>
          <primary coefficient_of_diffusion="1.0E-9">UO2++</primary>
          <primary coefficient_of_diffusion="1.0E-9">Tracer</primary>
        </primaries>
        <secondaries>
          <secondary>OH-</secondary>
          <secondary>HCO3-</secondary>
          <secondary>CO3--</secondary>
          <secondary>NaHCO3(aq)</secondary>
          <secondary>NaCO3-</secondary>
          <secondary>NaOH(aq)</secondary>
          <secondary>AlOH++</secondary>
          <secondary>Al(OH)2+</secondary>
          <secondary>Al(OH)3(aq)</secondary>
          <secondary>Al(OH)4-</secondary>
          <secondary>CaOH+</secondary>
          <secondary>CaHCO3+</secondary>
          <secondary>CaCO3(aq)</secondary>
          <secondary>MgOH+</secondary>
          <secondary>MgHCO3+</secondary>
          <secondary>MgCO3(aq)</secondary>
          <secondary>(UO2)2(OH)2++</secondary>
          <secondary>(UO2)2CO3(OH)3-</secondary>
          <secondary>(UO2)2OH+++</secondary>
          <secondary>(UO2)3(CO3)6(6-)</secondary>
          <secondary>(UO2)3(OH)4++</secondary>
          <secondary>UO2(OH)4--</secondary>
          <secondary>(UO2)3(OH)5+</secondary>
          <secondary>(UO2)3(OH)7-</secondary>
          <secondary>(UO2)3O(OH)2(HCO3)+</secondary>
          <secondary>(UO2)4(OH)7+</secondary>
          <secondary>UO2NO3+</secondary>
          <secondary>UO2OH+</secondary>
          <secondary>UO2(OH)2(aq)</secondary>
          <secondary>UO2(OH)3-</secondary>
          <secondary>UO2CO3(aq)</secondary>
          <secondary>Ca2UO2(CO3)3(aq)</secondary>
          <secondary>UO2(CO3)2--</secondary>
          <secondary>UO2(CO3)3----</secondary>
          <secondary>CaUO2(CO3)3--</secondary>
          <secondary>MgUO2(CO3)3--</secondary>
          <secondary>UO2OSi(OH)3+</secondary>
        </secondaries>
        <redox>
          <redox>Fe+++</redox>
        </redox>
      </dissolved_components>
    </liquid_phase>
    <solid_phase>
      <minerals>
        <mineral rate_constant="4.51855944374922E-10">Quartz</mineral>
        <mineral rate_constant="1.14815362149688E-04">Goethite</mineral>
        <mineral alpha="0.777" prefactor_species="H+" rate_constant="1.07894672222983E-09">Kaolinite</mineral>
        <mineral rate_constant="1.00000000000000E+06">Schoepite</mineral>
        <mineral rate_constant="3.16227766016838E-08">Gibbsite</mineral>
        <mineral rate_constant="1.00000000000000E-04">Jurbanite</mineral>
        <mineral rate_constant="1.00000000000000E-04">Basaluminite</mineral>
        <mineral rate_constant="4.84172367584100E-09">Opal</mineral>
      </minerals>
    </solid_phase>
    <gas_phase>
      <gases>
        <gas>CO2(g)</gas>
      </gases>
    </gas_phase>
  </phases>


  <geochemistry>
     <verbosity>silent</verbosity>
  </geochemistry>

  <execution_controls>

    <verbosity level="high" />
    <execution_control_defaults init_dt="1.0" method="picard" mode="steady" />
    <execution_control end="1954,y" mode="steady" start="0.0" init_dt="1000.0"/>
    <execution_control end="2023,y" mode="transient" start="1954,y" init_dt="60.0" />

  </execution_controls>


  <numerical_controls>
    <unstructured_controls>

        <unstr_flow_controls>
          <preconditioning_strategy>linearized_operator</preconditioning_strategy>
        </unstr_flow_controls>


      <unstr_steady-state_controls>
        <min_iterations>10</min_iterations>
        <max_iterations>15</max_iterations>
        <limit_iterations>20</limit_iterations>
        <max_preconditioner_lag_iterations>5</max_preconditioner_lag_iterations>
        <nonlinear_tolerance>1.0e-5</nonlinear_tolerance>
        <nonlinear_iteration_damping_factor>1</nonlinear_iteration_damping_factor>
        <nonlinear_iteration_divergence_factor>1000</nonlinear_iteration_divergence_factor>
        <restart_tolerance_relaxation_factor>100.0</restart_tolerance_relaxation_factor>
        <restart_tolerance_relaxation_factor_damping>0.9</restart_tolerance_relaxation_factor_damping>
        <max_divergent_iterations>3</max_divergent_iterations>

        <unstr_initialization>
          <method>darcy_solver</method>
          <linear_solver>aztecoo</linear_solver>
          <clipping_pressure>90000.0</clipping_pressure>
        </unstr_initialization>
      </unstr_steady-state_controls>

      <unstr_transient_controls>
        <min_iterations>10</min_iterations>
        <max_iterations>15</max_iterations>
        <limit_iterations>20</limit_iterations>
        <max_preconditioner_lag_iterations>5</max_preconditioner_lag_iterations>
        <nonlinear_tolerance>1.0e-5</nonlinear_tolerance>
        <nonlinear_iteration_damping_factor>1</nonlinear_iteration_damping_factor>
        <nonlinear_iteration_divergence_factor>1000</nonlinear_iteration_divergence_factor>
        <max_divergent_iterations>3</max_divergent_iterations>
      </unstr_transient_controls>

      <unstr_transport_controls>
        <algorithm>explicit first-order</algorithm>
        <sub_cycling>on</sub_cycling>
        <cfl>1</cfl> 
     </unstr_transport_controls>

      <unstr_chemistry_controls>
        <max_residual_tolerance>1.0e-18</max_residual_tolerance>
        <maximum_newton_terations>50</maximum_newton_terations>
        <auxiliary_data>pH</auxiliary_data>
        <initial_time_step>220000.0</initial_time_step>
        <max_time_step>220000.0</max_time_step>
        <time_step_cut_threshold>5</time_step_cut_threshold>
      </unstr_chemistry_controls>

      <unstr_linear_solver>
          <max_iterations>100</max_iterations>
          <tolerance>1e-20</tolerance>
      </unstr_linear_solver>
      <unstr_preconditioners>
          <hypre_amg />
          <trilinos_ml />
        <block_ilu />
      </unstr_preconditioners>
    </unstructured_controls>
  </numerical_controls>

  <mesh framework="mstk">
    <dimension>2</dimension>
    <read>
      <file>shared_files/refine_l2_nogordon.exo</file>
      <format>exodus ii</format>
    </read>
  </mesh>

  <regions>
    <region name="Lower aquifer">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="cell" label="30000"/>
    </region>
    <region name="Natural recharge (left)">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="face" label="1"/>
    </region>
    <region name="Natural recharge (right)">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="face" label="3"/>
    </region>
    <region name="Seepage basin">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="face" label="2"/>
    </region>
    <region name="Seepage face">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="face" label="4"/>
    </region>
    <region name="Tan_clay">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="cell" label="40000"/>
    </region>
    <region name="Upper_aquifer">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="cell" label="50000"/>
    </region>
    <region name="UTRA upstream">
      <region_file name="shared_files/refine_l2_nogordon.exo" type="labeled set" format="exodus ii" entity="face" label="8"/>
    </region>
    <point name="Well1"    coordinate =  "1866, 45" />
    <point name="Well2"    coordinate =  "1866, 46" />
    <point name="Well3"    coordinate =  "1866, 47" />
    <point name="Well4"    coordinate =  "1866, 48" />
    <point name="Well5"    coordinate =  "1866, 49" />
    <point name="Well6"    coordinate =  "1866, 50" />
    <point name="Well7"    coordinate =  "1866, 51" />
    <point name="Well8"    coordinate =  "1866, 52" />
    <point name="Well9"    coordinate =  "1866, 53" />
    <point name="Well10"   coordinate =  "1866, 54" />
    <point name="Well11"   coordinate =  "1866, 55" />
    <point name="Well12"   coordinate =  "1866, 56" />
    <point name="Well13"   coordinate =  "1866, 57" />
    <point name="Well14"   coordinate =  "1866, 58" />
    <point name="Well15"   coordinate =  "1866, 59" />
    <point name="Well16"   coordinate =  "1866, 60" />
    <point name="Well17"   coordinate =  "1866, 61" />
    <point name="Well18"   coordinate =  "1866, 62" />
    <point name="Well19"   coordinate =  "1866, 63" />
    <point name="Well20"   coordinate =  "1866, 64" />
    <point name="Well21"   coordinate =  "1866, 65" />
    <point name="Well22"   coordinate =  "1866, 66" />
    <point name="Well23"   coordinate =  "1866, 67" />
    <point name="Well24"   coordinate =  "1866, 68" />
    <point name="Well25"   coordinate =  "1866, 69" />
    <point name="Well26"   coordinate =  "1866, 70" />
    <point name="Well27"   coordinate =  "1866, 71" />
    <point name="Well28"   coordinate =  "1866, 72" />
    <point name="Well29"   coordinate =  "1866, 73" />
    <point name="Well30"   coordinate =  "1866, 74" />
    <point name="Well31"   coordinate =  "1866, 75" />
    <point name="Well32"   coordinate =  "2072, 55" />
    <point name="Well33"   coordinate =  "2072, 56" />
    <point name="Well34"   coordinate =  "2072, 57" />
    <point name="Well35"   coordinate =  "2072, 58" />
    <point name="Well36"   coordinate =  "2072, 59" />
    <point name="Well37"   coordinate =  "2072, 60" />
    <point name="Well38"   coordinate =  "2072, 61" />
    <point name="Well39"   coordinate =  "2072, 62" />
    <point name="Well40"   coordinate =  "2072, 63" />
    <point name="Well41"   coordinate =  "2072, 64" />
    <point name="Well42"   coordinate =  "2072, 65" />
    <point name="Well43"   coordinate =  "2072, 66" />
    <point name="Well44"   coordinate =  "2072, 67" />
    <point name="Well45"   coordinate =  "2072, 68" />
    <point name="Well46"   coordinate =  "2072, 69" />
    <point name="Well47"   coordinate =  "2072, 70" />
  </regions>


  <materials>
    <material name="Soil_3: Lower aquifer">
      <mechanical_properties>
        <porosity value="0.39"/>
      </mechanical_properties>
      <permeability x="5.0e-12" z="5.0e-12" />
      <cap_pressure model="van_genuchten">
        <parameters alpha="5.1e-05" m="0.5" sr="0.41" optional_krel_smoothing_interval="500.0"/>
      </cap_pressure>
      <rel_perm model="mualem"/>
      <minerals>
        <mineral name="Goethite" specific_surface_area="643811" volume_fraction="0.0093"/>
        <mineral name="Gibbsite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Jurbanite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Basaluminite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Schoepite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Opal" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Quartz" specific_surface_area="352035" volume_fraction="0.9496"/>
        <mineral name="Kaolinite" specific_surface_area="2213335" volume_fraction="0.0412"/>
      </minerals>
      <surface_complexation>
        <site density="2.66994E-3" name="&gt;xu_TOH">
          <complexes>(&gt;xu_T)OH2+</complexes>
          <complexes>(&gt;xu_T)O-</complexes>
        </site>
         <site density="6.10272E-3" name="&gt;xu_XOH">
          <complexes>(&gt;xu_X)OH2+</complexes>
          <complexes>(&gt;xu_X)OUO2+</complexes> 
        </site>
        <site density="3.43278E-3" name="&gt;xu_YOH">
          <complexes>(&gt;xu_Y)OH2+</complexes>
        </site>
      </surface_complexation>
      <ion_exchange>
        <cations cec="2.75">
          <cation name="Al+++" value="0.584341413374"/>
          <cation name="Na+" value="1"/>
          <cation name="H+" value="39.8107170553"/>
          <cation name="Ca++" value="3.16227766017"/>
        </cations>
      </ion_exchange>
      <assigned_regions>Lower aquifer</assigned_regions>
    </material>

    <material name="Soil_4: Tan_clay">
      <mechanical_properties>
        <porosity value="0.39"/>
     </mechanical_properties>
      <permeability x="1.98e-14" z="1.98e-14" />
      <cap_pressure model="van_genuchten">
        <parameters alpha="5.1e-05" m="0.5" sr="0.39" optional_krel_smoothing_interval="500.0"/>
      </cap_pressure>
      <rel_perm model="mualem"/>
      <minerals>
        <mineral name="Goethite" specific_surface_area="643811" volume_fraction="0.0093"/>
        <mineral name="Gibbsite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Jurbanite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Basaluminite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Schoepite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Opal" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Quartz" specific_surface_area="352035" volume_fraction="0.9496"/>
        <mineral name="Kaolinite" specific_surface_area="2213335" volume_fraction="0.0412"/>
      </minerals>
 
      <surface_complexation>
        <site density="2.66994E-3" name="&gt;xu_TOH">
          <complexes>(&gt;xu_T)OH2+</complexes>
          <complexes>(&gt;xu_T)O-</complexes>
        </site>
        <site density="6.10272E-3" name="&gt;xu_XOH">
          <complexes>(&gt;xu_X)OH2+</complexes>
          <complexes>(&gt;xu_X)OUO2+</complexes> 
        </site>
        <site density="3.43278E-3" name="&gt;xu_YOH">
          <complexes>(&gt;xu_Y)OH2+</complexes>
        </site>
      </surface_complexation>
      <ion_exchange>
        <cations cec="2.75">
          <cation name="Al+++" value="0.584341413374"/>
          <cation name="Na+" value="1"/>
          <cation name="H+" value="39.8107170553"/>
          <cation name="Ca++" value="3.16227766017"/>
        </cations>
      </ion_exchange>
      <assigned_regions>Tan_clay</assigned_regions>
    </material>

    <material name="Soil_5: Upper_aquifer">
      <mechanical_properties>
        <porosity value="@phi_u@"/>
      </mechanical_properties>
      <permeability x="@k_u@" z="@k_u@" />
      <cap_pressure model="van_genuchten">
        <parameters alpha="@alph_u@" m="@m_u@" sr="@sr_u@" optional_krel_smoothing_interval="500.0"/>
      </cap_pressure>
      <rel_perm model="mualem"/>
      <minerals>
        <mineral name="Goethite" specific_surface_area="643811" volume_fraction="0.0093"/>
        <mineral name="Gibbsite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Jurbanite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Basaluminite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Schoepite" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Opal" specific_surface_area="10.0" volume_fraction="0"/>
        <mineral name="Quartz" specific_surface_area="352035" volume_fraction="0.9496"/>
        <mineral name="Kaolinite" specific_surface_area="2213335" volume_fraction="0.0412"/>
      </minerals>
      <surface_complexation>
        <site density="2.66994E-3" name="&gt;xu_TOH">
          <complexes>(&gt;xu_T)OH2+</complexes>
          <complexes>(&gt;xu_T)O-</complexes>
        </site>
        <site density="6.10272E-3" name="&gt;xu_XOH">
          <complexes>(&gt;xu_X)OH2+</complexes>
          <complexes>(&gt;xu_X)OUO2+</complexes> 
        </site>
        <site density="3.43278E-3" name="&gt;xu_YOH">
          <complexes>(&gt;xu_Y)OH2+</complexes>
        </site>
      </surface_complexation>
      <ion_exchange>
        <cations cec="2.75">
          <cation name="Al+++" value="0.584341413374"/>
          <cation name="Na+" value="1"/>
          <cation name="H+" value="39.8107170553"/>
          <cation name="Ca++" value="3.16227766017"/>
        </cations>
      </ion_exchange>
      <assigned_regions>Upper_aquifer</assigned_regions>
    </material>
  </materials>

  <initial_conditions>
    <initial_condition name="All">
      <assigned_regions>Lower aquifer,Upper_aquifer,Tan_clay</assigned_regions>
      <liquid_phase name="water">
        <liquid_component name="water">
          <linear_pressure name="IC1" value="101325.0" reference_coord="0.0, 60.0" gradient="0,-9793.5192" />
        </liquid_component>
        <geochemistry_component>
          <constraint name="background"/>
        </geochemistry_component>
      </liquid_phase>
    </initial_condition>
  </initial_conditions>

  <boundary_conditions>
    <comments/>
    <boundary_condition name="BC 1: Seepage Face">
      <assigned_regions>Seepage face,Natural recharge (right)</assigned_regions>
      <liquid_phase name="water">
        <liquid_component name="water">
          <seepage_face function="constant" start="0.0" inward_mass_flux="@r_hist@"/>
        </liquid_component>
      </liquid_phase>
    </boundary_condition>

    <boundary_condition name="BC 2: Mass Flux">
      <assigned_regions>Natural recharge (left)</assigned_regions>
      <liquid_phase name="water">
        <liquid_component name="water">
          <inward_mass_flux value="@r_hist@" function="constant" start="0.0" />
        </liquid_component>
        <geochemistry_component>
          <constraint function="constant" name="recharge" start="0.0 y"/>
        </geochemistry_component>
      </liquid_phase>
    </boundary_condition>

    <boundary_condition name="BC 3: Mass Flux">
      <assigned_regions>Seepage basin</assigned_regions>
      <liquid_phase name="water">
        <liquid_component name="water">
          <inward_mass_flux value="@r_hist@" function="constant" start="0.0" />
          <inward_mass_flux value="0.000111348" function="constant" start="6.16635504e+10" />
	  <inward_mass_flux value="@r_after@" function="constant" start="6.27365088e+10" />
        </liquid_component>
        <geochemistry_component>
          <constraint function="constant" name="recharge" start="0.0 y"/>
          <constraint function="constant" name="seepage" start="6.16635504e+10"/>
          <constraint function="constant" name="recharge" start="6.27365088e+10"/>
        </geochemistry_component>
      </liquid_phase>
    </boundary_condition>

  </boundary_conditions>

  <output>
 
     <observations>
         <filename>output/observation_sim@idx@.out</filename>
       
       <liquid_phase name="water">

          <water_table>
            <assigned_regions>Well1</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well2</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well3</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well4</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well5</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well6</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
            <water_table>
            <assigned_regions>Well7</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well8</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well9</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well10</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
          <water_table>
            <assigned_regions>Well11</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well12</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well13</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
          <water_table>
           <assigned_regions>Well14</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well15</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well16</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well17</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
          <water_table>
            <assigned_regions>Well18</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </water_table>
           <water_table>
            <assigned_regions>Well19</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
           </water_table>
	   <water_table>
	     <assigned_regions>Well20</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well21</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well22</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well23</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well24</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well25</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well26</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well27</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well28</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well29</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well30</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well31</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well32</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well33</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well34</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well35</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well36</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well37</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well38</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well39</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well40</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well41</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well42</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well43</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well44</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well45</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well46</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>
	   <water_table>
	     <assigned_regions>Well47</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </water_table>

          <aqueous_conc solute="Tritium">
            <assigned_regions>Well1</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well2</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well3</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well4</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well5</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well6</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
            <aqueous_conc solute="Tritium">
            <assigned_regions>Well7</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well8</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well9</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well10</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
          <aqueous_conc solute="Tritium">
            <assigned_regions>Well11</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well12</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well13</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
          <aqueous_conc solute="Tritium">
           <assigned_regions>Well14</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well15</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well16</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
           <aqueous_conc solute="Tritium">
            <assigned_regions>Well17</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
          <aqueous_conc solute="Tritium">
            <assigned_regions>Well18</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
          </aqueous_conc>
          <aqueous_conc solute="Tritium">
            <assigned_regions>Well19</assigned_regions>
            <functional>point</functional>
            <time_macros>every month</time_macros>
	  </aqueous_conc>
	  <aqueous_conc solute="Tritium">
	     <assigned_regions>Well20</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	  </aqueous_conc>
	  <aqueous_conc solute="Tritium">
	     <assigned_regions>Well21</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	     <assigned_regions>Well22</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	     <assigned_regions>Well23</assigned_regions>
	     <functional>point</functional>
	     <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well24</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well25</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well26</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well27</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well28</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well29</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well30</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well31</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well32</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	   </aqueous_conc>
 	   <aqueous_conc solute="Tritium">
	      <assigned_regions>Well33</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	      <assigned_regions>Well34</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well35</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well36</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well37</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well38</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well39</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well40</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well41</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well42</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well43</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well44</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well45</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>	
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well46</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Tritium">
	       <assigned_regions>Well47</assigned_regions>
	       <functional>point</functional>
	       <time_macros>every month</time_macros>
	    </aqueous_conc>

            <sorbed_conc solute="UO2++">
              <assigned_regions>Well1</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well2</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well3</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well4</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well5</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well6</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
              <sorbed_conc solute="UO2++">
              <assigned_regions>Well7</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well8</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well9</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well10</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well11</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well12</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well13</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well14</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well15</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well16</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well17</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well18</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well19</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well20</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well21</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
	    <sorbed_conc solute="UO2++">
	      <assigned_regions>Well22</assigned_regions>
	      <functional>point</functional>
              <time_macros>every month</time_macros>
	    </sorbed_conc>
	    <sorbed_conc solute="UO2++">
	      <assigned_regions>Well23</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </sorbed_conc>
	    <sorbed_conc solute="UO2++">
	      <assigned_regions>Well24</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </sorbed_conc>
	    <sorbed_conc solute="UO2++">
	      <assigned_regions>Well25</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </sorbed_conc>
	    <sorbed_conc solute="UO2++">
	      <assigned_regions>Well26</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </sorbed_conc>
	    <sorbed_conc solute="UO2++">
	      <assigned_regions>Well27</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well28</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well29</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well30</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well31</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well32</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well33</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well34</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well35</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well36</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well37</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well38</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well39</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well40</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well41</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well42</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well43</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well44</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well45</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well46</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>
            <sorbed_conc solute="UO2++">
              <assigned_regions>Well47</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </sorbed_conc>

            <aqueous_conc solute="UO2++">
              <assigned_regions>Well1</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well2</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well3</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well4</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
	    <aqueous_conc solute="UO2++">
              <assigned_regions>Well5</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
	    <aqueous_conc solute="UO2++">
              <assigned_regions>Well6</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well7</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well8</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well9</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well10</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well11</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well12</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well13</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well14</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well15</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well16</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well17</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well18</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="UO2++">
              <assigned_regions>Well19</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well20</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well21</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well22</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well23</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well24</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well25</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well26</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well27</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well28</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well29</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well30</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well31</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well32</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well33</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well34</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well35</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well36</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well37</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well38</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well39</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well40</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well41</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well42</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well43</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well44</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well45</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well46</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
  	    </aqueous_conc>
  	    <aqueous_conc solute="UO2++">
  	      <assigned_regions>Well47</assigned_regions>
  	      <functional>point</functional>
  	      <time_macros>every month</time_macros>
	    </aqueous_conc>

            <ph>
              <assigned_regions>Well1</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well2</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well3</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well4</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well5</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well6</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well7</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well8</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well9</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well10</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well11</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well12</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well13</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well14</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well15</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well16</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well17</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well18</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well19</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well20</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well21</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well22</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well23</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well24</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well25</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well26</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well27</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well28</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well29</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well30</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well31</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well32</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well33</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well34</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well35</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well36</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well37</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well38</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well39</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well40</assigned_regions>
              <functional>point</functional>
                  <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well41</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well42</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well43</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well44</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well45</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well46</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>
            <ph>
              <assigned_regions>Well47</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </ph>

      
            <aqueous_conc solute="Al+++">
              <assigned_regions>Well1</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well2</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well3</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well4</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well5</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well6</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
              <aqueous_conc solute="Al+++">
              <assigned_regions>Well7</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well8</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well9</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well10</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="Al+++">
              <assigned_regions>Well11</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well12</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well13</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="Al+++">
             <assigned_regions>Well14</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="Al+++">
              <assigned_regions>Well15</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="Al+++">
              <assigned_regions>Well16</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="Al+++">
              <assigned_regions>Well17</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="Al+++">
              <assigned_regions>Well18</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="Al+++">
              <assigned_regions>Well19</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well20</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
 	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well21</assigned_regions>
 	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well22</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well23</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well24</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well25</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well26</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well27</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well28</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well29</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well30</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well31</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well32</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well33</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well34</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well35</assigned_regions>
	      <functional>point</functional>
              <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well36</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well37</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well38</assigned_regions>
	      <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well39</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well40</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well41</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well42</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well43</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well44</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well45</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well46</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>
	    <aqueous_conc solute="Al+++">
	      <assigned_regions>Well47</assigned_regions>
	      <functional>point</functional>
	      <time_macros>every month</time_macros>
	    </aqueous_conc>

            <aqueous_conc solute="NO3-">
              <assigned_regions>Well1</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well2</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well3</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well4</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well5</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well6</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
              <aqueous_conc solute="NO3-">
              <assigned_regions>Well7</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well8</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well9</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well10</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="NO3-">
              <assigned_regions>Well11</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well12</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well13</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="NO3-">
             <assigned_regions>Well14</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well15</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well16</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well17</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
            <aqueous_conc solute="NO3-">
              <assigned_regions>Well18</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
            </aqueous_conc>
             <aqueous_conc solute="NO3-">
              <assigned_regions>Well19</assigned_regions>
              <functional>point</functional>
              <time_macros>every month</time_macros>
             </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well20</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well21</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well22</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well23</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well24</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well25</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well26</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well27</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well28</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well29</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well30</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well31</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well32</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well33</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well34</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well35</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well36</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well37</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well38</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well39</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well40</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well41</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well42</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well43</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	     <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well44</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well45</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well46</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
  	   <aqueous_conc solute="NO3-">
  	     <assigned_regions>Well47</assigned_regions>
  	     <functional>point</functional>
  	     <time_macros>every month</time_macros>
  	   </aqueous_conc>
          
           <aqueous_conc solute="Tracer">
             <assigned_regions>Well10</assigned_regions>
             <functional>point</functional>
             <time_macros>every month</time_macros>
           </aqueous_conc>
           <aqueous_conc solute="Tracer">
             <assigned_regions>Well12</assigned_regions>
             <functional>point</functional>
             <time_macros>every month</time_macros>
           </aqueous_conc>
           <aqueous_conc solute="Tracer">
             <assigned_regions>Well14</assigned_regions>
             <functional>point</functional>
             <time_macros>every month</time_macros>
           </aqueous_conc>
           <aqueous_conc solute="Tracer">
             <assigned_regions>Well16</assigned_regions>
             <functional>point</functional>
             <time_macros>every month</time_macros>
           </aqueous_conc>
           <aqueous_conc solute="Tracer">
             <assigned_regions>Well18</assigned_regions>
             <functional>point</functional>
             <time_macros>every month</time_macros>
           </aqueous_conc>
           <aqueous_conc solute="Tracer">
             <assigned_regions>Well38</assigned_regions>
             <functional>point</functional>
             <time_macros>every month</time_macros>
           </aqueous_conc>

        </liquid_phase>
      </observations>

    <vis>
      <base_filename>vis/plot_sim@idx@</base_filename>
      <num_digits>5</num_digits>
      <time_macros>Phase1</time_macros>
      <blacklist>alquimia_aux.*,free_ion.*,primary.*,secondary.*,ion_exchange_ref.*,mineral_reaction.*,mineral_specific.*,mineral_rate_constant.*,mineral_saturation_index.*,mineral_specific_surface_area.*,mineral_volumn_fractions.*</blacklist>
    </vis>
    <checkpoint>
      <base_filename>checkpoints/chk_sim@idx@_</base_filename>
      <num_digits>5</num_digits>
      <time_macros>Every five year</time_macros>
    </checkpoint>
  </output>

</amanzi_input>
  

