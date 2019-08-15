﻿within IBPSA.Media.Refrigerants.R32;
package R32_IIR_P1_70_T233_373_Formula "\"Refrigerant model for R32 using a hybrid approach with explicit formulas\""
 /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
    */
    constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
    each chemicalFormula="CH2F2",
    each structureFormula="CH2F2",
    each casRegistryNumber="75-10-5",
    each iupacName="Difluoromethane",
    each molarMass=0.052024,
    each criticalTemperature=351.255,
    each criticalPressure=5782000,
    each criticalMolarVolume=0.052024/424,
    each triplePointTemperature=136.34,
    each triplePointPressure=47.9998938761,
    each normalBoilingPoint= 221,
    each meltingPoint= 137,
    each acentricFactor=0.2769,
    each dipoleMoment=0,
    each hasCriticalData=true) "Thermodynamic constants for R32";

    /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    IBPSA.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
  mediumName="R32",
  substanceNames={"R32"},
  singleState=false,
  SpecificEnthalpy(
    start=200000,
    nominal=200000,
    min=135338.010258576,
    max=627424.654013774),
  Density(
    start=500,
    nominal=350,
    min=1.68595438516567,
    max=1191.29136885037),
  AbsolutePressure(
    start=10e5,
    nominal=10e5,
    min=1e5,
    max=57.82e5),
  Temperature(
    start=268.37,
    nominal=333.15,
    min=233.15,
    max=373.15),
  smoothModel=true,
  onePhase=false,
  ThermoStates=Choices.IndependentVariables.phX,
  fluidConstants=refrigerantConstants);

    redeclare record SmoothTransition "Record that contains ranges to calculate a smooth transition between different regions"
    SpecificEnthalpy T_ph=2.5;
    SpecificEntropy T_ps=2.5;
    AbsolutePressure d_pT=2.5;
    SpecificEnthalpy d_ph=2.5;
    Real d_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
    annotation (Documentation(info=
                                 "<html>
<p>Record that contains ranges to calculate a smooth transition between different regions.</p>
</html>"));
    end SmoothTransition;

     redeclare function extends f_Idg
  "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
     algorithm
  f_Idg :=
       log(delta) +
       (3.004486)*log(tau^(1)) +
       (-8.258096)*tau^(0) +
       (6.353098)*tau^(1) +
       (1.160761)*log(1 - exp(-(2.2718538)*tau)) +
       (2.645151)*log(1 - exp(-(11.9144210)*tau)) +
       (5.794987)*log(1 - exp(-(5.1415638)*tau)) +
       (1.129475)*log(1 - exp(-(32.7682170)*tau));
  annotation (Documentation(info="<html>
<p>Dimensionless&nbsp;Helmholtz&nbsp;energy&nbsp;(Ideal&nbsp;gas&nbsp;contribution&nbsp;alpha_0).</p>
</html>"));
     end f_Idg;

  redeclare function extends f_Res
    "Dimensionless Helmholtz energy (Residual part alpha_r)"
  algorithm
    f_Res :=
    (0.1046634e1) * delta^(1) * tau^(0.25) +
    (-0.5451165) * delta^(2) * tau^(1) +
    (-0.2448595e-2) * delta^(5) * tau^(-0.25) +
    (-0.4877002e-1) * delta^(1) * tau^(-1) +
    (0.3520158e-1) * delta^(1) * tau^(2) +
    (0.1622750e-2) * delta^(3) * tau^(2) +
    (0.2377225e-4) * delta^(8) * tau^(0.75) +
    (0.29149e-1) * delta^(4) * tau^(0.25) +
    (0.3386203e-2)* delta^(4) * tau^(18) * exp(-delta^(4)) +
    (-0.4202444e-2)* delta^(4) * tau^(26) * exp(-delta^(3)) +
    (0.4782025e-3)* delta^(8) * tau^(-1) * exp(-delta^(1)) +
    (-0.5504323e-2)* delta^(3) * tau^(25) * exp(-delta^(4)) +
    (-0.2418396e-1)* delta^(5) * tau^(1.75) * exp(-delta^(1)) +
    (0.4209034)* delta^(1) * tau^(4) * exp(-delta^(2)) +
    (-0.4616537)* delta^(1) * tau^(5) * exp(-delta^(2)) +
    (-0.1200513e1)* delta^(3) * tau^(1) * exp(-delta^(1)) +
    (-0.2591550e1)* delta^(1) * tau^(1.5) * exp(-delta^(1)) +
    (-0.1400145e1)* delta^(2) * tau^(1) * exp(-delta^(1)) +
    (0.8263017)* delta^(3) * tau^(0.5) * exp(-delta^(1));
  annotation (Documentation(info="<html>
<p>Dimensionless&nbsp;Helmholtz&nbsp;energy&nbsp;(Residual&nbsp;part&nbsp;alpha_r).</p>
</html>"));
  end f_Res;

  redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"
  algorithm
    t_fIdg_t :=
     (3.004486)*(1) +
     (6.353098)*(1)*tau^(1) +
     tau*(1.160761)*(2.2718538)/(exp((2.2718538)*tau)-1) +
     tau*(2.645151)*(11.9144210)/(exp((11.9144210)*tau)-1) +
     tau*(5.794987)*(5.1415638)/(exp((5.1415638)*tau)-1) +
     tau*(1.129475)*(32.7682170)/(exp((32.7682170)*tau)-1);
  annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*(dalpha_0/dtau)_delta=const.</p>
</html>"));
  end t_fIdg_t;

  redeclare function extends tt_fIdg_tt
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
  algorithm
    tt_fIdg_tt :=  - 3.004486*1
                   - tau^2*1.160761*2.2718538^2*exp(-2.2718538*tau)/((1-exp(-2.2718538*tau))^2)
                   - tau^2*2.645151*11.9144210^2*exp(-11.9144210*tau)/((1-exp(-11.9144210*tau))^2)
                   - tau^2*5.794987*5.1415638^2*exp(-5.1415638*tau)/((1-exp(-5.1415638*tau))^2)
                   - tau^2*1.129475*32.7682170^2*exp(-32.7682170*tau)/((1-exp(-32.7682170*tau))^2);
  annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*(ddalpha_0/(dtau*dtau))_delta=const.</p>
</html>"));
  end tt_fIdg_tt;

  redeclare function extends t_fRes_t
    "Short form for tau*(dalpha_r/dtau)_delta=const"
  algorithm
    t_fRes_t :=(0.1046634e1)*(0.25)*delta^(1)*tau^(0.25) + (-0.5451165)*(1)*
      delta^(2)*tau^(1) + (-0.2448595e-2)*(-0.25)*delta^(5)*tau^(-0.25) + (-0.4877002e-1)
      *(-1)*delta^(1)*tau^(-1) + (0.3520158e-1)*(2)*delta^(1)*tau^(2) + (0.1622750e-2)
      *(2)*delta^(3)*tau^(2) + (0.2377225e-4)*(0.75)*delta^(8)*tau^(0.75) + (0.29149e-1)
      *(0.25)*delta^(4)*tau^(0.25) + (0.3386203e-2)*(18)*delta^(4)*tau^(18)*exp(
       -delta^(4)) + (-0.4202444e-2)*(26)*delta^(4)*tau^(26)*exp(-delta^(3)) + (
      0.4782025e-3)*(-1)*delta^(8)*tau^(-1)*exp(-delta^(1)) + (-0.5504323e-2)*(25)
      *delta^(3)*tau^(25)*exp(-delta^(4)) + (-0.2418396e-1)*(1.75)*delta^(5)*
      tau^(1.75)*exp(-delta^(1)) + (0.4209034)*(4)*delta^(1)*tau^(4)*exp(-delta^
      (2)) + (-0.4616537)*(5)*delta^(1)*tau^(5)*exp(-delta^(2)) + (-0.1200513e1)
      *(1)*delta^(3)*tau^(1)*exp(-delta^(1)) + (-0.2591550e1)*(1.5)*delta^(1)*
      tau^(1.5)*exp(-delta^(1)) + (-0.1400145e1)*(1)*delta^(2)*tau^(1)*exp(-
      delta^(1)) + (0.8263017)*(0.5)*delta^(3)*tau^(0.5)*exp(-delta^(1));
  annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*(dalpha_r/dtau)_delta=const.</p>
</html>"));
  end t_fRes_t;

  redeclare function extends tt_fRes_tt
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"
  algorithm
    tt_fRes_tt :=(0.1046634e1)*(0.25)*((0.25) - 1)*delta^(1)*tau^(0.25) + (-0.5451165)
      *(1)*((1) - 1)*delta^(2)*tau^(1) + (-0.2448595e-2)*(-0.25)*((-0.25) - 1)*
      delta^(5)*tau^(-0.25) + (-0.4877002e-1)*(-1)*((-1) - 1)*delta^(1)*tau^(-1)
       + (0.3520158e-1)*(2)*((2) - 1)*delta^(1)*tau^(2) + (0.1622750e-2)*(2)*((2)
       - 1)*delta^(3)*tau^(2) + (0.2377225e-4)*(0.75)*((0.75) - 1)*delta^(8)*
      tau^(0.75) + (0.29149e-1)*(0.25)*((0.25) - 1)*delta^(4)*tau^(0.25) + (0.3386203e-2)
      *(18)*((18) - 1)*delta^(4)*tau^(18)*exp(-delta^(4)) + (-0.4202444e-2)*(26)
      *((26) - 1)*delta^(4)*tau^(26)*exp(-delta^(3)) + (0.4782025e-3)*(-1)*((-1)
       - 1)*delta^(8)*tau^(-1)*exp(-delta^(1)) + (-0.5504323e-2)*(25)*((25) - 1)
      *delta^(3)*tau^(25)*exp(-delta^(4)) + (-0.2418396e-1)*(1.75)*((1.75) - 1)*
      delta^(5)*tau^(1.75)*exp(-delta^(1)) + (0.4209034)*(4)*((4) - 1)*delta^(1)
      *tau^(4)*exp(-delta^(2)) + (-0.4616537)*(5)*((5) - 1)*delta^(1)*tau^(5)*
      exp(-delta^(2)) + (-0.1200513e1)*(1)*((1) - 1)*delta^(3)*tau^(1)*exp(-
      delta^(1)) + (-0.2591550e1)*(1.5)*((1.5) - 1)*delta^(1)*tau^(1.5)*exp(-
      delta^(1)) + (-0.1400145e1)*(1)*((1) - 1)*delta^(2)*tau^(1)*exp(-delta^(1))
       + (0.8263017)*(0.5)*((0.5) - 1)*delta^(3)*tau^(0.5)*exp(-delta^(1));
  annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*(ddalpha_r/(dtau*dtau))_delta=const.</p>
</html>"));
  end tt_fRes_tt;

   redeclare function extends d_fRes_d
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"
   algorithm
     d_fRes_d :=(0.1046634e1)*(1)*delta^(1)*tau^(0.25) + (-0.5451165)*(2)*delta^
      (2)*tau^(1) + (-0.2448595e-2)*(5)*delta^(5)*tau^(-0.25) + (-0.4877002e-1)*
      (1)*delta^(1)*tau^(-1) + (0.3520158e-1)*(1)*delta^(1)*tau^(2) + (0.1622750e-2)
      *(3)*delta^(3)*tau^(2) + (0.2377225e-4)*(8)*delta^(8)*tau^(0.75) + (0.29149e-1)
      *(4)*delta^(4)*tau^(0.25) + (0.3386203e-2)*delta^(4)*tau^(18)*exp(-delta^(
      4))*((4) - (4)*delta^(4)) + (-0.4202444e-2)*delta^(4)*tau^(26)*exp(-delta^
      (3))*((4) - (3)*delta^(3)) + (0.4782025e-3)*delta^(8)*tau^(-1)*exp(-delta^
      (1))*((8) - (1)*delta^(1)) + (-0.5504323e-2)*delta^(3)*tau^(25)*exp(-
      delta^(4))*((3) - (4)*delta^(4)) + (-0.2418396e-1)*delta^(5)*tau^(1.75)*
      exp(-delta^(1))*((5) - (1)*delta^(1)) + (0.4209034)*delta^(1)*tau^(4)*exp(
       -delta^(2))*((1) - (2)*delta^(2)) + (-0.4616537)*delta^(1)*tau^(5)*exp(-
      delta^(2))*((1) - (2)*delta^(2)) + (-0.1200513e1)*delta^(3)*tau^(1)*exp(-
      delta^(1))*((3) - (1)*delta^(1)) + (-0.2591550e1)*delta^(1)*tau^(1.5)*exp(
       -delta^(1))*((1) - (1)*delta^(1)) + (-0.1400145e1)*delta^(2)*tau^(1)*exp(
       -delta^(1))*((2) - (1)*delta^(1)) + (0.8263017)*delta^(3)*tau^(0.5)*exp(-
      delta^(1))*((3) - (1)*delta^(1));
    annotation (Documentation(info=
                                 "<html>
<p>Short&nbsp;form&nbsp;for&nbsp;delta*(dalpha_r/(ddelta))_tau=const.</p>
</html>"));
   end d_fRes_d;

   redeclare function extends dd_fRes_dd
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"
   algorithm
     dd_fRes_dd :=(0.1046634e1)*(1)*((1) - 1)*delta^(1)*tau^(0.25) + (-0.5451165)
      *(2)*((2) - 1)*delta^(2)*tau^(1) + (-0.2448595e-2)*(5)*((5) - 1)*delta^(5)
      *tau^(-0.25) + (-0.4877002e-1)*(1)*((1) - 1)*delta^(1)*tau^(-1) + (0.3520158e-1)
      *(1)*((1) - 1)*delta^(1)*tau^(2) + (0.1622750e-2)*(3)*((3) - 1)*delta^(3)*
      tau^(2) + (0.2377225e-4)*(8)*((8) - 1)*delta^(8)*tau^(0.75) + (0.29149e-1)
      *(4)*((4) - 1)*delta^(4)*tau^(0.25) + (0.3386203e-2)*delta^(4)*tau^(18)*
      exp(-delta^(4))*(((4) - 1 - (4)*delta^(4))*((4) - (4)*delta^(4)) - (4)^2*
      delta^(4)) + (-0.4202444e-2)*delta^(4)*tau^(26)*exp(-delta^(3))*(((4) - 1 -
      (3)*delta^(3))*((4) - (3)*delta^(3)) - (3)^2*delta^(3)) + (0.4782025e-3)*
      delta^(8)*tau^(-1)*exp(-delta^(1))*(((8) - 1 - (1)*delta^(1))*((8) - (1)*
      delta^(1)) - (1)^2*delta^(1)) + (-0.5504323e-2)*delta^(3)*tau^(25)*exp(-
      delta^(4))*(((3) - 1 - (4)*delta^(4))*((3) - (4)*delta^(4)) - (4)^2*delta^
      (4)) + (-0.2418396e-1)*delta^(5)*tau^(1.75)*exp(-delta^(1))*(((5) - 1 - (1)
      *delta^(1))*((5) - (1)*delta^(1)) - (1)^2*delta^(1)) + (0.4209034)*delta^(
      1)*tau^(4)*exp(-delta^(2))*(((1) - 1 - (2)*delta^(2))*((1) - (2)*delta^(2))
       - (2)^2*delta^(2)) + (-0.4616537)*delta^(1)*tau^(5)*exp(-delta^(2))*(((1)
       - 1 - (2)*delta^(2))*((1) - (2)*delta^(2)) - (2)^2*delta^(2)) + (-0.1200513e1)
      *delta^(3)*tau^(1)*exp(-delta^(1))*(((3) - 1 - (1)*delta^(1))*((3) - (1)*
      delta^(1)) - (1)^2*delta^(1)) + (-0.2591550e1)*delta^(1)*tau^(1.5)*exp(-
      delta^(1))*(((1) - 1 - (1)*delta^(1))*((1) - (1)*delta^(1)) - (1)^2*delta^
      (1)) + (-0.1400145e1)*delta^(2)*tau^(1)*exp(-delta^(1))*(((2) - 1 - (1)*
      delta^(1))*((2) - (1)*delta^(1)) - (1)^2*delta^(1)) + (0.8263017)*delta^(3)
      *tau^(0.5)*exp(-delta^(1))*(((3) - 1 - (1)*delta^(1))*((3) - (1)*delta^(1))
       - (1)^2*delta^(1));

    annotation (Documentation(info=
                                 "<html>
<p>Short&nbsp;form&nbsp;for&nbsp;delta*delta(ddalpha_r/(ddelta*delta))_tau=const.</p>
</html>"));
   end dd_fRes_dd;

   redeclare function extends td_fRes_td
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
   algorithm
     td_fRes_td :=(0.1046634e1)*(1)*(0.25)*delta^(1)*tau^(0.25) + (-0.5451165)*(
      2)*(1)*delta^(2)*tau^(1) + (-0.2448595e-2)*(5)*(-0.25)*delta^(5)*tau^(-0.25)
       + (-0.4877002e-1)*(1)*(-1)*delta^(1)*tau^(-1) + (0.3520158e-1)*(1)*(2)*
      delta^(1)*tau^(2) + (0.1622750e-2)*(3)*(2)*delta^(3)*tau^(2) + (0.2377225e-4)
      *(8)*(0.75)*delta^(8)*tau^(0.75) + (0.29149e-1)*(4)*(0.25)*delta^(4)*tau^(
      0.25) + (0.3386203e-2)*(18)*delta^(4)*tau^(18)*exp(-delta^(4))*((4) - (4)*
      delta^(4)) + (-0.4202444e-2)*(26)*delta^(4)*tau^(26)*exp(-delta^(3))*((4) -
      (3)*delta^(3)) + (0.4782025e-3)*(-1)*delta^(8)*tau^(-1)*exp(-delta^(1))*((
      8) - (1)*delta^(1)) + (-0.5504323e-2)*(25)*delta^(3)*tau^(25)*exp(-delta^(
      4))*((3) - (4)*delta^(4)) + (-0.2418396e-1)*(1.75)*delta^(5)*tau^(1.75)*
      exp(-delta^(1))*((5) - (1)*delta^(1)) + (0.4209034)*(4)*delta^(1)*tau^(4)*
      exp(-delta^(2))*((1) - (2)*delta^(2)) + (-0.4616537)*(5)*delta^(1)*tau^(5)
      *exp(-delta^(2))*((1) - (2)*delta^(2)) + (-0.1200513e1)*(1)*delta^(3)*tau^
      (1)*exp(-delta^(1))*((3) - (1)*delta^(1)) + (-0.2591550e1)*(1.5)*delta^(1)
      *tau^(1.5)*exp(-delta^(1))*((1) - (1)*delta^(1)) + (-0.1400145e1)*(1)*
      delta^(2)*tau^(1)*exp(-delta^(1))*((2) - (1)*delta^(1)) + (0.8263017)*(0.5)
      *delta^(3)*tau^(0.5)*exp(-delta^(1))*((3) - (1)*delta^(1));

    annotation (Documentation(info=
                                 "<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*delta*(ddalpha_r/(dtau*ddelta)).</p>
</html>"));
   end td_fRes_td;

   redeclare function extends ttt_fIdg_ttt
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
   algorithm
     ttt_fIdg_ttt :=2*(3.004486)*(1) + tau^3*(1.160761)*(2.2718538)^3*exp((2.2718538)
      *tau)*(exp((2.2718538)*tau) + 1)/((exp((2.2718538)*tau) - 1)^3) + tau^3*(2.645151)
      *(11.9144210)^3*exp((11.9144210)*tau)*(exp((11.9144210)*tau) + 1)/((exp((11.9144210)
      *tau) - 1)^3) + tau^3*(5.794987)*(5.1415638)^3*exp((5.1415638)*tau)*(exp((
      5.1415638)*tau) + 1)/((exp((5.1415638)*tau) - 1)^3) + tau^3*(1.129475)*(32.7682170)
      ^3*exp((32.7682170)*tau)*(exp((32.7682170)*tau) + 1)/((exp((32.7682170)*
      tau) - 1)^3);

    annotation (Documentation(info=
                                 "<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const.</p>
</html>"));
   end ttt_fIdg_ttt;

   redeclare function extends ttt_fRes_ttt
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"
   algorithm
     ttt_fRes_ttt :=(0.1046634e1)*(0.25)*((0.25) - 1)*((0.25) - 2)*delta^(1)*
      tau^(0.25) + (-0.5451165)*(1)*((1) - 1)*((1) - 2)*delta^(2)*tau^(1) + (-0.2448595e-2)
      *(-0.25)*((-0.25) - 1)*((-0.25) - 2)*delta^(5)*tau^(-0.25) + (-0.4877002e-1)
      *(-1)*((-1) - 1)*((-1) - 2)*delta^(1)*tau^(-1) + (0.3520158e-1)*(2)*((2) -
      1)*((2) - 2)*delta^(1)*tau^(2) + (0.1622750e-2)*(2)*((2) - 1)*((2) - 2)*
      delta^(3)*tau^(2) + (0.2377225e-4)*(0.75)*((0.75) - 1)*((0.75) - 2)*delta^
      (8)*tau^(0.75) + (0.29149e-1)*(0.25)*((0.25) - 1)*((0.25) - 2)*delta^(4)*
      tau^(0.25) + (0.3386203e-2)*(18)*((18) - 1)*((18) - 2)*delta^(4)*tau^(18)*
      exp(-delta^(4)) + (-0.4202444e-2)*(26)*((26) - 1)*((26) - 2)*delta^(4)*
      tau^(26)*exp(-delta^(3)) + (0.4782025e-3)*(-1)*((-1) - 1)*((-1) - 2)*
      delta^(8)*tau^(-1)*exp(-delta^(1)) + (-0.5504323e-2)*(25)*((25) - 1)*((25)
       - 2)*delta^(3)*tau^(25)*exp(-delta^(4)) + (-0.2418396e-1)*(1.75)*((1.75) -
      1)*((1.75) - 2)*delta^(5)*tau^(1.75)*exp(-delta^(1)) + (0.4209034)*(4)*((4)
       - 1)*((4) - 2)*delta^(1)*tau^(4)*exp(-delta^(2)) + (-0.4616537)*(5)*((5) -
      1)*((5) - 2)*delta^(1)*tau^(5)*exp(-delta^(2)) + (-0.1200513e1)*(1)*((1) -
      1)*((1) - 2)*delta^(3)*tau^(1)*exp(-delta^(1)) + (-0.2591550e1)*(1.5)*((1.5)
       - 1)*((1.5) - 2)*delta^(1)*tau^(1.5)*exp(-delta^(1)) + (-0.1400145e1)*(1)
      *((1) - 1)*((1) - 2)*delta^(2)*tau^(1)*exp(-delta^(1)) + (0.8263017)*(0.5)
      *((0.5) - 1)*((0.5) - 2)*delta^(3)*tau^(0.5)*exp(-delta^(1));

    annotation (Documentation(info=
                                 "<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const.</p>
</html>"));
   end ttt_fRes_ttt;

  redeclare function extends ddd_fRes_ddd
   "Short form for delta*delta*delta*
   (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"
  algorithm
   ddd_fRes_ddd :=(0.1046634e1)*(1)*((1) - 1)*((1) - 2)*delta^(1)*tau^(0.25) + (
      -0.5451165)*(2)*((2) - 1)*((2) - 2)*delta^(2)*tau^(1) + (-0.2448595e-2)*(5)
      *((5) - 1)*((5) - 2)*delta^(5)*tau^(-0.25) + (-0.4877002e-1)*(1)*((1) - 1)
      *((1) - 2)*delta^(1)*tau^(-1) + (0.3520158e-1)*(1)*((1) - 1)*((1) - 2)*
      delta^(1)*tau^(2) + (0.1622750e-2)*(3)*((3) - 1)*((3) - 2)*delta^(3)*tau^(
      2) + (0.2377225e-4)*(8)*((8) - 1)*((8) - 2)*delta^(8)*tau^(0.75) + (0.29149e-1)
      *(4)*((4) - 1)*((4) - 2)*delta^(4)*tau^(0.25) - (0.3386203e-2)*delta^(4)*
      tau^(18)*exp(-delta^(4))*((4)*delta^(4)*((4)*(delta^(4)*((4)*(delta^(4) -
      3) - 3*(4) + 3) + (4) + 3*(4) - 3) + 3*(4)^2 - 6*(4) + 2) - ((4) - 2)*((4)
       - 1)*(4)) - (-0.4202444e-2)*delta^(4)*tau^(26)*exp(-delta^(3))*((3)*
      delta^(3)*((3)*(delta^(3)*((3)*(delta^(3) - 3) - 3*(4) + 3) + (3) + 3*(4) -
      3) + 3*(4)^2 - 6*(4) + 2) - ((4) - 2)*((4) - 1)*(4)) - (0.4782025e-3)*
      delta^(8)*tau^(-1)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*(
      delta^(1) - 3) - 3*(8) + 3) + (1) + 3*(8) - 3) + 3*(8)^2 - 6*(8) + 2) - ((
      8) - 2)*((8) - 1)*(8)) - (-0.5504323e-2)*delta^(3)*tau^(25)*exp(-delta^(4))
      *((4)*delta^(4)*((4)*(delta^(4)*((4)*(delta^(4) - 3) - 3*(3) + 3) + (4) +
      3*(3) - 3) + 3*(3)^2 - 6*(3) + 2) - ((3) - 2)*((3) - 1)*(3)) - (-0.2418396e-1)
      *delta^(5)*tau^(1.75)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*
      (delta^(1) - 3) - 3*(5) + 3) + (1) + 3*(5) - 3) + 3*(5)^2 - 6*(5) + 2) - (
      (5) - 2)*((5) - 1)*(5)) - (0.4209034)*delta^(1)*tau^(4)*exp(-delta^(2))*((
      2)*delta^(2)*((2)*(delta^(2)*((2)*(delta^(2) - 3) - 3*(1) + 3) + (2) + 3*(
      1) - 3) + 3*(1)^2 - 6*(1) + 2) - ((1) - 2)*((1) - 1)*(1)) - (-0.4616537)*
      delta^(1)*tau^(5)*exp(-delta^(2))*((2)*delta^(2)*((2)*(delta^(2)*((2)*(
      delta^(2) - 3) - 3*(1) + 3) + (2) + 3*(1) - 3) + 3*(1)^2 - 6*(1) + 2) - ((
      1) - 2)*((1) - 1)*(1)) - (-0.1200513e1)*delta^(3)*tau^(1)*exp(-delta^(1))*
      ((1)*delta^(1)*((1)*(delta^(1)*((1)*(delta^(1) - 3) - 3*(3) + 3) + (1) + 3
      *(3) - 3) + 3*(3)^2 - 6*(3) + 2) - ((3) - 2)*((3) - 1)*(3)) - (-0.2591550e1)
      *delta^(1)*tau^(1.5)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*(
      delta^(1) - 3) - 3*(1) + 3) + (1) + 3*(1) - 3) + 3*(1)^2 - 6*(1) + 2) - ((
      1) - 2)*((1) - 1)*(1)) - (-0.1400145e1)*delta^(2)*tau^(1)*exp(-delta^(1))*
      ((1)*delta^(1)*((1)*(delta^(1)*((1)*(delta^(1) - 3) - 3*(2) + 3) + (1) + 3
      *(2) - 3) + 3*(2)^2 - 6*(2) + 2) - ((2) - 2)*((2) - 1)*(2)) - (0.8263017)*
      delta^(3)*tau^(0.5)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1)*((1)*(
      delta^(1) - 3) - 3*(3) + 3) + (1) + 3*(3) - 3) + 3*(3)^2 - 6*(3) + 2) - ((
      3) - 2)*((3) - 1)*(3));

  annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;delta*delta*delta*(dddalpha_r/(ddelta*ddelta*ddelta))_tau=const.</p>
</html>"));
  end ddd_fRes_ddd;

  redeclare function extends tdd_fRes_tdd
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
  algorithm
    tdd_fRes_tdd :=(0.1046634e1)*(1)*((1) - 1)*(0.25)*delta^(1)*tau^(0.25) + (-0.5451165)
      *(2)*((2) - 1)*(1)*delta^(2)*tau^(1) + (-0.2448595e-2)*(5)*((5) - 1)*(-0.25)
      *delta^(5)*tau^(-0.25) + (-0.4877002e-1)*(1)*((1) - 1)*(-1)*delta^(1)*tau^
      (-1) + (0.3520158e-1)*(1)*((1) - 1)*(2)*delta^(1)*tau^(2) + (0.1622750e-2)
      *(3)*((3) - 1)*(2)*delta^(3)*tau^(2) + (0.2377225e-4)*(8)*((8) - 1)*(0.75)
      *delta^(8)*tau^(0.75) + (0.29149e-1)*(4)*((4) - 1)*(0.25)*delta^(4)*tau^(0.25)
       + (0.3386203e-2)*(18)*delta^(4)*tau^(18)*exp(-delta^(4))*((4)*delta^(4)*(
      (4)*(delta^(4) - 1) - 2*(4) + 1) + (4)*((4) - 1)) + (-0.4202444e-2)*(26)*
      delta^(4)*tau^(26)*exp(-delta^(3))*((3)*delta^(3)*((3)*(delta^(3) - 1) - 2
      *(4) + 1) + (4)*((4) - 1)) + (0.4782025e-3)*(-1)*delta^(8)*tau^(-1)*exp(-
      delta^(1))*((1)*delta^(1)*((1)*(delta^(1) - 1) - 2*(8) + 1) + (8)*((8) - 1))
       + (-0.5504323e-2)*(25)*delta^(3)*tau^(25)*exp(-delta^(4))*((4)*delta^(4)*
      ((4)*(delta^(4) - 1) - 2*(3) + 1) + (3)*((3) - 1)) + (-0.2418396e-1)*(1.75)
      *delta^(5)*tau^(1.75)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1) - 1) -
      2*(5) + 1) + (5)*((5) - 1)) + (0.4209034)*(4)*delta^(1)*tau^(4)*exp(-
      delta^(2))*((2)*delta^(2)*((2)*(delta^(2) - 1) - 2*(1) + 1) + (1)*((1) - 1))
       + (-0.4616537)*(5)*delta^(1)*tau^(5)*exp(-delta^(2))*((2)*delta^(2)*((2)*
      (delta^(2) - 1) - 2*(1) + 1) + (1)*((1) - 1)) + (-0.1200513e1)*(1)*delta^(
      3)*tau^(1)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1) - 1) - 2*(3) + 1)
       + (3)*((3) - 1)) + (-0.2591550e1)*(1.5)*delta^(1)*tau^(1.5)*exp(-delta^(1))
      *((1)*delta^(1)*((1)*(delta^(1) - 1) - 2*(1) + 1) + (1)*((1) - 1)) + (-0.1400145e1)
      *(1)*delta^(2)*tau^(1)*exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1) - 1)
       - 2*(2) + 1) + (2)*((2) - 1)) + (0.8263017)*(0.5)*delta^(3)*tau^(0.5)*
      exp(-delta^(1))*((1)*delta^(1)*((1)*(delta^(1) - 1) - 2*(3) + 1) + (3)*((3)
       - 1));

  annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta)).</p>
</html>"));
  end tdd_fRes_tdd;

  redeclare function extends ttd_fRes_ttd
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
  algorithm
    ttd_fRes_ttd :=(0.1046634e1)*(1)*(0.25)*((0.25) - 1)*delta^(1)*tau^(0.25) +
      (-0.5451165)*(2)*(1)*((1) - 1)*delta^(2)*tau^(1) + (-0.2448595e-2)*(5)*(-0.25)
      *((-0.25) - 1)*delta^(5)*tau^(-0.25) + (-0.4877002e-1)*(1)*(-1)*((-1) - 1)
      *delta^(1)*tau^(-1) + (0.3520158e-1)*(1)*(2)*((2) - 1)*delta^(1)*tau^(2) +
      (0.1622750e-2)*(3)*(2)*((2) - 1)*delta^(3)*tau^(2) + (0.2377225e-4)*(8)*(0.75)
      *((0.75) - 1)*delta^(8)*tau^(0.75) + (0.29149e-1)*(4)*(0.25)*((0.25) - 1)*
      delta^(4)*tau^(0.25) + (0.3386203e-2)*(18)*((18) - 1)*delta^(4)*tau^(18)*
      exp(-delta^(4))*((4) - (4)*delta^(4)) + (-0.4202444e-2)*(26)*((26) - 1)*
      delta^(4)*tau^(26)*exp(-delta^(3))*((4) - (3)*delta^(3)) + (0.4782025e-3)*
      (-1)*((-1) - 1)*delta^(8)*tau^(-1)*exp(-delta^(1))*((8) - (1)*delta^(1)) +
      (-0.5504323e-2)*(25)*((25) - 1)*delta^(3)*tau^(25)*exp(-delta^(4))*((3) -
      (4)*delta^(4)) + (-0.2418396e-1)*(1.75)*((1.75) - 1)*delta^(5)*tau^(1.75)*
      exp(-delta^(1))*((5) - (1)*delta^(1)) + (0.4209034)*(4)*((4) - 1)*delta^(1)
      *tau^(4)*exp(-delta^(2))*((1) - (2)*delta^(2)) + (-0.4616537)*(5)*((5) - 1)
      *delta^(1)*tau^(5)*exp(-delta^(2))*((1) - (2)*delta^(2)) + (-0.1200513e1)*
      (1)*((1) - 1)*delta^(3)*tau^(1)*exp(-delta^(1))*((3) - (1)*delta^(1)) + (-0.2591550e1)
      *(1.5)*((1.5) - 1)*delta^(1)*tau^(1.5)*exp(-delta^(1))*((1) - (1)*delta^(1))
       + (-0.1400145e1)*(1)*((1) - 1)*delta^(2)*tau^(1)*exp(-delta^(1))*((2) - (
      1)*delta^(1)) + (0.8263017)*(0.5)*((0.5) - 1)*delta^(3)*tau^(0.5)*exp(-
      delta^(1))*((3) - (1)*delta^(1));

  annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta)).</p>
</html>"));
  end ttd_fRes_ttd;

redeclare function extends saturationPressure
    "Saturation pressure of refrigerant (Ancillary equation)"
protected
  Real OM = abs( 1 - T / 351.255);
algorithm
  if T > 351.255 then
    p :=5782000;
  elseif T <= 136.34 then
    p :=47.9998938761;
  else
  p :=5782000*exp((351.255 ./ T)*((-6.62005192706158)*(OM)^(0.976531979603037) +
      (50.1351471230756)*(OM)^(21.6413475671488) + (3.59711504443902)*(OM) .^ (2.92370325930597)
       + (-6.72585880421962)*(OM) .^ (3.33228295367417)));
  end if;
  annotation (Documentation(info="<html>
<p>Saturation&nbsp;pressure&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end saturationPressure;

redeclare function extends saturationTemperature
    "Saturation temperature of refrigerant (Ancillary equation)"
protected
  Real x;
algorithm
  if p >=  5782000 then
    T:= 351.255;
  elseif p <= 47.9998938761 then
    T :=136.34;
  else
    x :=(p - 1938804.15231595) ./ 1581895.17243546;
    T :=292.200000000000 + 34.1358316143023*((0.327459045115257) + (0.922776821506759)
        *x^1 + (-0.275423633069918)*x^2 + (0.150391722326916) .* x .^ 3 + (-0.16416305093748)
         .* x .^ 4 + (-0.00149298905254786) .* x .^ 5 + (0.279442608443674) .*
        x .^ 6 + (-0.00716518966743047) .* x .^ 7 + (-0.492549686732791) .* x .^
        8 + (0.266046790162186) .* x .^ 9 + (0.278799027038136) .* x .^ 10 + (-0.296997349084035)
         .* x .^ 11 + (0.00969774886360458) .* x .^ 12 + (0.102037725357403) .*
        x .^ 13 + (-0.0564414851955293) .* x .^ 14 + (0.0127805040483111) .* x .^
        15 + (-0.00109929810329907) .* x .^ 16);
  end if;
  annotation (Documentation(info="<html>
<p>Saturation&nbsp;temperature&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end saturationTemperature;

redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x :=abs(1 - sat.Tsat ./ 351.255000000000);
    dl :=(411.962562962815 + (1384.78285007049) .* x .^ (1/3) + (-6760.0739603806)
       .* x .^ (2/3) + (44102.8003585004) .* x .^ (3/3) + (-168140.200851554) .*
      x .^ (4/3) + (357896.067181242) .* x .^ (5/3) + (-0.358702151133198) .* x .^
      (6/3) + (-2286456.44300943) .* x .^ (7/3) + (5781503.45886353) .* x .^ (8/
      3) + (-5166174.50914314) .* x .^ (9/3) + (-2.90996532913309) .* x .^ (10/3)
       + (-0.263780931113244) .* x .^ (11/3) + (-0.0927901276903118) .* x .^ (12
      /3) + (15124429.3663181) .* x .^ (13/3) + (-21274147.5306485) .* x .^ (14/
      3) + (44.127617637309) .* x .^ (15/3) + (9179436.25242932) .* x .^ (16/3) +
      (-155.48933646041) .* x .^ (17/3) + (-15.8988669115308) .* x .^ (18/3) + (
      66.2473995740726) .* x .^ (19/3) + (18433.4627359412) .* x .^ (20/3) + (61.7434457837568)
       .* x .^ (21/3) + (-42.5986175871026) .* x .^ (22/3) + (-6807234.82245561)
       .* x .^ (23/3) + (274.111927609293) .* x .^ (24/3) + (5819565.58190494) .*
      x .^ (25/3));
  annotation (Documentation(info="<html>
<p>Boiling&nbsp;curve&nbsp;specific&nbsp;density&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end bubbleDensity;

redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x :=abs(1 - sat.Tsat ./ 351.255000000000);
    dv :=(432.931450640753 + (-1148.22274549625) .* x .^ (1/3) + (3369.26539192252)
       .* x .^ (2/3) + (-15344.7158555551) .* x .^ (3/3) + (28147.128389359) .*
      x .^ (4/3) + (48407.0244209983) .* x .^ (5/3) + (-365829.600768666) .* x .^
      (6/3) + (789141.468792601) .* x .^ (7/3) + (-669604.232075241) .* x .^ (8/
      3) + (-9473.36652139824) .* x .^ (9/3) + (1850.82014401313) .* x .^ (10/3)
       + (852.988845245304) .* x .^ (11/3) + (1807313.94291306) .* x .^ (12/3) +
      (-46926.6735495554) .* x .^ (13/3) + (-9168549.44740099) .* x .^ (14/3) +
      (11793584.320436) .* x .^ (15/3) + (-5138.31460023942) .* x .^ (16/3) + (-7881326.22939967)
       .* x .^ (17/3) + (3710109.42804164) .* x .^ (18/3));
  annotation (Documentation(info="<html>
<p>Dew&nbsp;curve&nbsp;specific&nbsp;density&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end dewDensity;

redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
   x :=(sat.psat - 1938804.15231595)/1581895.17243546;
   hl :=240738.576125232 + 68596.8856178573*((0.222997859484596) + (0.845088990204788)
       .* x .^ 1 + (-0.343897993915733) .* x .^ 2 + (0.761876423135673) .* x .^
      3 + (0.761189814877636) .* x .^ 4 + (-2.32076767470077) .* x .^ 5 + (-1.52154256929935)
       .* x .^ 6 + (4.5823205058795) .* x .^ 7 + (0.313506177654019) .* x .^ 8 +
      (-5.19115810992342) .* x .^ 9 + (2.59469984534983) .* x .^ 10 + (2.47551850434143)
       .* x .^ 11 + (-3.60812518653287) .* x .^ 12 + (1.25102387066161) .* x .^
      13 + (1.16266198467432) .* x .^ 14 + (-1.69888284974517) .* x .^ 15 + (0.734304335486623)
       .* x .^ 16 + (0.201224850775744) .* x .^ 17 + (-0.3715836943175) .* x .^
      18 + (0.173733007655683) .* x .^ 19 + (-0.0374800256688542) .* x .^ 20 + (
      0.00319190437965757) .* x .^ 21);

  annotation (Documentation(info="<html>
<p>Boiling&nbsp;curve&nbsp;specific&nbsp;enthalpy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end bubbleEnthalpy;

redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x:=abs(1 - sat.psat/5782000);
    hv :=(418393.343429157 + (31799.4583565502) .* x .^ (1/3) + (354311.0974812)
       .* x .^ (2/3) + (1973424.29668483) .* x .^ (3/3) + (-20239402.539683) .*
      x .^ (4/3) + (57732115.6562816) .* x .^ (5/3) + (-37332501.9285758) .* x .^
      (6/3) + (-105708842.809586) .* x .^ (7/3) + (162836997.216592) .* x .^ (8/
      3) + (-5168128.68420523) .* x .^ (9/3) + (13245.3186759914) .* x .^ (10/3)
       + (-63414118.1615444) .* x .^ (11/3) + (-171558851.039713) .* x .^ (12/3)
       + (24499196.5522272) .* x .^ (13/3) + (386389605.494335) .* x .^ (14/3) +
      (-7787697.09755961) .* x .^ (15/3) + (-280692681.188642) .* x .^ (16/3) +
      (-219786.010689) .* x .^ (17/3) + (-235009676.330252) .* x .^ (18/3) + (505336424.863152)
       .* x .^ (19/3) + (-211961671.460199) .* x .^ (20/3));
  annotation (Documentation(info="<html>
<p>Dew&nbsp;curve&nbsp;specific&nbsp;enthalpy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end dewEnthalpy;

redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
protected
  Real x;
algorithm
  x:=abs(1 - sat.psat/5782000);
  sl :=(1636.4630367045 + (-1294.84332809831) .* x .^ (1/3) + (23777.3354338167)
       .* x .^ (2/3) + (-202543.336705091) .* x .^ (3/3) + (849148.242017776) .*
      x .^ (4/3) + (-1812485.89364926) .* x .^ (5/3) + (1639420.05006415) .* x .^
      (6/3) + (-4563.4799711349) .* x .^ (7/3) + (-2705.13987917771) .* x .^ (8/
      3) + (-1321904.12776392) .* x .^ (9/3) + (-151.250039226242) .* x .^ (10/3)
       + (-907.063159632968) .* x .^ (11/3) + (2099817.95272042) .* x .^ (12/3) +
      (38.2676974744578) .* x .^ (13/3) + (0.658130860397869) .* x .^ (14/3) + (
      281.066919137234) .* x .^ (15/3) + (-4401878.48157025) .* x .^ (16/3) + (-25.6075359583628)
       .* x .^ (17/3) + (6.18386158064518) .* x .^ (18/3) + (6546730.27884439) .*
      x .^ (19/3) + (497.720846830071) .* x .^ (20/3) + (-1843.34325717218) .*
      x .^ (21/3) + (-301.119491264441) .* x .^ (22/3) + (-10587659.6388708) .*
      x .^ (23/3) + (33896.6730904787) .* x .^ (24/3) + (13823952.9342766) .* x .^
      (25/3) + (-6680374.61584268) .* x .^ (26/3));
  annotation (Documentation(info="<html>
<p>Boiling&nbsp;curve&nbsp;specific&nbsp;entropy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end bubbleEntropy;

redeclare function extends dewEntropy
    "Dew curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x:=abs(1 - sat.psat/5782000);
    sv:=(1660.66603083701 + (725.383375016823) .* x .^ (1/3) + (-9902.46906626874)
       .* x .^ (2/3) + (70043.7467482867) .* x .^ (3/3) + (-182597.093033482) .*
      x .^ (4/3) + (3429.56754755341) .* x .^ (5/3) + (636026.353090208) .* x .^
      (6/3) + (2267.99266372299) .* x .^ (7/3) + (-2263389.43873785) .* x .^ (8/
      3) + (56412.8536991717) .* x .^ (9/3) + (5175561.32511078) .* x .^ (10/3) +
      (590.750570647852) .* x .^ (11/3) + (-6576041.25409667) .* x .^ (12/3) + (
      -10070.4453359871) .* x .^ (13/3) + (-315432.688109757) .* x .^ (14/3) + (
      6215979.42272179) .* x .^ (15/3) + (-794.873607720523) .* x .^ (16/3) + (2884.10347401278)
       .* x .^ (17/3) + (-539.405318237474) .* x .^ (18/3) + (-6200190.12840533)
       .* x .^ (19/3) + (-30.8402198388381) .* x .^ (20/3) + (-83717.1447065565)
       .* x .^ (21/3) + (102641.409426111) .* x .^ (22/3) + (10267845.6662009) .*
      x .^ (23/3) + (552167.363343208) .* x .^ (24/3) + (-14148633.764138) .* x .^
      (25/3) + (6705545.72219792) .* x .^ (26/3));

  annotation (Documentation(info="<html>
<p>Dew&nbsp;curve&nbsp;specific&nbsp;entropy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
end dewEntropy;

redeclare replaceable function temperature_ph
    "Calculates temperature as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

protected
    SmoothTransition st;
    SpecificEnthalpy dh = st.T_ph;
    SpecificEnthalpy h_dew;
    SpecificEnthalpy h_bubble;
    Real x1;
    Real y1;
    Real T1;
    Real x2;
    Real y2;
    Real T2;
    Real x3;
    Real y3;
    Real x_scr;
    Real h_scr;

algorithm
  h_dew := dewEnthalpy(sat = setSat_p(p=p));
  h_bubble := bubbleEnthalpy(sat = setSat_p(p=p));
  x_scr :=(p - 6391500)/351750.621889998;
  h_scr :=371988.330733655 + 6984.44607721997*((0.0634229063052632)*x_scr^8 + (-0.0451798539245242)
    *x_scr^7 + (-0.294252152800906)*x_scr^6 + (0.159861373512126)*x_scr^5 + (0.458768923099466)
    *x_scr^4 + (-0.2375233025356)*x_scr^3 + (-0.0497636499255021)*x_scr^2 + (-0.677844265655808)
    *x_scr + (-0.229994717739535));
  if p < 5782000 then //SC, SH, SC+smooth or SH + smooth
    if h < h_bubble-dh then // SC
      x1 :=(p - 4163881.04147178)/2100662.93119210;
      y1 :=(h - 175109.116775803)/101891.115382834;
      T :=252.830388036008 + 54.8299865801538*(0.0958885070679776 + (-0.00633093128403416)
         .* x1 .^ 1 + (0.00104848762197526) .* x1 .^ 2 + (0.000168972004106638) .*
        x1 .^ 3 + (-0.000653818997873475) .* x1 .^ 4 + (1.12462205869269) .* y1 .^
        1 + (-0.0703367890276886) .* y1 .^ 2 + (-0.0291464191596956) .* y1 .^ 3 +
        (0.0293958097416133) .* y1 .^ 4 + (0.0143364440766979) .* y1 .^ 5 + (-0.0834962691719504)
         .* y1 .^ 6 + (0.0232228598689926) .* y1 .^ 7 + (0.0615719477906913) .*
        y1 .^ 8 + (-0.0539683542971315) .* y1 .^ 9 + (0.0157032859055343) .* y1 .^
        10 + (-0.00154689508845822) .* y1 .^ 11 + (-0.00235991509892699) .* y1 .^
        10.*x1 .^ 1 + (0.0142208296456288) .* y1 .^ 9.*x1 .^ 1 + (-0.000372252706320382)
         .* y1 .^ 9.*x1 .^ 2 + (-0.0094840931078553) .* y1 .^ 8.*x1 .^ 1 + (-0.0217131244128693)
         .* y1 .^ 8.*x1 .^ 2 + (0.0104242059159345) .* y1 .^ 8.*x1 .^ 3 + (-0.0255436863903638)
         .* y1 .^ 7.*x1 .^ 1 + (0.0474268719433873) .* y1 .^ 7.*x1 .^ 2 + (-0.0146948038007286)
         .* y1 .^ 7.*x1 .^ 3 + (-0.00708746127229437) .* y1 .^ 7.*x1 .^ 4 + (0.0225711503704109)
         .* y1 .^ 6.*x1 .^ 1 + (-0.0080064822257849) .* y1 .^ 6.*x1 .^ 2 + (-0.00885000189085101)
         .* y1 .^ 6.*x1 .^ 3 + (0.0126502296953382) .* y1 .^ 6.*x1 .^ 4 + (0.0183722363204466)
         .* y1 .^ 5.*x1 .^ 1 + (-0.0452961667659217) .* y1 .^ 5.*x1 .^ 2 + (0.0165053524885114)
         .* y1 .^ 5.*x1 .^ 3 + (0.00401334007497051) .* y1 .^ 5.*x1 .^ 4 + (-0.0120637284547406)
         .* y1 .^ 4.*x1 .^ 1 + (0.0211339607592543) .* y1 .^ 4.*x1 .^ 2 + (0.00470654096409558)
         .* y1 .^ 4.*x1 .^ 3 + (-0.0145810128528001) .* y1 .^ 4.*x1 .^ 4 + (-0.00291387475700408)
         .* y1 .^ 3.*x1 .^ 1 + (0.00978201394282366) .* y1 .^ 3.*x1 .^ 2 + (-0.0028724030922525)
         .* y1 .^ 3.*x1 .^ 3 + (-0.000917898885511441) .* y1 .^ 3.*x1 .^ 4 + (0.00786795363760787)
         .* y1 .^ 2.*x1 .^ 1 + (-0.00710995338637064) .* y1 .^ 2.*x1 .^ 2 + (0.000361473046183604)
         .* y1 .^ 2.*x1 .^ 3 + (0.0035202349864218) .* y1 .^ 2.*x1 .^ 4 + (0.00988071676562147)
         .* y1 .^ 1.*x1 .^ 1 + (0.000941735805708528) .* y1 .^ 1.*x1 .^ 2 + (0.000729883472584559)
         .* y1 .^ 1.*x1 .^ 3 + (-0.000928147737902215) .* y1 .^ 1.*x1 .^ 4);
    elseif h > h_dew+dh then // SH
      x2 :=(p - 1764642.92161993)/1736460.62051945;
      y2 :=(h - 543645.484310216)/35391.1331971211;
      T :=318.474103217216 + 35.5202971540045*(0.0129848609601194 + (0.940865504550395)
         .* x2 .^ 1 + (-0.173828458947708) .* x2 .^ 2 + (0.0503479320667924) .*
        x2 .^ 3 + (-0.0179703822452013) .* x2 .^ 4 + (0.0196290346574423) .* x2 .^
        5 + (-0.0161840589182154) .* x2 .^ 6 + (-0.00965810267975084) .* x2 .^ 7
         + (0.014209119503814) .* x2 .^ 8 + (0.00226262258905167) .* x2 .^ 9 + (
        -0.00751719995380472) .* x2 .^ 10 + (0.0030531285404761) .* x2 .^ 11 + (
        -0.000388072218724421) .* x2 .^ 12 + (0.770727779932162) .* y2 .^ 1 + (0.0779008683340961)
         .* y2 .^ 2 + (-0.0160059964913689) .* y2 .^ 3 + (-0.000812354244774785)
         .* y2 .^ 4 + (0.00212924927090175) .* y2 .^ 5 + (-0.00623609360049041) .*
        y2 .^ 6 + (-0.0149774478710768) .* y2 .^ 7 + (0.0274151646455438) .* y2 .^
        8 + (-0.00848314486312912) .* y2 .^ 9 + (-0.00271090222707368) .* y2 .^
        10 + (0.000617375673032098) .* y2 .^ 11 + (0.000281911927794692) .* y2 .^
        12 + (-0.000989137109861996) .* x2 .^ 11.*y2 .^ 1 + (0.00874509069546637)
         .* x2 .^ 10.*y2 .^ 1 + (0.000362524095201298) .* x2 .^ 10.*y2 .^ 2 + (-0.0194843912677881)
         .* x2 .^ 9.*y2 .^ 1 + (0.0147057429695676) .* x2 .^ 9.*y2 .^ 2 + (0.00896562206284843)
         .* x2 .^ 9.*y2 .^ 3 + (-0.00573590221962906) .* x2 .^ 8.*y2 .^ 1 + (-0.0502435317381367)
         .* x2 .^ 8.*y2 .^ 2 + (0.0155037472656779) .* x2 .^ 8.*y2 .^ 3 + (0.0330885893687832)
         .* x2 .^ 8.*y2 .^ 4 + (0.044366169946773) .* x2 .^ 7.*y2 .^ 1 + (-0.000979978835834077)
         .* x2 .^ 7.*y2 .^ 2 + (-0.104911697060988) .* x2 .^ 7.*y2 .^ 3 + (-0.00541694353924372)
         .* x2 .^ 7.*y2 .^ 4 + (0.0675956544445773) .* x2 .^ 7.*y2 .^ 5 + (0.0114840844648551)
         .* x2 .^ 6.*y2 .^ 1 + (0.0868503293241689) .* x2 .^ 6.*y2 .^ 2 + (-0.0145254744421747)
         .* x2 .^ 6.*y2 .^ 3 + (-0.151781658824362) .* x2 .^ 6.*y2 .^ 4 + (-0.0226084238528098)
         .* x2 .^ 6.*y2 .^ 5 + (0.090222599076252) .* x2 .^ 6.*y2 .^ 6 + (-0.0700194234977953)
         .* x2 .^ 5.*y2 .^ 1 + (0.0424212728773851) .* x2 .^ 5.*y2 .^ 2 + (0.183908399378481)
         .* x2 .^ 5.*y2 .^ 3 + (-0.0633422337969635) .* x2 .^ 5.*y2 .^ 4 + (-0.206357485973864)
         .* x2 .^ 5.*y2 .^ 5 + (0.00102024071228879) .* x2 .^ 5.*y2 .^ 6 + (0.0849548885230134)
         .* x2 .^ 5.*y2 .^ 7 + (0.0208654406156769) .* x2 .^ 4.*y2 .^ 1 + (-0.109656282197344)
         .* x2 .^ 4.*y2 .^ 2 + (0.0761530113430497) .* x2 .^ 4.*y2 .^ 3 + (0.262320340562736)
         .* x2 .^ 4.*y2 .^ 4 + (-0.0736782769785973) .* x2 .^ 4.*y2 .^ 5 + (-0.254334362690228)
         .* x2 .^ 4.*y2 .^ 6 + (0.0374309138830408) .* x2 .^ 4.*y2 .^ 7 + (0.0594944830030146)
         .* x2 .^ 4.*y2 .^ 8 + (-0.0264466457212602) .* x2 .^ 3.*y2 .^ 1 + (-0.02490683802519)
         .* x2 .^ 3.*y2 .^ 2 + (-0.132520398951539) .* x2 .^ 3.*y2 .^ 3 + (0.111719121209108)
         .* x2 .^ 3.*y2 .^ 4 + (0.233338493565879) .* x2 .^ 3.*y2 .^ 5 + (-0.041403936331184)
         .* x2 .^ 3.*y2 .^ 6 + (-0.210578459919899) .* x2 .^ 3.*y2 .^ 7 + (0.0388237806334477)
         .* x2 .^ 3.*y2 .^ 8 + (0.0313930372892791) .* x2 .^ 3.*y2 .^ 9 + (0.11095995275792)
         .* x2 .^ 2.*y2 .^ 1 + (0.00882089528763659) .* x2 .^ 2.*y2 .^ 2 + (-0.0643388129645329)
         .* x2 .^ 2.*y2 .^ 3 + (-0.120972882449039) .* x2 .^ 2.*y2 .^ 4 + (0.0954986708882967)
         .* x2 .^ 2.*y2 .^ 5 + (0.157792765147705) .* x2 .^ 2.*y2 .^ 6 + (-0.0393742702888927)
         .* x2 .^ 2.*y2 .^ 7 + (-0.0972139612286595) .* x2 .^ 2.*y2 .^ 8 + (0.0181246589940355)
         .* x2 .^ 2.*y2 .^ 9 + (0.0116625139904804) .* x2 .^ 2.*y2 .^ 10 + (-0.250337456105934)
         .* x2 .^ 1.*y2 .^ 1 + (0.0295432207450077) .* x2 .^ 1.*y2 .^ 2 + (0.0326301574811819)
         .* x2 .^ 1.*y2 .^ 3 + (-0.029541060712142) .* x2 .^ 1.*y2 .^ 4 + (-0.0676217624808071)
         .* x2 .^ 1.*y2 .^ 5 + (0.0153747598544824) .* x2 .^ 1.*y2 .^ 6 + (0.0950821380302293)
         .* x2 .^ 1.*y2 .^ 7 + (-0.0333849395083102) .* x2 .^ 1.*y2 .^ 8 + (-0.0232593278434449)
         .* x2 .^ 1.*y2 .^ 9 + (0.00468616367793845) .* x2 .^ 1.*y2 .^ 10 + (0.0026509381754971)
         .* x2 .^ 1.*y2 .^ 11);
    elseif h < h_bubble then //SC + smooth
      x1 :=(p - 4163881.04147178)/2100662.93119210;
      y1 :=(h - 175109.116775803)/101891.115382834;
      T1 :=252.830388036008 + 54.8299865801538*(0.0958885070679776 + (-0.00633093128403416)
         .* x1 .^ 1 + (0.00104848762197526) .* x1 .^ 2 + (0.000168972004106638) .*
        x1 .^ 3 + (-0.000653818997873475) .* x1 .^ 4 + (1.12462205869269) .* y1 .^
        1 + (-0.0703367890276886) .* y1 .^ 2 + (-0.0291464191596956) .* y1 .^ 3 +
        (0.0293958097416133) .* y1 .^ 4 + (0.0143364440766979) .* y1 .^ 5 + (-0.0834962691719504)
         .* y1 .^ 6 + (0.0232228598689926) .* y1 .^ 7 + (0.0615719477906913) .*
        y1 .^ 8 + (-0.0539683542971315) .* y1 .^ 9 + (0.0157032859055343) .* y1 .^
        10 + (-0.00154689508845822) .* y1 .^ 11 + (-0.00235991509892699) .* y1 .^
        10.*x1 .^ 1 + (0.0142208296456288) .* y1 .^ 9.*x1 .^ 1 + (-0.000372252706320382)
         .* y1 .^ 9.*x1 .^ 2 + (-0.0094840931078553) .* y1 .^ 8.*x1 .^ 1 + (-0.0217131244128693)
         .* y1 .^ 8.*x1 .^ 2 + (0.0104242059159345) .* y1 .^ 8.*x1 .^ 3 + (-0.0255436863903638)
         .* y1 .^ 7.*x1 .^ 1 + (0.0474268719433873) .* y1 .^ 7.*x1 .^ 2 + (-0.0146948038007286)
         .* y1 .^ 7.*x1 .^ 3 + (-0.00708746127229437) .* y1 .^ 7.*x1 .^ 4 + (0.0225711503704109)
         .* y1 .^ 6.*x1 .^ 1 + (-0.0080064822257849) .* y1 .^ 6.*x1 .^ 2 + (-0.00885000189085101)
         .* y1 .^ 6.*x1 .^ 3 + (0.0126502296953382) .* y1 .^ 6.*x1 .^ 4 + (0.0183722363204466)
         .* y1 .^ 5.*x1 .^ 1 + (-0.0452961667659217) .* y1 .^ 5.*x1 .^ 2 + (0.0165053524885114)
         .* y1 .^ 5.*x1 .^ 3 + (0.00401334007497051) .* y1 .^ 5.*x1 .^ 4 + (-0.0120637284547406)
         .* y1 .^ 4.*x1 .^ 1 + (0.0211339607592543) .* y1 .^ 4.*x1 .^ 2 + (0.00470654096409558)
         .* y1 .^ 4.*x1 .^ 3 + (-0.0145810128528001) .* y1 .^ 4.*x1 .^ 4 + (-0.00291387475700408)
         .* y1 .^ 3.*x1 .^ 1 + (0.00978201394282366) .* y1 .^ 3.*x1 .^ 2 + (-0.0028724030922525)
         .* y1 .^ 3.*x1 .^ 3 + (-0.000917898885511441) .* y1 .^ 3.*x1 .^ 4 + (0.00786795363760787)
         .* y1 .^ 2.*x1 .^ 1 + (-0.00710995338637064) .* y1 .^ 2.*x1 .^ 2 + (0.000361473046183604)
         .* y1 .^ 2.*x1 .^ 3 + (0.0035202349864218) .* y1 .^ 2.*x1 .^ 4 + (0.00988071676562147)
         .* y1 .^ 1.*x1 .^ 1 + (0.000941735805708528) .* y1 .^ 1.*x1 .^ 2 + (0.000729883472584559)
         .* y1 .^ 1.*x1 .^ 3 + (-0.000928147737902215) .* y1 .^ 1.*x1 .^ 4);
      T :=saturationTemperature(p)*(1 - (h_bubble - h)/dh) + T1*(h_bubble - h)/
        dh;
    elseif h > h_dew then //SH + smooth
      x2 :=(p - 1764642.92161993)/1736460.62051945;
      y2 :=(h - 543645.484310216)/35391.1331971211;
      T2 :=318.474103217216 + 35.5202971540045*(0.0129848609601194 + (0.940865504550395)
         .* x2 .^ 1 + (-0.173828458947708) .* x2 .^ 2 + (0.0503479320667924) .*
        x2 .^ 3 + (-0.0179703822452013) .* x2 .^ 4 + (0.0196290346574423) .* x2 .^
        5 + (-0.0161840589182154) .* x2 .^ 6 + (-0.00965810267975084) .* x2 .^ 7
         + (0.014209119503814) .* x2 .^ 8 + (0.00226262258905167) .* x2 .^ 9 + (
        -0.00751719995380472) .* x2 .^ 10 + (0.0030531285404761) .* x2 .^ 11 + (
        -0.000388072218724421) .* x2 .^ 12 + (0.770727779932162) .* y2 .^ 1 + (0.0779008683340961)
         .* y2 .^ 2 + (-0.0160059964913689) .* y2 .^ 3 + (-0.000812354244774785)
         .* y2 .^ 4 + (0.00212924927090175) .* y2 .^ 5 + (-0.00623609360049041) .*
        y2 .^ 6 + (-0.0149774478710768) .* y2 .^ 7 + (0.0274151646455438) .* y2 .^
        8 + (-0.00848314486312912) .* y2 .^ 9 + (-0.00271090222707368) .* y2 .^
        10 + (0.000617375673032098) .* y2 .^ 11 + (0.000281911927794692) .* y2 .^
        12 + (-0.000989137109861996) .* x2 .^ 11.*y2 .^ 1 + (0.00874509069546637)
         .* x2 .^ 10.*y2 .^ 1 + (0.000362524095201298) .* x2 .^ 10.*y2 .^ 2 + (-0.0194843912677881)
         .* x2 .^ 9.*y2 .^ 1 + (0.0147057429695676) .* x2 .^ 9.*y2 .^ 2 + (0.00896562206284843)
         .* x2 .^ 9.*y2 .^ 3 + (-0.00573590221962906) .* x2 .^ 8.*y2 .^ 1 + (-0.0502435317381367)
         .* x2 .^ 8.*y2 .^ 2 + (0.0155037472656779) .* x2 .^ 8.*y2 .^ 3 + (0.0330885893687832)
         .* x2 .^ 8.*y2 .^ 4 + (0.044366169946773) .* x2 .^ 7.*y2 .^ 1 + (-0.000979978835834077)
         .* x2 .^ 7.*y2 .^ 2 + (-0.104911697060988) .* x2 .^ 7.*y2 .^ 3 + (-0.00541694353924372)
         .* x2 .^ 7.*y2 .^ 4 + (0.0675956544445773) .* x2 .^ 7.*y2 .^ 5 + (0.0114840844648551)
         .* x2 .^ 6.*y2 .^ 1 + (0.0868503293241689) .* x2 .^ 6.*y2 .^ 2 + (-0.0145254744421747)
         .* x2 .^ 6.*y2 .^ 3 + (-0.151781658824362) .* x2 .^ 6.*y2 .^ 4 + (-0.0226084238528098)
         .* x2 .^ 6.*y2 .^ 5 + (0.090222599076252) .* x2 .^ 6.*y2 .^ 6 + (-0.0700194234977953)
         .* x2 .^ 5.*y2 .^ 1 + (0.0424212728773851) .* x2 .^ 5.*y2 .^ 2 + (0.183908399378481)
         .* x2 .^ 5.*y2 .^ 3 + (-0.0633422337969635) .* x2 .^ 5.*y2 .^ 4 + (-0.206357485973864)
         .* x2 .^ 5.*y2 .^ 5 + (0.00102024071228879) .* x2 .^ 5.*y2 .^ 6 + (0.0849548885230134)
         .* x2 .^ 5.*y2 .^ 7 + (0.0208654406156769) .* x2 .^ 4.*y2 .^ 1 + (-0.109656282197344)
         .* x2 .^ 4.*y2 .^ 2 + (0.0761530113430497) .* x2 .^ 4.*y2 .^ 3 + (0.262320340562736)
         .* x2 .^ 4.*y2 .^ 4 + (-0.0736782769785973) .* x2 .^ 4.*y2 .^ 5 + (-0.254334362690228)
         .* x2 .^ 4.*y2 .^ 6 + (0.0374309138830408) .* x2 .^ 4.*y2 .^ 7 + (0.0594944830030146)
         .* x2 .^ 4.*y2 .^ 8 + (-0.0264466457212602) .* x2 .^ 3.*y2 .^ 1 + (-0.02490683802519)
         .* x2 .^ 3.*y2 .^ 2 + (-0.132520398951539) .* x2 .^ 3.*y2 .^ 3 + (0.111719121209108)
         .* x2 .^ 3.*y2 .^ 4 + (0.233338493565879) .* x2 .^ 3.*y2 .^ 5 + (-0.041403936331184)
         .* x2 .^ 3.*y2 .^ 6 + (-0.210578459919899) .* x2 .^ 3.*y2 .^ 7 + (0.0388237806334477)
         .* x2 .^ 3.*y2 .^ 8 + (0.0313930372892791) .* x2 .^ 3.*y2 .^ 9 + (0.11095995275792)
         .* x2 .^ 2.*y2 .^ 1 + (0.00882089528763659) .* x2 .^ 2.*y2 .^ 2 + (-0.0643388129645329)
         .* x2 .^ 2.*y2 .^ 3 + (-0.120972882449039) .* x2 .^ 2.*y2 .^ 4 + (0.0954986708882967)
         .* x2 .^ 2.*y2 .^ 5 + (0.157792765147705) .* x2 .^ 2.*y2 .^ 6 + (-0.0393742702888927)
         .* x2 .^ 2.*y2 .^ 7 + (-0.0972139612286595) .* x2 .^ 2.*y2 .^ 8 + (0.0181246589940355)
         .* x2 .^ 2.*y2 .^ 9 + (0.0116625139904804) .* x2 .^ 2.*y2 .^ 10 + (-0.250337456105934)
         .* x2 .^ 1.*y2 .^ 1 + (0.0295432207450077) .* x2 .^ 1.*y2 .^ 2 + (0.0326301574811819)
         .* x2 .^ 1.*y2 .^ 3 + (-0.029541060712142) .* x2 .^ 1.*y2 .^ 4 + (-0.0676217624808071)
         .* x2 .^ 1.*y2 .^ 5 + (0.0153747598544824) .* x2 .^ 1.*y2 .^ 6 + (0.0950821380302293)
         .* x2 .^ 1.*y2 .^ 7 + (-0.0333849395083102) .* x2 .^ 1.*y2 .^ 8 + (-0.0232593278434449)
         .* x2 .^ 1.*y2 .^ 9 + (0.00468616367793845) .* x2 .^ 1.*y2 .^ 10 + (0.0026509381754971)
         .* x2 .^ 1.*y2 .^ 11);
      T := saturationTemperature(p) * (1- (h-h_dew)/dh) + T2*(h-h_dew)/dh;
    else T := saturationTemperature(p);
    end if;
  elseif h < h_scr then //SC
      x1 :=(p - 4163881.04147178)/2100662.93119210;
      y1 :=(h - 175109.116775803)/101891.115382834;
      T :=252.830388036008 + 54.8299865801538*(0.0958885070679776 + (-0.00633093128403416)
       .* x1 .^ 1 + (0.00104848762197526) .* x1 .^ 2 + (0.000168972004106638) .*
      x1 .^ 3 + (-0.000653818997873475) .* x1 .^ 4 + (1.12462205869269) .* y1 .^
      1 + (-0.0703367890276886) .* y1 .^ 2 + (-0.0291464191596956) .* y1 .^ 3 +
      (0.0293958097416133) .* y1 .^ 4 + (0.0143364440766979) .* y1 .^ 5 + (-0.0834962691719504)
       .* y1 .^ 6 + (0.0232228598689926) .* y1 .^ 7 + (0.0615719477906913) .*
      y1 .^ 8 + (-0.0539683542971315) .* y1 .^ 9 + (0.0157032859055343) .* y1 .^
      10 + (-0.00154689508845822) .* y1 .^ 11 + (-0.00235991509892699) .* y1 .^
      10.*x1 .^ 1 + (0.0142208296456288) .* y1 .^ 9.*x1 .^ 1 + (-0.000372252706320382)
       .* y1 .^ 9.*x1 .^ 2 + (-0.0094840931078553) .* y1 .^ 8.*x1 .^ 1 + (-0.0217131244128693)
       .* y1 .^ 8.*x1 .^ 2 + (0.0104242059159345) .* y1 .^ 8.*x1 .^ 3 + (-0.0255436863903638)
       .* y1 .^ 7.*x1 .^ 1 + (0.0474268719433873) .* y1 .^ 7.*x1 .^ 2 + (-0.0146948038007286)
       .* y1 .^ 7.*x1 .^ 3 + (-0.00708746127229437) .* y1 .^ 7.*x1 .^ 4 + (0.0225711503704109)
       .* y1 .^ 6.*x1 .^ 1 + (-0.0080064822257849) .* y1 .^ 6.*x1 .^ 2 + (-0.00885000189085101)
       .* y1 .^ 6.*x1 .^ 3 + (0.0126502296953382) .* y1 .^ 6.*x1 .^ 4 + (0.0183722363204466)
       .* y1 .^ 5.*x1 .^ 1 + (-0.0452961667659217) .* y1 .^ 5.*x1 .^ 2 + (0.0165053524885114)
       .* y1 .^ 5.*x1 .^ 3 + (0.00401334007497051) .* y1 .^ 5.*x1 .^ 4 + (-0.0120637284547406)
       .* y1 .^ 4.*x1 .^ 1 + (0.0211339607592543) .* y1 .^ 4.*x1 .^ 2 + (0.00470654096409558)
       .* y1 .^ 4.*x1 .^ 3 + (-0.0145810128528001) .* y1 .^ 4.*x1 .^ 4 + (-0.00291387475700408)
       .* y1 .^ 3.*x1 .^ 1 + (0.00978201394282366) .* y1 .^ 3.*x1 .^ 2 + (-0.0028724030922525)
       .* y1 .^ 3.*x1 .^ 3 + (-0.000917898885511441) .* y1 .^ 3.*x1 .^ 4 + (0.00786795363760787)
       .* y1 .^ 2.*x1 .^ 1 + (-0.00710995338637064) .* y1 .^ 2.*x1 .^ 2 + (0.000361473046183604)
       .* y1 .^ 2.*x1 .^ 3 + (0.0035202349864218) .* y1 .^ 2.*x1 .^ 4 + (0.00988071676562147)
       .* y1 .^ 1.*x1 .^ 1 + (0.000941735805708528) .* y1 .^ 1.*x1 .^ 2 + (0.000729883472584559)
       .* y1 .^ 1.*x1 .^ 3 + (-0.000928147737902215) .* y1 .^ 1.*x1 .^ 4);
  elseif h > h_scr then //SCr
    x3 := (p - 6295894.26858962) / 419075.331114534;
    y3 := (h - 456755.221015171) / 50386.0188124643;
    T := 359.569974705729 + 6.34825875937242 *( -0.385300982343462 + (0.633446168082385).*x3.^1 + (-0.0288246850289465).*x3.^2 + (0.00183584025276029).*x3.^3 + (0.657891634516468).*y3.^1 + (0.589386679254788).*y3.^2 + (0.257767428001585).*y3.^3 + (-0.0467547247885307).*y3.^4 + (-0.00949946500082336).*y3.^5 + (0.00136614631034522).*y3.^4.*x3.^1 + (-0.000783518504328571).*y3.^3.*x3.^1 + (-0.00376845424856179).*y3.^3.*x3.^2 + (-0.0811120359411396).*y3.^2.*x3.^1 + (0.00786385518196062).*y3.^2.*x3.^2 + (-0.00162600737364173).*y3.^2.*x3.^3 + (0.136472193868355).*y3.^1.*x3.^1 + (0.00205096444474424).*y3.^1.*x3.^2 + (0.000219964974060217).*y3.^1.*x3.^3);
  end if;

  annotation (Documentation(info="<html>
<p>Calculates&nbsp;temperature&nbsp;as&nbsp;function&nbsp;of&nbsp;pressure&nbsp;and&nbsp;specific&nbsp;enthalpy.</p>
</html>"));
end temperature_ph;

  redeclare replaceable function temperature_ps
    "Calculates temperature as function of pressure and specific entropy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

protected
    SmoothTransition st;
    SpecificEntropy ds = st.T_ps;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;
    Real x1;
    Real y1;
    Real T1;
    Real x2;
    Real x3;
    Real y2;
    Real y3;
    Real T2;
    Real T3;
    Real x_scr;
    Real s_scr;

  algorithm
    s_dew := dewEntropy(sat = setSat_p(p=p));
    s_bubble := bubbleEntropy(sat = setSat_p(p=p));
    x_scr :=(p - 6391500)/351750.621889998;
    s_scr :=1525.78196325671 + 21.3672467572462*((0.0632365389121228)*x_scr^8 + (-0.0701376139475168)*x_scr^7 + (-0.273371417876765)
      *x_scr^6 + (0.242941009513175)*x_scr^5 + (0.407309923626554)*x_scr^4 + (-0.318902208160569)*x_scr^3 + (-0.0111689769656141)
      *x_scr^2 + (-0.674006919879221)*x_scr + (-0.23621826883562));

    if  p < 5782000 then //SC, SH, SC+smooth or SH+smooth
      if s < s_bubble - ds then //SC
        x1 :=(log(p) - 14.9448573563973)/0.881691674720842;
        y1 :=(s - 766.507566800662)/354.359519730800;
        T :=240.674827018988 + 52.7804347025945*(-0.0473524138478641 + (0.0162103214519941) .* x1 .^ 1 + (0.00731712571431491)
           .* x1 .^ 2 + (0.00162110867808151) .* x1 .^ 3 + (9.01357817428802e-05) .* x1 .^ 4 + (0.994698974040281)
           .* y1 .^ 1 + (0.0826799337772093) .* y1 .^ 2 + (-0.0096283413640456) .* y1 .^ 3 + (-0.0334900245004738)
           .* y1 .^ 4 + (0.00322039669586458) .* y1 .^ 5 + (0.0261381341562466) .* y1 .^ 6 + (-0.0172653610868116)
           .* y1 .^ 7 + (0.00204400577825453) .* y1 .^ 8 + (0.00586678329215318) .* y1 .^ 7.*x1 .^ 1 + (0.00405831580633545)
           .* y1 .^ 6.*x1 .^ 1 + (-0.012636519314169) .* y1 .^ 6.*x1 .^ 2 + (-0.0183127993873416) .* y1 .^ 5.
          *x1 .^ 1 + (-0.00170170238212807) .* y1 .^ 5.*x1 .^ 2 + (0.0142762567362889) .* y1 .^ 5.*x1 .^ 3 +
          (-0.00240183488416596) .* y1 .^ 4.*x1 .^ 1 + (0.0191194710059804) .* y1 .^ 4.*x1 .^ 2 + (3.21178249594636e-05)
           .* y1 .^ 4.*x1 .^ 3 + (-0.00473910210220308) .* y1 .^ 4.*x1 .^ 4 + (0.0142347178577749) .* y1 .^ 3.
          *x1 .^ 1 + (0.00470131686109246) .* y1 .^ 3.*x1 .^ 2 + (-0.0103905035774516) .* y1 .^ 3.*x1 .^ 3 +
          (-0.00345411885047965) .* y1 .^ 3.*x1 .^ 4 + (0.00457183274451846) .* y1 .^ 2.*x1 .^ 1 + (-0.00330956663217591)
           .* y1 .^ 2.*x1 .^ 2 + (0.00118629230820848) .* y1 .^ 2.*x1 .^ 3 + (0.000853670706839869) .* y1 .^
          2.*x1 .^ 4 + (0.00745906376710768) .* y1 .^ 1.*x1 .^ 1 + (0.00392224292412835) .* y1 .^ 1.*x1 .^ 2 +
          (0.00275457874731475) .* y1 .^ 1.*x1 .^ 3 + (0.000518414254205189) .* y1 .^ 1.*x1 .^ 4);
      elseif s > s_dew + ds then //SH
        x2 :=(log(p) - 13.7071132855869)/1.17643731075378;
        y2 :=(s - 2250.07204094540)/229.076195367092;
        T :=316.705530001855 + 35.5566500848004*(-0.375766285553996 + (2.03331585559827) .* x2 .^ 1 + (0.197311018145921)
           .* x2 .^ 2 + (-0.00333850968434481) .* x2 .^ 3 + (1.84286948879548) .* y2 .^ 1 + (0.398319830817416)
           .* y2 .^ 2 + (-0.113081724981705) .* y2 .^ 3 + (0.0363920874770569) .* y2 .^ 4 + (-0.0359334077085979)
           .* y2 .^ 5 + (0.0357966031978766) .* y2 .^ 6 + (-0.0199514119421308) .* y2 .^ 7 + (0.0117237022936487)
           .* y2 .^ 8 + (-0.00926338514292344) .* y2 .^ 9 + (0.00448308729108809) .* y2 .^ 10 + (-0.00108738241931603)
           .* y2 .^ 11 + (0.000151523254843577) .* y2 .^ 12 + (-1.05821938016847e-05) .* y2 .^ 13 + (-0.000155757187592964)
           .* y2 .^ 12.*x2 .^ 1 + (0.0014219299219045) .* y2 .^ 11.*x2 .^ 1 + (-0.000518965686434385) .* y2 .^
          11.*x2 .^ 2 + (-0.00664776496246994) .* y2 .^ 10.*x2 .^ 1 + (0.00358212855433257) .* y2 .^ 10.*x2 .^
          2 + (-0.000433211172560297) .* y2 .^ 10.*x2 .^ 3 + (0.0195111759234777) .* y2 .^ 9.*x2 .^ 1 + (-0.0109278810021953)
           .* y2 .^ 9.*x2 .^ 2 + (0.00252649804841591) .* y2 .^ 9.*x2 .^ 3 + (-0.0300274929854407) .* y2 .^ 8.
          *x2 .^ 1 + (0.0217640613178696) .* y2 .^ 8.*x2 .^ 2 + (-0.00509620757849376) .* y2 .^ 8.*x2 .^ 3 +
          (0.0270285821269334) .* y2 .^ 7.*x2 .^ 1 + (-0.0261964656527746) .* y2 .^ 7.*x2 .^ 2 + (0.00529061239576283)
           .* y2 .^ 7.*x2 .^ 3 + (-0.0518433009473107) .* y2 .^ 6.*x2 .^ 1 + (0.0213429014854132) .* y2 .^ 6.
          *x2 .^ 2 + (-0.0060227017741088) .* y2 .^ 6.*x2 .^ 3 + (0.108240604566648) .* y2 .^ 5.*x2 .^ 1 + (-0.0549169952871548)
           .* y2 .^ 5.*x2 .^ 2 + (0.0106627428452813) .* y2 .^ 5.*x2 .^ 3 + (-0.110636317014871) .* y2 .^ 4.*
          x2 .^ 1 + (0.11522956080352) .* y2 .^ 4.*x2 .^ 2 + (-0.0236309575728537) .* y2 .^ 4.*x2 .^ 3 + (0.0864866514064992)
           .* y2 .^ 3.*x2 .^ 1 + (-0.101319949615718) .* y2 .^ 3.*x2 .^ 2 + (0.03798907512142) .* y2 .^ 3.*
          x2 .^ 3 + (-0.127132695814496) .* y2 .^ 2.*x2 .^ 1 + (0.0633097573605523) .* y2 .^ 2.*x2 .^ 2 + (-0.0274214596124245)
           .* y2 .^ 2.*x2 .^ 3 + (0.257192337297865) .* y2 .^ 1.*x2 .^ 1 + (-0.116821389068364) .* y2 .^ 1.*
          x2 .^ 2 + (0.00409214454982833) .* y2 .^ 1.*x2 .^ 3);
      elseif s < s_bubble then //SC+smooth
        x1 :=(log(p) - 14.9448573563973)/0.881691674720842;
        y1 :=(s - 766.507566800662)/354.359519730800;
        T1 :=240.674827018988 + 52.7804347025945*(-0.0473524138478641 + (0.0162103214519941) .* x1 .^ 1 + (0.00731712571431491)
           .* x1 .^ 2 + (0.00162110867808151) .* x1 .^ 3 + (9.01357817428802e-05) .* x1 .^ 4 + (0.994698974040281)
           .* y1 .^ 1 + (0.0826799337772093) .* y1 .^ 2 + (-0.0096283413640456) .* y1 .^ 3 + (-0.0334900245004738)
           .* y1 .^ 4 + (0.00322039669586458) .* y1 .^ 5 + (0.0261381341562466) .* y1 .^ 6 + (-0.0172653610868116)
           .* y1 .^ 7 + (0.00204400577825453) .* y1 .^ 8 + (0.00586678329215318) .* y1 .^ 7.*x1 .^ 1 + (0.00405831580633545)
           .* y1 .^ 6.*x1 .^ 1 + (-0.012636519314169) .* y1 .^ 6.*x1 .^ 2 + (-0.0183127993873416) .* y1 .^ 5.
          *x1 .^ 1 + (-0.00170170238212807) .* y1 .^ 5.*x1 .^ 2 + (0.0142762567362889) .* y1 .^ 5.*x1 .^ 3 +
          (-0.00240183488416596) .* y1 .^ 4.*x1 .^ 1 + (0.0191194710059804) .* y1 .^ 4.*x1 .^ 2 + (3.21178249594636e-05)
           .* y1 .^ 4.*x1 .^ 3 + (-0.00473910210220308) .* y1 .^ 4.*x1 .^ 4 + (0.0142347178577749) .* y1 .^ 3.
          *x1 .^ 1 + (0.00470131686109246) .* y1 .^ 3.*x1 .^ 2 + (-0.0103905035774516) .* y1 .^ 3.*x1 .^ 3 +
          (-0.00345411885047965) .* y1 .^ 3.*x1 .^ 4 + (0.00457183274451846) .* y1 .^ 2.*x1 .^ 1 + (-0.00330956663217591)
           .* y1 .^ 2.*x1 .^ 2 + (0.00118629230820848) .* y1 .^ 2.*x1 .^ 3 + (0.000853670706839869) .* y1 .^
          2.*x1 .^ 4 + (0.00745906376710768) .* y1 .^ 1.*x1 .^ 1 + (0.00392224292412835) .* y1 .^ 1.*x1 .^ 2 +
          (0.00275457874731475) .* y1 .^ 1.*x1 .^ 3 + (0.000518414254205189) .* y1 .^ 1.*x1 .^ 4);
        T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) + T1*(s_bubble - s)/ds;
      elseif s > s_dew then //SH+smooth
        x2 :=(log(p) - 13.7071132855869)/1.17643731075378;
        y2 :=(s - 2250.07204094540)/229.076195367092;
        T2 :=316.705530001855 + 35.5566500848004*(-0.375766285553996 + (2.03331585559827) .* x2 .^ 1 + (0.197311018145921)
           .* x2 .^ 2 + (-0.00333850968434481) .* x2 .^ 3 + (1.84286948879548) .* y2 .^ 1 + (0.398319830817416)
           .* y2 .^ 2 + (-0.113081724981705) .* y2 .^ 3 + (0.0363920874770569) .* y2 .^ 4 + (-0.0359334077085979)
           .* y2 .^ 5 + (0.0357966031978766) .* y2 .^ 6 + (-0.0199514119421308) .* y2 .^ 7 + (0.0117237022936487)
           .* y2 .^ 8 + (-0.00926338514292344) .* y2 .^ 9 + (0.00448308729108809) .* y2 .^ 10 + (-0.00108738241931603)
           .* y2 .^ 11 + (0.000151523254843577) .* y2 .^ 12 + (-1.05821938016847e-05) .* y2 .^ 13 + (-0.000155757187592964)
           .* y2 .^ 12.*x2 .^ 1 + (0.0014219299219045) .* y2 .^ 11.*x2 .^ 1 + (-0.000518965686434385) .* y2 .^
          11.*x2 .^ 2 + (-0.00664776496246994) .* y2 .^ 10.*x2 .^ 1 + (0.00358212855433257) .* y2 .^ 10.*x2 .^
          2 + (-0.000433211172560297) .* y2 .^ 10.*x2 .^ 3 + (0.0195111759234777) .* y2 .^ 9.*x2 .^ 1 + (-0.0109278810021953)
           .* y2 .^ 9.*x2 .^ 2 + (0.00252649804841591) .* y2 .^ 9.*x2 .^ 3 + (-0.0300274929854407) .* y2 .^ 8.
          *x2 .^ 1 + (0.0217640613178696) .* y2 .^ 8.*x2 .^ 2 + (-0.00509620757849376) .* y2 .^ 8.*x2 .^ 3 +
          (0.0270285821269334) .* y2 .^ 7.*x2 .^ 1 + (-0.0261964656527746) .* y2 .^ 7.*x2 .^ 2 + (0.00529061239576283)
           .* y2 .^ 7.*x2 .^ 3 + (-0.0518433009473107) .* y2 .^ 6.*x2 .^ 1 + (0.0213429014854132) .* y2 .^ 6.
          *x2 .^ 2 + (-0.0060227017741088) .* y2 .^ 6.*x2 .^ 3 + (0.108240604566648) .* y2 .^ 5.*x2 .^ 1 + (-0.0549169952871548)
           .* y2 .^ 5.*x2 .^ 2 + (0.0106627428452813) .* y2 .^ 5.*x2 .^ 3 + (-0.110636317014871) .* y2 .^ 4.*
          x2 .^ 1 + (0.11522956080352) .* y2 .^ 4.*x2 .^ 2 + (-0.0236309575728537) .* y2 .^ 4.*x2 .^ 3 + (0.0864866514064992)
           .* y2 .^ 3.*x2 .^ 1 + (-0.101319949615718) .* y2 .^ 3.*x2 .^ 2 + (0.03798907512142) .* y2 .^ 3.*
          x2 .^ 3 + (-0.127132695814496) .* y2 .^ 2.*x2 .^ 1 + (0.0633097573605523) .* y2 .^ 2.*x2 .^ 2 + (-0.0274214596124245)
           .* y2 .^ 2.*x2 .^ 3 + (0.257192337297865) .* y2 .^ 1.*x2 .^ 1 + (-0.116821389068364) .* y2 .^ 1.*
          x2 .^ 2 + (0.00409214454982833) .* y2 .^ 1.*x2 .^ 3);
        T := saturationTemperature(p)*(1 - (s - s_dew)/ds) + T2*(s - s_dew)/ ds;
      else
        T := saturationTemperature(p);
      end if;
    elseif s > s_scr then //SCr
      x3 :=(log(p) - 15.6565076456638)/0.0642760073907664;
      y3 :=(s - 1736.35712929561)/154.281677684303;
      T :=358.591558827730 + 6.50356756495230*(-0.327383467359897 + (0.576847579291881) .* x3 .^ 1 + (-0.00217987427601312)
         .* x3 .^ 2 + (0.493113593820795) .* y3 .^ 1 + (0.515029853899761) .* y3 .^ 2 + (0.348851344630716) .*
        y3 .^ 3 + (-0.0544553058302868) .* y3 .^ 4 + (-0.000369733329215711) .* y3 .^ 3.*x3 .^ 1 + (-0.04757138292723)
         .* y3 .^ 2.*x3 .^ 1 + (0.00593556024416352) .* y3 .^ 2.*x3 .^ 2 + (0.200942284474854) .* y3 .^ 1.*
        x3 .^ 1 + (-0.00257363302643843) .* y3 .^ 1.*x3 .^ 2);

    elseif s < s_scr then //SC
      x1 :=(log(p) - 14.9448573563973)/0.881691674720842;
      y1 :=(s - 766.507566800662)/354.359519730800;
      T :=240.674827018988 + 52.7804347025945*(-0.0473524138478641 + (0.0162103214519941) .* x1 .^ 1 + (0.00731712571431491)
           .* x1 .^ 2 + (0.00162110867808151) .* x1 .^ 3 + (9.01357817428802e-05) .* x1 .^ 4 + (0.994698974040281)
           .* y1 .^ 1 + (0.0826799337772093) .* y1 .^ 2 + (-0.0096283413640456) .* y1 .^ 3 + (-0.0334900245004738)
           .* y1 .^ 4 + (0.00322039669586458) .* y1 .^ 5 + (0.0261381341562466) .* y1 .^ 6 + (-0.0172653610868116)
           .* y1 .^ 7 + (0.00204400577825453) .* y1 .^ 8 + (0.00586678329215318) .* y1 .^ 7.*x1 .^ 1 + (0.00405831580633545)
           .* y1 .^ 6.*x1 .^ 1 + (-0.012636519314169) .* y1 .^ 6.*x1 .^ 2 + (-0.0183127993873416) .* y1 .^ 5.
          *x1 .^ 1 + (-0.00170170238212807) .* y1 .^ 5.*x1 .^ 2 + (0.0142762567362889) .* y1 .^ 5.*x1 .^ 3 +
          (-0.00240183488416596) .* y1 .^ 4.*x1 .^ 1 + (0.0191194710059804) .* y1 .^ 4.*x1 .^ 2 + (3.21178249594636e-05)
           .* y1 .^ 4.*x1 .^ 3 + (-0.00473910210220308) .* y1 .^ 4.*x1 .^ 4 + (0.0142347178577749) .* y1 .^ 3.
          *x1 .^ 1 + (0.00470131686109246) .* y1 .^ 3.*x1 .^ 2 + (-0.0103905035774516) .* y1 .^ 3.*x1 .^ 3 +
          (-0.00345411885047965) .* y1 .^ 3.*x1 .^ 4 + (0.00457183274451846) .* y1 .^ 2.*x1 .^ 1 + (-0.00330956663217591)
           .* y1 .^ 2.*x1 .^ 2 + (0.00118629230820848) .* y1 .^ 2.*x1 .^ 3 + (0.000853670706839869) .* y1 .^
          2.*x1 .^ 4 + (0.00745906376710768) .* y1 .^ 1.*x1 .^ 1 + (0.00392224292412835) .* y1 .^ 1.*x1 .^ 2 +
          (0.00275457874731475) .* y1 .^ 1.*x1 .^ 3 + (0.000518414254205189) .* y1 .^ 1.*x1 .^ 4);
    end if;

  annotation (Documentation(info="<html>
<p>Calculates&nbsp;temperature&nbsp;as&nbsp;function&nbsp;of&nbsp;pressure&nbsp;and&nbsp;specific&nbsp;entropy.</p>
</html>"));
  end temperature_ps;

  redeclare replaceable function density_pT
    "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";

protected
    SmoothTransition st;
    AbsolutePressure dp = st.d_pT;
    SaturationProperties sat = setSat_T(T=T);
    Real x1;
    Real y1;
    Real d1;
    Real x2;
    Real y2;
    Real d2;
    Real x3;
    Real y3;
    Real x4;
    Real y4;
    Real x5;
    Real y5;
    Real x6;
    Real y6;
    Real fitSCrSH;
    Real fitSCrSC;
    Real x_SCrSH;
    Real x_SCrSC;

  algorithm
    if T<340.57 then
       fitSCrSH :=999E5;
       fitSCrSC :=0;
   elseif T>370 then
       fitSCrSH :=999E5;
       fitSCrSC :=999E5;
   else
      x_SCrSH :=(T - 354.619217758985)/7.47858134651005;
      fitSCrSH :=5818000 + 682861.015629584*(-0.00242242294098191 .* x_SCrSH .^
        8 - 0.000688523391288815 .* x_SCrSH .^ 7 + 0.0130038164806081 .*
        x_SCrSH .^ 6 + 0.00320875213623223 .* x_SCrSH .^ 5 - 0.0168315020645627 .*
        x_SCrSH .^ 4 + 0.0120426108475615 .* x_SCrSH .^ 3 + 0.0941725227150269 .*
        x_SCrSH .^ 2 + 0.989042133043436 .* x_SCrSH - 0.088459232314772);
      x_SCrSC :=(T - 347.270507399577)/4.07834835348235;
      fitSCrSC :=5818000 + 682861.015629584*(0.000229066752167707 .* x_SCrSC .^
        8 - 0.000279927449325522 .* x_SCrSC .^ 7 - 0.00106611373536093 .*
        x_SCrSC .^ 6 + 0.000942031837871028 .* x_SCrSC .^ 5 + 0.00135347026896384
         .* x_SCrSC .^ 4 - 0.00230609402237783 .* x_SCrSC .^ 3 - 0.0473286506949754
         .* x_SCrSC .^ 2 + 1.0075160406481 .* x_SCrSC + 0.0471820001146352);
    end if;

       if p < 4638824.76245235 then //SC, SH, SC+smooth or SH+smooth
         if p < sat.psat - dp then //SH
           x1 :=(p - 3155007.46717796)/1902724.74357708;
           y1 :=(T - 340.729994750689)/26.7750632578421;
           d :=91.2556357096757 + 67.6689469701425*(-0.153816874289484 + (1.09030980859846)
           .* x1 .^ 1 + (0.40884234442083) .* x1 .^ 2 + (0.178663669446626) .*
          x1 .^ 3 + (0.154102735637681) .* x1 .^ 4 + (0.320544056071162) .* x1 .^
          5 + (0.329397036539936) .* x1 .^ 6 + (0.141924392037996) .* x1 .^ 7 +
          (0.0208843014024313) .* x1 .^ 8 + (-0.28855690407307) .* y1 .^ 1 + (0.112882218117448)
           .* y1 .^ 2 + (-0.0319904285325252) .* y1 .^ 3 + (0.0589388814565942) .*
          y1 .^ 4 + (-0.099009646625881) .* y1 .^ 5 + (0.0488187054080812) .*
          y1 .^ 6 + (-0.00393953415918085) .* y1 .^ 7 + (-0.000265281797498745) .*
          y1 .^ 8 + (6.35227177418435e-06) .* y1 .^ 9 + (-0.000208820474064316) .*
          y1 .^ 8.*x1 .^ 1 + (-0.0054003557389728) .* y1 .^ 7.*x1 .^ 1 + (-0.00179841148776328)
           .* y1 .^ 7.*x1 .^ 2 + (0.152552314576544) .* y1 .^ 6.*x1 .^ 1 + (0.14626810597185)
           .* y1 .^ 6.*x1 .^ 2 + (0.0440889999328306) .* y1 .^ 6.*x1 .^ 3 + (-0.587631813651913)
           .* y1 .^ 5.*x1 .^ 1 + (-1.10912607572411) .* y1 .^ 5.*x1 .^ 2 + (-0.834114226987898)
           .* y1 .^ 5.*x1 .^ 3 + (-0.217407506824295) .* y1 .^ 5.*x1 .^ 4 + (0.697135085518535)
           .* y1 .^ 4.*x1 .^ 1 + (2.32055613407982) .* y1 .^ 4.*x1 .^ 2 + (3.18576639310759)
           .* y1 .^ 4.*x1 .^ 3 + (1.93485621029609) .* y1 .^ 4.*x1 .^ 4 + (0.431322330019011)
           .* y1 .^ 4.*x1 .^ 5 + (-0.294011395864131) .* y1 .^ 3.*x1 .^ 1 + (-1.81655659985923)
           .* y1 .^ 3.*x1 .^ 2 + (-4.29630124616595) .* y1 .^ 3.*x1 .^ 3 + (-4.50782282113991)
           .* y1 .^ 3.*x1 .^ 4 + (-2.15622252969935) .* y1 .^ 3.*x1 .^ 5 + (-0.384201211563032)
           .* y1 .^ 3.*x1 .^ 6 + (0.241138173533525) .* y1 .^ 2.*x1 .^ 1 + (0.61015099031029)
           .* y1 .^ 2.*x1 .^ 2 + (2.27061229452656) .* y1 .^ 2.*x1 .^ 3 + (4.04690776768162)
           .* y1 .^ 2.*x1 .^ 4 + (3.28973055199247) .* y1 .^ 2.*x1 .^ 5 + (1.18787434153965)
           .* y1 .^ 2.*x1 .^ 6 + (0.146402805200256) .* y1 .^ 2.*x1 .^ 7 + (-0.524272291726848)
           .* y1 .^ 1.*x1 .^ 1 + (-0.422418073183747) .* y1 .^ 1.*x1 .^ 2 + (-0.525589359584282)
           .* y1 .^ 1.*x1 .^ 3 + (-1.38333810133086) .* y1 .^ 1.*x1 .^ 4 + (-1.8696345064376)
           .* y1 .^ 1.*x1 .^ 5 + (-1.14196418867597) .* y1 .^ 1.*x1 .^ 6 + (-0.290220924323982)
           .* y1 .^ 1.*x1 .^ 7 + (-0.0184972812650676) .* y1 .^ 1.*x1 .^ 8);
         elseif p >sat.psat+dp then //SC
           x2 :=(p - 4350471.53120770)/1708120.00447193;
           y2 :=(T - 291.215864607579)/32.1521651128453;
           d :=984.836456813105 + 131.141835832421*(0.148036494247666 + (0.0627763452117915)
           .* x2 .^ 1 + (-0.00213170936105093) .* x2 .^ 2 + (0.000255178820769605)
           .* x2 .^ 3 + (5.16611795294423e-05) .* x2 .^ 4 + (-1.92652217155409e-05)
           .* x2 .^ 5 + (-3.57871790180926e-05) .* x2 .^ 6 + (1.84317868056315e-06)
           .* x2 .^ 7 + (5.16625409631055e-06) .* x2 .^ 8 + (-0.928204893459867)
           .* y2 .^ 1 + (-0.127834302011047) .* y2 .^ 2 + (-0.0403309713064787) .*
          y2 .^ 3 + (-0.0286520069051961) .* y2 .^ 4 + (-0.0222725725755049) .*
          y2 .^ 5 + (0.00508443939166798) .* y2 .^ 6 + (0.0124892852298909) .*
          y2 .^ 7 + (-0.00181368550990209) .* y2 .^ 8 + (-0.00570362703840147) .*
          y2 .^ 9 + (-0.00154221232313551) .* y2 .^ 10 + (0.00335897420190136) .*
          y2 .^ 9.*x2 .^ 1 + (0.0119526229342936) .* y2 .^ 8.*x2 .^ 1 + (-0.00241223690478703)
           .* y2 .^ 8.*x2 .^ 2 + (0.00513202405023323) .* y2 .^ 7.*x2 .^ 1 + (-0.00918678244705043)
           .* y2 .^ 7.*x2 .^ 2 + (0.000794206276217148) .* y2 .^ 7.*x2 .^ 3 + (-0.0191722646406342)
           .* y2 .^ 6.*x2 .^ 1 + (-0.00719783026145076) .* y2 .^ 6.*x2 .^ 2 + (0.0032032146829887)
           .* y2 .^ 6.*x2 .^ 3 + (-8.15780257879476e-05) .* y2 .^ 6.*x2 .^ 4 + (
          -0.00959387377848716) .* y2 .^ 5.*x2 .^ 1 + (0.00832754825458531) .*
          y2 .^ 5.*x2 .^ 2 + (0.00373884215007602) .* y2 .^ 5.*x2 .^ 3 + (-0.000416052681948202)
           .* y2 .^ 5.*x2 .^ 4 + (-9.61546907507027e-05) .* y2 .^ 5.*x2 .^ 5 + (
          0.0232142197798867) .* y2 .^ 4.*x2 .^ 1 + (0.00867144508366618) .* y2 .^
          4.*x2 .^ 2 + (-9.17330263269491e-05) .* y2 .^ 4.*x2 .^ 3 + (-0.000762752085372283)
           .* y2 .^ 4.*x2 .^ 4 + (-0.000208485817157239) .* y2 .^ 4.*x2 .^ 5 + (
          5.63778682804286e-05) .* y2 .^ 4.*x2 .^ 6 + (0.0249802932422087) .*
          y2 .^ 3.*x2 .^ 1 + (-0.00600044001389064) .* y2 .^ 3.*x2 .^ 2 + (-0.00229066250464987)
           .* y2 .^ 3.*x2 .^ 3 + (-0.00053522816288523) .* y2 .^ 3.*x2 .^ 4 + (5.13562762997183e-05)
           .* y2 .^ 3.*x2 .^ 5 + (0.000133979086502526) .* y2 .^ 3.*x2 .^ 6 + (-1.88604781448369e-05)
           .* y2 .^ 3.*x2 .^ 7 + (0.0223272884231725) .* y2 .^ 2.*x2 .^ 1 + (-0.00785521309638188)
           .* y2 .^ 2.*x2 .^ 2 + (-0.000397324900932298) .* y2 .^ 2.*x2 .^ 3 + (
          5.63806486723599e-06) .* y2 .^ 2.*x2 .^ 4 + (0.000248035875178736) .*
          y2 .^ 2.*x2 .^ 5 + (3.28182588026234e-05) .* y2 .^ 2.*x2 .^ 6 + (-3.30630772428301e-05)
           .* y2 .^ 2.*x2 .^ 7 + (7.29079529086298e-06) .* y2 .^ 2.*x2 .^ 8 + (0.0411603606521363)
           .* y2 .^ 1.*x2 .^ 1 + (-0.00352349859779118) .* y2 .^ 1.*x2 .^ 2 + (0.00073918871569354)
           .* y2 .^ 1.*x2 .^ 3 + (0.000166726834467521) .* y2 .^ 1.*x2 .^ 4 + (3.25325927219962e-05)
           .* y2 .^ 1.*x2 .^ 5 + (-8.66093363459636e-05) .* y2 .^ 1.*x2 .^ 6 + (
          -5.70995527600744e-06) .* y2 .^ 1.*x2 .^ 7 + (1.4585771209285e-05) .*
          y2 .^ 1.*x2 .^ 8);
         elseif p<sat.psat then //"SH + smooth"
           x1 :=(p - 3155007.46717796)/1902724.74357708;
           y1 :=(T - 340.729994750689)/26.7750632578421;
           d1 :=91.2556357096757 + 67.6689469701425*(-0.153816874289484 + (1.09030980859846)
           .* x1 .^ 1 + (0.40884234442083) .* x1 .^ 2 + (0.178663669446626) .*
          x1 .^ 3 + (0.154102735637681) .* x1 .^ 4 + (0.320544056071162) .* x1 .^
          5 + (0.329397036539936) .* x1 .^ 6 + (0.141924392037996) .* x1 .^ 7 +
          (0.0208843014024313) .* x1 .^ 8 + (-0.28855690407307) .* y1 .^ 1 + (0.112882218117448)
           .* y1 .^ 2 + (-0.0319904285325252) .* y1 .^ 3 + (0.0589388814565942) .*
          y1 .^ 4 + (-0.099009646625881) .* y1 .^ 5 + (0.0488187054080812) .*
          y1 .^ 6 + (-0.00393953415918085) .* y1 .^ 7 + (-0.000265281797498745) .*
          y1 .^ 8 + (6.35227177418435e-06) .* y1 .^ 9 + (-0.000208820474064316) .*
          y1 .^ 8.*x1 .^ 1 + (-0.0054003557389728) .* y1 .^ 7.*x1 .^ 1 + (-0.00179841148776328)
           .* y1 .^ 7.*x1 .^ 2 + (0.152552314576544) .* y1 .^ 6.*x1 .^ 1 + (0.14626810597185)
           .* y1 .^ 6.*x1 .^ 2 + (0.0440889999328306) .* y1 .^ 6.*x1 .^ 3 + (-0.587631813651913)
           .* y1 .^ 5.*x1 .^ 1 + (-1.10912607572411) .* y1 .^ 5.*x1 .^ 2 + (-0.834114226987898)
           .* y1 .^ 5.*x1 .^ 3 + (-0.217407506824295) .* y1 .^ 5.*x1 .^ 4 + (0.697135085518535)
           .* y1 .^ 4.*x1 .^ 1 + (2.32055613407982) .* y1 .^ 4.*x1 .^ 2 + (3.18576639310759)
           .* y1 .^ 4.*x1 .^ 3 + (1.93485621029609) .* y1 .^ 4.*x1 .^ 4 + (0.431322330019011)
           .* y1 .^ 4.*x1 .^ 5 + (-0.294011395864131) .* y1 .^ 3.*x1 .^ 1 + (-1.81655659985923)
           .* y1 .^ 3.*x1 .^ 2 + (-4.29630124616595) .* y1 .^ 3.*x1 .^ 3 + (-4.50782282113991)
           .* y1 .^ 3.*x1 .^ 4 + (-2.15622252969935) .* y1 .^ 3.*x1 .^ 5 + (-0.384201211563032)
           .* y1 .^ 3.*x1 .^ 6 + (0.241138173533525) .* y1 .^ 2.*x1 .^ 1 + (0.61015099031029)
           .* y1 .^ 2.*x1 .^ 2 + (2.27061229452656) .* y1 .^ 2.*x1 .^ 3 + (4.04690776768162)
           .* y1 .^ 2.*x1 .^ 4 + (3.28973055199247) .* y1 .^ 2.*x1 .^ 5 + (1.18787434153965)
           .* y1 .^ 2.*x1 .^ 6 + (0.146402805200256) .* y1 .^ 2.*x1 .^ 7 + (-0.524272291726848)
           .* y1 .^ 1.*x1 .^ 1 + (-0.422418073183747) .* y1 .^ 1.*x1 .^ 2 + (-0.525589359584282)
           .* y1 .^ 1.*x1 .^ 3 + (-1.38333810133086) .* y1 .^ 1.*x1 .^ 4 + (-1.8696345064376)
           .* y1 .^ 1.*x1 .^ 5 + (-1.14196418867597) .* y1 .^ 1.*x1 .^ 6 + (-0.290220924323982)
           .* y1 .^ 1.*x1 .^ 7 + (-0.0184972812650676) .* y1 .^ 1.*x1 .^ 8);
           d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
         elseif p > sat.psat then //SC+smooth
           x2 :=(p - 4350471.53120770)/1708120.00447193;
           y2 :=(T - 291.215864607579)/32.1521651128453;
           d2 :=984.836456813105 + 131.141835832421*(0.148036494247666 + (0.0627763452117915)
           .* x2 .^ 1 + (-0.00213170936105093) .* x2 .^ 2 + (0.000255178820769605)
           .* x2 .^ 3 + (5.16611795294423e-05) .* x2 .^ 4 + (-1.92652217155409e-05)
           .* x2 .^ 5 + (-3.57871790180926e-05) .* x2 .^ 6 + (1.84317868056315e-06)
           .* x2 .^ 7 + (5.16625409631055e-06) .* x2 .^ 8 + (-0.928204893459867)
           .* y2 .^ 1 + (-0.127834302011047) .* y2 .^ 2 + (-0.0403309713064787) .*
          y2 .^ 3 + (-0.0286520069051961) .* y2 .^ 4 + (-0.0222725725755049) .*
          y2 .^ 5 + (0.00508443939166798) .* y2 .^ 6 + (0.0124892852298909) .*
          y2 .^ 7 + (-0.00181368550990209) .* y2 .^ 8 + (-0.00570362703840147) .*
          y2 .^ 9 + (-0.00154221232313551) .* y2 .^ 10 + (0.00335897420190136) .*
          y2 .^ 9.*x2 .^ 1 + (0.0119526229342936) .* y2 .^ 8.*x2 .^ 1 + (-0.00241223690478703)
           .* y2 .^ 8.*x2 .^ 2 + (0.00513202405023323) .* y2 .^ 7.*x2 .^ 1 + (-0.00918678244705043)
           .* y2 .^ 7.*x2 .^ 2 + (0.000794206276217148) .* y2 .^ 7.*x2 .^ 3 + (-0.0191722646406342)
           .* y2 .^ 6.*x2 .^ 1 + (-0.00719783026145076) .* y2 .^ 6.*x2 .^ 2 + (0.0032032146829887)
           .* y2 .^ 6.*x2 .^ 3 + (-8.15780257879476e-05) .* y2 .^ 6.*x2 .^ 4 + (
          -0.00959387377848716) .* y2 .^ 5.*x2 .^ 1 + (0.00832754825458531) .*
          y2 .^ 5.*x2 .^ 2 + (0.00373884215007602) .* y2 .^ 5.*x2 .^ 3 + (-0.000416052681948202)
           .* y2 .^ 5.*x2 .^ 4 + (-9.61546907507027e-05) .* y2 .^ 5.*x2 .^ 5 + (
          0.0232142197798867) .* y2 .^ 4.*x2 .^ 1 + (0.00867144508366618) .* y2 .^
          4.*x2 .^ 2 + (-9.17330263269491e-05) .* y2 .^ 4.*x2 .^ 3 + (-0.000762752085372283)
           .* y2 .^ 4.*x2 .^ 4 + (-0.000208485817157239) .* y2 .^ 4.*x2 .^ 5 + (
          5.63778682804286e-05) .* y2 .^ 4.*x2 .^ 6 + (0.0249802932422087) .*
          y2 .^ 3.*x2 .^ 1 + (-0.00600044001389064) .* y2 .^ 3.*x2 .^ 2 + (-0.00229066250464987)
           .* y2 .^ 3.*x2 .^ 3 + (-0.00053522816288523) .* y2 .^ 3.*x2 .^ 4 + (5.13562762997183e-05)
           .* y2 .^ 3.*x2 .^ 5 + (0.000133979086502526) .* y2 .^ 3.*x2 .^ 6 + (-1.88604781448369e-05)
           .* y2 .^ 3.*x2 .^ 7 + (0.0223272884231725) .* y2 .^ 2.*x2 .^ 1 + (-0.00785521309638188)
           .* y2 .^ 2.*x2 .^ 2 + (-0.000397324900932298) .* y2 .^ 2.*x2 .^ 3 + (
          5.63806486723599e-06) .* y2 .^ 2.*x2 .^ 4 + (0.000248035875178736) .*
          y2 .^ 2.*x2 .^ 5 + (3.28182588026234e-05) .* y2 .^ 2.*x2 .^ 6 + (-3.30630772428301e-05)
           .* y2 .^ 2.*x2 .^ 7 + (7.29079529086298e-06) .* y2 .^ 2.*x2 .^ 8 + (0.0411603606521363)
           .* y2 .^ 1.*x2 .^ 1 + (-0.00352349859779118) .* y2 .^ 1.*x2 .^ 2 + (0.00073918871569354)
           .* y2 .^ 1.*x2 .^ 3 + (0.000166726834467521) .* y2 .^ 1.*x2 .^ 4 + (3.25325927219962e-05)
           .* y2 .^ 1.*x2 .^ 5 + (-8.66093363459636e-05) .* y2 .^ 1.*x2 .^ 6 + (
          -5.70995527600744e-06) .* y2 .^ 1.*x2 .^ 7 + (1.4585771209285e-05) .*
          y2 .^ 1.*x2 .^ 8);
           d := dewDensity(sat)*(1 -(p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
         end if;
       elseif p < 5782000 then //SC,SH,Tra1 or Tra2
         if p > sat.psat then //SC or Tra1
           if p > fitSCrSC then //SC
              x2 :=(p - 4350471.53120770)/1708120.00447193;
              y2 :=(T - 291.215864607579)/32.1521651128453;
              d :=984.836456813105 + 131.141835832421*(0.148036494247666 + (0.0627763452117915)
             .* x2 .^ 1 + (-0.00213170936105093) .* x2 .^ 2 + (0.000255178820769605)
             .* x2 .^ 3 + (5.16611795294423e-05) .* x2 .^ 4 + (-1.92652217155409e-05)
             .* x2 .^ 5 + (-3.57871790180926e-05) .* x2 .^ 6 + (1.84317868056315e-06)
             .* x2 .^ 7 + (5.16625409631055e-06) .* x2 .^ 8 + (-0.928204893459867)
             .* y2 .^ 1 + (-0.127834302011047) .* y2 .^ 2 + (-0.0403309713064787)
             .* y2 .^ 3 + (-0.0286520069051961) .* y2 .^ 4 + (-0.0222725725755049)
             .* y2 .^ 5 + (0.00508443939166798) .* y2 .^ 6 + (0.0124892852298909)
             .* y2 .^ 7 + (-0.00181368550990209) .* y2 .^ 8 + (-0.00570362703840147)
             .* y2 .^ 9 + (-0.00154221232313551) .* y2 .^ 10 + (0.00335897420190136)
             .* y2 .^ 9.*x2 .^ 1 + (0.0119526229342936) .* y2 .^ 8.*x2 .^ 1 + (-0.00241223690478703)
             .* y2 .^ 8.*x2 .^ 2 + (0.00513202405023323) .* y2 .^ 7.*x2 .^ 1 + (
            -0.00918678244705043) .* y2 .^ 7.*x2 .^ 2 + (0.000794206276217148) .*
            y2 .^ 7.*x2 .^ 3 + (-0.0191722646406342) .* y2 .^ 6.*x2 .^ 1 + (-0.00719783026145076)
             .* y2 .^ 6.*x2 .^ 2 + (0.0032032146829887) .* y2 .^ 6.*x2 .^ 3 + (-8.15780257879476e-05)
             .* y2 .^ 6.*x2 .^ 4 + (-0.00959387377848716) .* y2 .^ 5.*x2 .^ 1 +
            (0.00832754825458531) .* y2 .^ 5.*x2 .^ 2 + (0.00373884215007602) .*
            y2 .^ 5.*x2 .^ 3 + (-0.000416052681948202) .* y2 .^ 5.*x2 .^ 4 + (-9.61546907507027e-05)
             .* y2 .^ 5.*x2 .^ 5 + (0.0232142197798867) .* y2 .^ 4.*x2 .^ 1 + (0.00867144508366618)
             .* y2 .^ 4.*x2 .^ 2 + (-9.17330263269491e-05) .* y2 .^ 4.*x2 .^ 3 +
            (-0.000762752085372283) .* y2 .^ 4.*x2 .^ 4 + (-0.000208485817157239)
             .* y2 .^ 4.*x2 .^ 5 + (5.63778682804286e-05) .* y2 .^ 4.*x2 .^ 6 +
            (0.0249802932422087) .* y2 .^ 3.*x2 .^ 1 + (-0.00600044001389064) .*
            y2 .^ 3.*x2 .^ 2 + (-0.00229066250464987) .* y2 .^ 3.*x2 .^ 3 + (-0.00053522816288523)
             .* y2 .^ 3.*x2 .^ 4 + (5.13562762997183e-05) .* y2 .^ 3.*x2 .^ 5 +
            (0.000133979086502526) .* y2 .^ 3.*x2 .^ 6 + (-1.88604781448369e-05)
             .* y2 .^ 3.*x2 .^ 7 + (0.0223272884231725) .* y2 .^ 2.*x2 .^ 1 + (-0.00785521309638188)
             .* y2 .^ 2.*x2 .^ 2 + (-0.000397324900932298) .* y2 .^ 2.*x2 .^ 3 +
            (5.63806486723599e-06) .* y2 .^ 2.*x2 .^ 4 + (0.000248035875178736) .*
            y2 .^ 2.*x2 .^ 5 + (3.28182588026234e-05) .* y2 .^ 2.*x2 .^ 6 + (-3.30630772428301e-05)
             .* y2 .^ 2.*x2 .^ 7 + (7.29079529086298e-06) .* y2 .^ 2.*x2 .^ 8 +
            (0.0411603606521363) .* y2 .^ 1.*x2 .^ 1 + (-0.00352349859779118) .*
            y2 .^ 1.*x2 .^ 2 + (0.00073918871569354) .* y2 .^ 1.*x2 .^ 3 + (0.000166726834467521)
             .* y2 .^ 1.*x2 .^ 4 + (3.25325927219962e-05) .* y2 .^ 1.*x2 .^ 5 +
            (-8.66093363459636e-05) .* y2 .^ 1.*x2 .^ 6 + (-5.70995527600744e-06)
             .* y2 .^ 1.*x2 .^ 7 + (1.4585771209285e-05) .* y2 .^ 1.*x2 .^ 8);
           else //Tra1
             x3 :=(p - 5397273.33301376)/269586.928567425;
             y3 :=(T - 346.544516082638)/2.25186055640163;
             d :=649.164735082322 + 34.3087091145699*(0.130924951197768 + (0.806872256295052)
             .* x3 .^ 1 + (-0.155514302781379) .* x3 .^ 2 + (-0.165652019399263)
             .* x3 .^ 3 + (0.123777590551267) .* x3 .^ 4 + (0.413997449195575) .*
            x3 .^ 5 + (-0.763337533477599) .* x3 .^ 6 + (0.412247749951004) .*
            x3 .^ 7 + (-0.0446276074604995) .* x3 .^ 8 + (-1.55858378168443) .*
            y3 .^ 1 + (-0.235772324880373) .* y3 .^ 2 + (0.29718486129751) .*
            y3 .^ 3 + (-1.85938963366391) .* y3 .^ 4 + (-2.10434449054327) .*
            y3 .^ 5 + (3.47033816837345) .* y3 .^ 6 + (1.68126979510675) .* y3 .^
            7 + (-2.50148852583949) .* y3 .^ 8 + (-0.143524835842511) .* x3 .^ 7.
            *y3 .^ 1 + (-1.26374772582275) .* x3 .^ 6.*y3 .^ 1 + (1.47299443290182)
             .* x3 .^ 6.*y3 .^ 2 + (3.39970083297753) .* x3 .^ 5.*y3 .^ 1 + (-1.17954427601318)
             .* x3 .^ 5.*y3 .^ 2 + (-2.14287223183397) .* x3 .^ 5.*y3 .^ 3 + (-3.03042876425108)
             .* x3 .^ 4.*y3 .^ 1 + (-4.24317671829689) .* x3 .^ 4.*y3 .^ 2 + (10.519444907272)
             .* x3 .^ 4.*y3 .^ 3 + (-3.91716986924788) .* x3 .^ 4.*y3 .^ 4 + (0.513159434633507)
             .* x3 .^ 3.*y3 .^ 1 + (8.40446996721878) .* x3 .^ 3.*y3 .^ 2 + (-2.97095253081265)
             .* x3 .^ 3.*y3 .^ 3 + (-19.6397780694396) .* x3 .^ 3.*y3 .^ 4 + (15.3964648578749)
             .* x3 .^ 3.*y3 .^ 5 + (0.572302249913626) .* x3 .^ 2.*y3 .^ 1 + (-2.9478261223038)
             .* x3 .^ 2.*y3 .^ 2 + (-11.38211325592) .* x3 .^ 2.*y3 .^ 3 + (12.2558328077475)
             .* x3 .^ 2.*y3 .^ 4 + (17.9478675925998) .* x3 .^ 2.*y3 .^ 5 + (-19.1536163806433)
             .* x3 .^ 2.*y3 .^ 6 + (0.38321569682328) .* x3 .^ 1.*y3 .^ 1 + (-0.698544009269031)
             .* x3 .^ 1.*y3 .^ 2 + (4.1381527891807) .* x3 .^ 1.*y3 .^ 3 + (7.69790450423632)
             .* x3 .^ 1.*y3 .^ 4 + (-11.1391990716515) .* x3 .^ 1.*y3 .^ 5 + (-8.4787880399033)
             .* x3 .^ 1.*y3 .^ 6 + (11.0326253880169) .* x3 .^ 1.*y3 .^ 7);
           end if;
         elseif p < sat.psat then //SH or Tra2
           if p < fitSCrSH then //SH
             x1 :=(p - 3155007.46717796)/1902724.74357708;
             y1 :=(T - 340.729994750689)/26.7750632578421;
             d :=91.2556357096757 + 67.6689469701425*(-0.153816874289484 + (1.09030980859846)
             .* x1 .^ 1 + (0.40884234442083) .* x1 .^ 2 + (0.178663669446626) .*
            x1 .^ 3 + (0.154102735637681) .* x1 .^ 4 + (0.320544056071162) .*
            x1 .^ 5 + (0.329397036539936) .* x1 .^ 6 + (0.141924392037996) .*
            x1 .^ 7 + (0.0208843014024313) .* x1 .^ 8 + (-0.28855690407307) .*
            y1 .^ 1 + (0.112882218117448) .* y1 .^ 2 + (-0.0319904285325252) .*
            y1 .^ 3 + (0.0589388814565942) .* y1 .^ 4 + (-0.099009646625881) .*
            y1 .^ 5 + (0.0488187054080812) .* y1 .^ 6 + (-0.00393953415918085) .*
            y1 .^ 7 + (-0.000265281797498745) .* y1 .^ 8 + (6.35227177418435e-06)
             .* y1 .^ 9 + (-0.000208820474064316) .* y1 .^ 8.*x1 .^ 1 + (-0.0054003557389728)
             .* y1 .^ 7.*x1 .^ 1 + (-0.00179841148776328) .* y1 .^ 7.*x1 .^ 2 +
            (0.152552314576544) .* y1 .^ 6.*x1 .^ 1 + (0.14626810597185) .* y1 .^
            6.*x1 .^ 2 + (0.0440889999328306) .* y1 .^ 6.*x1 .^ 3 + (-0.587631813651913)
             .* y1 .^ 5.*x1 .^ 1 + (-1.10912607572411) .* y1 .^ 5.*x1 .^ 2 + (-0.834114226987898)
             .* y1 .^ 5.*x1 .^ 3 + (-0.217407506824295) .* y1 .^ 5.*x1 .^ 4 + (0.697135085518535)
             .* y1 .^ 4.*x1 .^ 1 + (2.32055613407982) .* y1 .^ 4.*x1 .^ 2 + (3.18576639310759)
             .* y1 .^ 4.*x1 .^ 3 + (1.93485621029609) .* y1 .^ 4.*x1 .^ 4 + (0.431322330019011)
             .* y1 .^ 4.*x1 .^ 5 + (-0.294011395864131) .* y1 .^ 3.*x1 .^ 1 + (-1.81655659985923)
             .* y1 .^ 3.*x1 .^ 2 + (-4.29630124616595) .* y1 .^ 3.*x1 .^ 3 + (-4.50782282113991)
             .* y1 .^ 3.*x1 .^ 4 + (-2.15622252969935) .* y1 .^ 3.*x1 .^ 5 + (-0.384201211563032)
             .* y1 .^ 3.*x1 .^ 6 + (0.241138173533525) .* y1 .^ 2.*x1 .^ 1 + (0.61015099031029)
             .* y1 .^ 2.*x1 .^ 2 + (2.27061229452656) .* y1 .^ 2.*x1 .^ 3 + (4.04690776768162)
             .* y1 .^ 2.*x1 .^ 4 + (3.28973055199247) .* y1 .^ 2.*x1 .^ 5 + (1.18787434153965)
             .* y1 .^ 2.*x1 .^ 6 + (0.146402805200256) .* y1 .^ 2.*x1 .^ 7 + (-0.524272291726848)
             .* y1 .^ 1.*x1 .^ 1 + (-0.422418073183747) .* y1 .^ 1.*x1 .^ 2 + (-0.525589359584282)
             .* y1 .^ 1.*x1 .^ 3 + (-1.38333810133086) .* y1 .^ 1.*x1 .^ 4 + (-1.8696345064376)
             .* y1 .^ 1.*x1 .^ 5 + (-1.14196418867597) .* y1 .^ 1.*x1 .^ 6 + (-0.290220924323982)
             .* y1 .^ 1.*x1 .^ 7 + (-0.0184972812650676) .* y1 .^ 1.*x1 .^ 8);
           else //Tra2
             x4 :=(p - 5411345.04574654)/252740.819256351;
             y4 :=(T - 349.414434494840)/2.85039996210552;
             d :=228.765473126582 + 22.8882819071589*(-0.0700892114560997 + (2.37623726542892)
             .* x4 .^ 1 + (1.09197656064322) .* x4 .^ 2 + (0.994348392244099) .*
            x4 .^ 3 + (1.35072537776111) .* x4 .^ 4 + (0.464399803383307) .* x4 .^
            5 + (0.785617261231851) .* x4 .^ 6 + (1.96618117446035) .* x4 .^ 7 +
            (1.25813125088072) .* x4 .^ 8 + (-1.76152046532849) .* y4 .^ 1 + (0.944271789590046)
             .* y4 .^ 2 + (-1.01603483538685) .* y4 .^ 3 + (2.13870488430061) .*
            y4 .^ 4 + (-0.600113099502131) .* y4 .^ 5 + (-3.3609792285634) .*
            y4 .^ 6 + (-0.781694496547208) .* y4 .^ 7 + (3.50884417060597) .*
            y4 .^ 8 + (-6.76284589564173) .* x4 .^ 7.*y4 .^ 1 + (-8.4050611151014)
             .* x4 .^ 6.*y4 .^ 1 + (11.6828997586791) .* x4 .^ 6.*y4 .^ 2 + (-5.8368933230609)
             .* x4 .^ 5.*y4 .^ 1 + (11.898837302523) .* x4 .^ 5.*y4 .^ 2 + (-2.47582008255665)
             .* x4 .^ 5.*y4 .^ 3 + (-3.96533137923383) .* x4 .^ 4.*y4 .^ 1 + (12.8652273529012)
             .* x4 .^ 4.*y4 .^ 2 + (-3.02546172852466) .* x4 .^ 4.*y4 .^ 3 + (-12.2323495628209)
             .* x4 .^ 4.*y4 .^ 4 + (-5.77911113921249) .* x4 .^ 3.*y4 .^ 1 + (10.0983967337123)
             .* x4 .^ 3.*y4 .^ 2 + (-8.24092516378255) .* x4 .^ 3.*y4 .^ 3 + (-7.09735449070928)
             .* x4 .^ 3.*y4 .^ 4 + (6.23373882455842) .* x4 .^ 3.*y4 .^ 5 + (-3.00304748688342)
             .* x4 .^ 2.*y4 .^ 1 + (9.65873998904681) .* x4 .^ 2.*y4 .^ 2 + (-10.7851673400763)
             .* x4 .^ 2.*y4 .^ 3 + (-6.07175686521754) .* x4 .^ 2.*y4 .^ 4 + (5.11737318229648)
             .* x4 .^ 2.*y4 .^ 5 + (10.9963092913038) .* x4 .^ 2.*y4 .^ 6 + (-2.08493751055818)
             .* x4 .^ 1.*y4 .^ 1 + (3.01379583322069) .* x4 .^ 1.*y4 .^ 2 + (-7.36751314339748)
             .* x4 .^ 1.*y4 .^ 3 + (4.79007434120291) .* x4 .^ 1.*y4 .^ 4 + (9.85992591595724)
             .* x4 .^ 1.*y4 .^ 5 + (0.326993900488611) .* x4 .^ 1.*y4 .^ 6 + (-12.2089397046865)
             .* x4 .^ 1.*y4 .^ 7);
           end if;
         end if;
       elseif p < 5910000 then //SC,SH or SCr1
         if p > fitSCrSC then //SC
           x2 :=(p - 4350471.53120770)/1708120.00447193;
           y2 :=(T - 291.215864607579)/32.1521651128453;
           d :=984.836456813105 + 131.141835832421*(0.148036494247666 + (0.0627763452117915)
           .* x2 .^ 1 + (-0.00213170936105093) .* x2 .^ 2 + (0.000255178820769605)
           .* x2 .^ 3 + (5.16611795294423e-05) .* x2 .^ 4 + (-1.92652217155409e-05)
           .* x2 .^ 5 + (-3.57871790180926e-05) .* x2 .^ 6 + (1.84317868056315e-06)
           .* x2 .^ 7 + (5.16625409631055e-06) .* x2 .^ 8 + (-0.928204893459867)
           .* y2 .^ 1 + (-0.127834302011047) .* y2 .^ 2 + (-0.0403309713064787) .*
          y2 .^ 3 + (-0.0286520069051961) .* y2 .^ 4 + (-0.0222725725755049) .*
          y2 .^ 5 + (0.00508443939166798) .* y2 .^ 6 + (0.0124892852298909) .*
          y2 .^ 7 + (-0.00181368550990209) .* y2 .^ 8 + (-0.00570362703840147) .*
          y2 .^ 9 + (-0.00154221232313551) .* y2 .^ 10 + (0.00335897420190136) .*
          y2 .^ 9.*x2 .^ 1 + (0.0119526229342936) .* y2 .^ 8.*x2 .^ 1 + (-0.00241223690478703)
           .* y2 .^ 8.*x2 .^ 2 + (0.00513202405023323) .* y2 .^ 7.*x2 .^ 1 + (-0.00918678244705043)
           .* y2 .^ 7.*x2 .^ 2 + (0.000794206276217148) .* y2 .^ 7.*x2 .^ 3 + (-0.0191722646406342)
           .* y2 .^ 6.*x2 .^ 1 + (-0.00719783026145076) .* y2 .^ 6.*x2 .^ 2 + (0.0032032146829887)
           .* y2 .^ 6.*x2 .^ 3 + (-8.15780257879476e-05) .* y2 .^ 6.*x2 .^ 4 + (
          -0.00959387377848716) .* y2 .^ 5.*x2 .^ 1 + (0.00832754825458531) .*
          y2 .^ 5.*x2 .^ 2 + (0.00373884215007602) .* y2 .^ 5.*x2 .^ 3 + (-0.000416052681948202)
           .* y2 .^ 5.*x2 .^ 4 + (-9.61546907507027e-05) .* y2 .^ 5.*x2 .^ 5 + (
          0.0232142197798867) .* y2 .^ 4.*x2 .^ 1 + (0.00867144508366618) .* y2 .^
          4.*x2 .^ 2 + (-9.17330263269491e-05) .* y2 .^ 4.*x2 .^ 3 + (-0.000762752085372283)
           .* y2 .^ 4.*x2 .^ 4 + (-0.000208485817157239) .* y2 .^ 4.*x2 .^ 5 + (
          5.63778682804286e-05) .* y2 .^ 4.*x2 .^ 6 + (0.0249802932422087) .*
          y2 .^ 3.*x2 .^ 1 + (-0.00600044001389064) .* y2 .^ 3.*x2 .^ 2 + (-0.00229066250464987)
           .* y2 .^ 3.*x2 .^ 3 + (-0.00053522816288523) .* y2 .^ 3.*x2 .^ 4 + (5.13562762997183e-05)
           .* y2 .^ 3.*x2 .^ 5 + (0.000133979086502526) .* y2 .^ 3.*x2 .^ 6 + (-1.88604781448369e-05)
           .* y2 .^ 3.*x2 .^ 7 + (0.0223272884231725) .* y2 .^ 2.*x2 .^ 1 + (-0.00785521309638188)
           .* y2 .^ 2.*x2 .^ 2 + (-0.000397324900932298) .* y2 .^ 2.*x2 .^ 3 + (
          5.63806486723599e-06) .* y2 .^ 2.*x2 .^ 4 + (0.000248035875178736) .*
          y2 .^ 2.*x2 .^ 5 + (3.28182588026234e-05) .* y2 .^ 2.*x2 .^ 6 + (-3.30630772428301e-05)
           .* y2 .^ 2.*x2 .^ 7 + (7.29079529086298e-06) .* y2 .^ 2.*x2 .^ 8 + (0.0411603606521363)
           .* y2 .^ 1.*x2 .^ 1 + (-0.00352349859779118) .* y2 .^ 1.*x2 .^ 2 + (0.00073918871569354)
           .* y2 .^ 1.*x2 .^ 3 + (0.000166726834467521) .* y2 .^ 1.*x2 .^ 4 + (3.25325927219962e-05)
           .* y2 .^ 1.*x2 .^ 5 + (-8.66093363459636e-05) .* y2 .^ 1.*x2 .^ 6 + (
          -5.70995527600744e-06) .* y2 .^ 1.*x2 .^ 7 + (1.4585771209285e-05) .*
          y2 .^ 1.*x2 .^ 8);
         elseif p > fitSCrSH then //SCr1
           x5 :=(p - 5847309.50819672)/36939.9917809753;
           y5 :=(T - 351.426693208430)/2.42906062366123;
           d :=458.395346307012 + 179.036579108450*(0.361738456901902 + (0.345702076272234)
           .* x5 .^ 1 + (-0.0879880621302428) .* x5 .^ 2 + (0.0021563345822951) .*
          x5 .^ 3 + (0.00214288079056596) .* x5 .^ 4 + (-0.00241877071925521) .*
          x5 .^ 5 + (-3.14325195980229) .* y5 .^ 1 + (-5.31191457951079) .* y5 .^
          2 + (8.53771356974337) .* y5 .^ 3 + (22.2330715218424) .* y5 .^ 4 + (-17.6907166909455)
           .* y5 .^ 5 + (-44.1362404527325) .* y5 .^ 6 + (21.9591208877636) .*
          y5 .^ 7 + (47.8813628191663) .* y5 .^ 8 + (-16.7117039883594) .* y5 .^
          9 + (-29.9957399913936) .* y5 .^ 10 + (7.8834641774218) .* y5 .^ 11 +
          (10.8246409362393) .* y5 .^ 12 + (-2.24998289259161) .* y5 .^ 13 + (-2.08871764737033)
           .* y5 .^ 14 + (0.356156724746213) .* y5 .^ 15 + (0.166850169902269) .*
          y5 .^ 16 + (-0.0240180485973518) .* y5 .^ 17 + (-0.00733241200533883) .*
          y5 .^ 16.*x5 .^ 1 + (-0.30557893304175) .* y5 .^ 15.*x5 .^ 1 + (0.0595001326919001)
           .* y5 .^ 15.*x5 .^ 2 + (0.00564841409415959) .* y5 .^ 14.*x5 .^ 1 + (
          0.239907219437272) .* y5 .^ 14.*x5 .^ 2 + (-0.0557469678532415) .* y5 .^
          14.*x5 .^ 3 + (3.35457538583056) .* y5 .^ 13.*x5 .^ 1 + (-0.544501443433037)
           .* y5 .^ 13.*x5 .^ 2 + (-0.0966183614213308) .* y5 .^ 13.*x5 .^ 3 + (
          0.0242836174547122) .* y5 .^ 13.*x5 .^ 4 + (0.458144033614467) .* y5 .^
          12.*x5 .^ 1 + (-2.27152953825706) .* y5 .^ 12.*x5 .^ 2 + (0.467046782331512)
           .* y5 .^ 12.*x5 .^ 3 + (0.0142016449033911) .* y5 .^ 12.*x5 .^ 4 + (-0.00550093275556504)
           .* y5 .^ 12.*x5 .^ 5 + (-14.9587337321475) .* y5 .^ 11.*x5 .^ 1 + (1.91461475626652)
           .* y5 .^ 11.*x5 .^ 2 + (0.77376351128001) .* y5 .^ 11.*x5 .^ 3 + (-0.179035526729738)
           .* y5 .^ 11.*x5 .^ 4 + (0.00165281112441268) .* y5 .^ 11.*x5 .^ 5 + (
          -2.77233891037667) .* y5 .^ 10.*x5 .^ 1 + (8.54071045668324) .* y5 .^
          10.*x5 .^ 2 + (-1.52146464537482) .* y5 .^ 10.*x5 .^ 3 + (-0.0855039009865688)
           .* y5 .^ 10.*x5 .^ 4 + (0.0398555020274547) .* y5 .^ 10.*x5 .^ 5 + (34.7585265852407)
           .* y5 .^ 9.*x5 .^ 1 + (-3.1585091003893) .* y5 .^ 9.*x5 .^ 2 + (-2.39366286185811)
           .* y5 .^ 9.*x5 .^ 3 + (0.501506953772939) .* y5 .^ 9.*x5 .^ 4 + (-0.0154456773577564)
           .* y5 .^ 9.*x5 .^ 5 + (7.169392242108) .* y5 .^ 8.*x5 .^ 1 + (-16.2245613116128)
           .* y5 .^ 8.*x5 .^ 2 + (2.42798279002435) .* y5 .^ 8.*x5 .^ 3 + (0.186867371446866)
           .* y5 .^ 8.*x5 .^ 4 + (-0.112941095805267) .* y5 .^ 8.*x5 .^ 5 + (-44.8280465574115)
           .* y5 .^ 7.*x5 .^ 1 + (2.22079540052477) .* y5 .^ 7.*x5 .^ 2 + (3.60137528231974)
           .* y5 .^ 7.*x5 .^ 3 + (-0.663103985919271) .* y5 .^ 7.*x5 .^ 4 + (0.0475581509841805)
           .* y5 .^ 7.*x5 .^ 5 + (-9.63279931461399) .* y5 .^ 6.*x5 .^ 1 + (16.3571788919245)
           .* y5 .^ 6.*x5 .^ 2 + (-1.95575503819626) .* y5 .^ 6.*x5 .^ 3 + (-0.186749894587816)
           .* y5 .^ 6.*x5 .^ 4 + (0.156747966475313) .* y5 .^ 6.*x5 .^ 5 + (31.4955528632591)
           .* y5 .^ 5.*x5 .^ 1 + (-0.0502003420307129) .* y5 .^ 5.*x5 .^ 2 + (-2.71715132384977)
           .* y5 .^ 5.*x5 .^ 3 + (0.413766230715094) .* y5 .^ 5.*x5 .^ 4 + (-0.0598956204509143)
           .* y5 .^ 5.*x5 .^ 5 + (6.82176472517707) .* y5 .^ 4.*x5 .^ 1 + (-8.35223474765901)
           .* y5 .^ 4.*x5 .^ 2 + (0.725904944574274) .* y5 .^ 4.*x5 .^ 3 + (0.0928337536563534)
           .* y5 .^ 4.*x5 .^ 4 + (-0.107121655625495) .* y5 .^ 4.*x5 .^ 5 + (-10.8895254231832)
           .* y5 .^ 3.*x5 .^ 1 + (-0.624884222041724) .* y5 .^ 3.*x5 .^ 2 + (0.941760663461926)
           .* y5 .^ 3.*x5 .^ 3 + (-0.102863065553322) .* y5 .^ 3.*x5 .^ 4 + (0.0289013413005304)
           .* y5 .^ 3.*x5 .^ 5 + (-2.35091655077164) .* y5 .^ 2.*x5 .^ 1 + (1.81100012725733)
           .* y5 .^ 2.*x5 .^ 2 + (-0.0918123470922209) .* y5 .^ 2.*x5 .^ 3 + (-0.0241515299109697)
           .* y5 .^ 2.*x5 .^ 4 + (0.0310275796437958) .* y5 .^ 2.*x5 .^ 5 + (1.4023955764209)
           .* y5 .^ 1.*x5 .^ 1 + (0.189748191087143) .* y5 .^ 1.*x5 .^ 2 + (-0.109372784730326)
           .* y5 .^ 1.*x5 .^ 3 + (0.00537827577294237) .* y5 .^ 1.*x5 .^ 4 + (-0.00344432002352935)
           .* y5 .^ 1.*x5 .^ 5);
         else //SH
           x1 :=(p - 3155007.46717796)/1902724.74357708;
           y1 :=(T - 340.729994750689)/26.7750632578421;
           d :=91.2556357096757 + 67.6689469701425*(-0.153816874289484 + (1.09030980859846)
           .* x1 .^ 1 + (0.40884234442083) .* x1 .^ 2 + (0.178663669446626) .*
          x1 .^ 3 + (0.154102735637681) .* x1 .^ 4 + (0.320544056071162) .* x1 .^
          5 + (0.329397036539936) .* x1 .^ 6 + (0.141924392037996) .* x1 .^ 7 +
          (0.0208843014024313) .* x1 .^ 8 + (-0.28855690407307) .* y1 .^ 1 + (0.112882218117448)
           .* y1 .^ 2 + (-0.0319904285325252) .* y1 .^ 3 + (0.0589388814565942) .*
          y1 .^ 4 + (-0.099009646625881) .* y1 .^ 5 + (0.0488187054080812) .*
          y1 .^ 6 + (-0.00393953415918085) .* y1 .^ 7 + (-0.000265281797498745) .*
          y1 .^ 8 + (6.35227177418435e-06) .* y1 .^ 9 + (-0.000208820474064316) .*
          y1 .^ 8.*x1 .^ 1 + (-0.0054003557389728) .* y1 .^ 7.*x1 .^ 1 + (-0.00179841148776328)
           .* y1 .^ 7.*x1 .^ 2 + (0.152552314576544) .* y1 .^ 6.*x1 .^ 1 + (0.14626810597185)
           .* y1 .^ 6.*x1 .^ 2 + (0.0440889999328306) .* y1 .^ 6.*x1 .^ 3 + (-0.587631813651913)
           .* y1 .^ 5.*x1 .^ 1 + (-1.10912607572411) .* y1 .^ 5.*x1 .^ 2 + (-0.834114226987898)
           .* y1 .^ 5.*x1 .^ 3 + (-0.217407506824295) .* y1 .^ 5.*x1 .^ 4 + (0.697135085518535)
           .* y1 .^ 4.*x1 .^ 1 + (2.32055613407982) .* y1 .^ 4.*x1 .^ 2 + (3.18576639310759)
           .* y1 .^ 4.*x1 .^ 3 + (1.93485621029609) .* y1 .^ 4.*x1 .^ 4 + (0.431322330019011)
           .* y1 .^ 4.*x1 .^ 5 + (-0.294011395864131) .* y1 .^ 3.*x1 .^ 1 + (-1.81655659985923)
           .* y1 .^ 3.*x1 .^ 2 + (-4.29630124616595) .* y1 .^ 3.*x1 .^ 3 + (-4.50782282113991)
           .* y1 .^ 3.*x1 .^ 4 + (-2.15622252969935) .* y1 .^ 3.*x1 .^ 5 + (-0.384201211563032)
           .* y1 .^ 3.*x1 .^ 6 + (0.241138173533525) .* y1 .^ 2.*x1 .^ 1 + (0.61015099031029)
           .* y1 .^ 2.*x1 .^ 2 + (2.27061229452656) .* y1 .^ 2.*x1 .^ 3 + (4.04690776768162)
           .* y1 .^ 2.*x1 .^ 4 + (3.28973055199247) .* y1 .^ 2.*x1 .^ 5 + (1.18787434153965)
           .* y1 .^ 2.*x1 .^ 6 + (0.146402805200256) .* y1 .^ 2.*x1 .^ 7 + (-0.524272291726848)
           .* y1 .^ 1.*x1 .^ 1 + (-0.422418073183747) .* y1 .^ 1.*x1 .^ 2 + (-0.525589359584282)
           .* y1 .^ 1.*x1 .^ 3 + (-1.38333810133086) .* y1 .^ 1.*x1 .^ 4 + (-1.8696345064376)
           .* y1 .^ 1.*x1 .^ 5 + (-1.14196418867597) .* y1 .^ 1.*x1 .^ 6 + (-0.290220924323982)
           .* y1 .^ 1.*x1 .^ 7 + (-0.0184972812650676) .* y1 .^ 1.*x1 .^ 8);
         end if;
       elseif p > 5910000 then //SC,SH or SCr2
         if p > fitSCrSC then //SC
           x2 :=(p - 4350471.53120770)/1708120.00447193;
           y2 :=(T - 291.215864607579)/32.1521651128453;
           d :=984.836456813105 + 131.141835832421*(0.148036494247666 + (0.0627763452117915)
           .* x2 .^ 1 + (-0.00213170936105093) .* x2 .^ 2 + (0.000255178820769605)
           .* x2 .^ 3 + (5.16611795294423e-05) .* x2 .^ 4 + (-1.92652217155409e-05)
           .* x2 .^ 5 + (-3.57871790180926e-05) .* x2 .^ 6 + (1.84317868056315e-06)
           .* x2 .^ 7 + (5.16625409631055e-06) .* x2 .^ 8 + (-0.928204893459867)
           .* y2 .^ 1 + (-0.127834302011047) .* y2 .^ 2 + (-0.0403309713064787) .*
          y2 .^ 3 + (-0.0286520069051961) .* y2 .^ 4 + (-0.0222725725755049) .*
          y2 .^ 5 + (0.00508443939166798) .* y2 .^ 6 + (0.0124892852298909) .*
          y2 .^ 7 + (-0.00181368550990209) .* y2 .^ 8 + (-0.00570362703840147) .*
          y2 .^ 9 + (-0.00154221232313551) .* y2 .^ 10 + (0.00335897420190136) .*
          y2 .^ 9.*x2 .^ 1 + (0.0119526229342936) .* y2 .^ 8.*x2 .^ 1 + (-0.00241223690478703)
           .* y2 .^ 8.*x2 .^ 2 + (0.00513202405023323) .* y2 .^ 7.*x2 .^ 1 + (-0.00918678244705043)
           .* y2 .^ 7.*x2 .^ 2 + (0.000794206276217148) .* y2 .^ 7.*x2 .^ 3 + (-0.0191722646406342)
           .* y2 .^ 6.*x2 .^ 1 + (-0.00719783026145076) .* y2 .^ 6.*x2 .^ 2 + (0.0032032146829887)
           .* y2 .^ 6.*x2 .^ 3 + (-8.15780257879476e-05) .* y2 .^ 6.*x2 .^ 4 + (
          -0.00959387377848716) .* y2 .^ 5.*x2 .^ 1 + (0.00832754825458531) .*
          y2 .^ 5.*x2 .^ 2 + (0.00373884215007602) .* y2 .^ 5.*x2 .^ 3 + (-0.000416052681948202)
           .* y2 .^ 5.*x2 .^ 4 + (-9.61546907507027e-05) .* y2 .^ 5.*x2 .^ 5 + (
          0.0232142197798867) .* y2 .^ 4.*x2 .^ 1 + (0.00867144508366618) .* y2 .^
          4.*x2 .^ 2 + (-9.17330263269491e-05) .* y2 .^ 4.*x2 .^ 3 + (-0.000762752085372283)
           .* y2 .^ 4.*x2 .^ 4 + (-0.000208485817157239) .* y2 .^ 4.*x2 .^ 5 + (
          5.63778682804286e-05) .* y2 .^ 4.*x2 .^ 6 + (0.0249802932422087) .*
          y2 .^ 3.*x2 .^ 1 + (-0.00600044001389064) .* y2 .^ 3.*x2 .^ 2 + (-0.00229066250464987)
           .* y2 .^ 3.*x2 .^ 3 + (-0.00053522816288523) .* y2 .^ 3.*x2 .^ 4 + (5.13562762997183e-05)
           .* y2 .^ 3.*x2 .^ 5 + (0.000133979086502526) .* y2 .^ 3.*x2 .^ 6 + (-1.88604781448369e-05)
           .* y2 .^ 3.*x2 .^ 7 + (0.0223272884231725) .* y2 .^ 2.*x2 .^ 1 + (-0.00785521309638188)
           .* y2 .^ 2.*x2 .^ 2 + (-0.000397324900932298) .* y2 .^ 2.*x2 .^ 3 + (
          5.63806486723599e-06) .* y2 .^ 2.*x2 .^ 4 + (0.000248035875178736) .*
          y2 .^ 2.*x2 .^ 5 + (3.28182588026234e-05) .* y2 .^ 2.*x2 .^ 6 + (-3.30630772428301e-05)
           .* y2 .^ 2.*x2 .^ 7 + (7.29079529086298e-06) .* y2 .^ 2.*x2 .^ 8 + (0.0411603606521363)
           .* y2 .^ 1.*x2 .^ 1 + (-0.00352349859779118) .* y2 .^ 1.*x2 .^ 2 + (0.00073918871569354)
           .* y2 .^ 1.*x2 .^ 3 + (0.000166726834467521) .* y2 .^ 1.*x2 .^ 4 + (3.25325927219962e-05)
           .* y2 .^ 1.*x2 .^ 5 + (-8.66093363459636e-05) .* y2 .^ 1.*x2 .^ 6 + (
          -5.70995527600744e-06) .* y2 .^ 1.*x2 .^ 7 + (1.4585771209285e-05) .*
          y2 .^ 1.*x2 .^ 8);
         elseif p > fitSCrSH then //SCr2
           x6 :=(p - 6480381.56343999)/310966.566006206;
           y6 :=(T - 356.498773945015)/3.89476721058539;
           d :=453.064484550971 + 141.231611130533*(0.000240890281828179 + (1.21985501051042)
           .* x6 .^ 1 + (-0.461592591768963) .* x6 .^ 2 + (-0.0141964364260063) .*
          x6 .^ 3 + (0.357765603620199) .* x6 .^ 4 + (-0.396916375727557) .* x6 .^
          5 + (-0.120947605324244) .* x6 .^ 6 + (0.226739700324082) .* x6 .^ 7 +
          (0.0142362794494297) .* x6 .^ 8 + (-0.0376008845602434) .* x6 .^ 9 + (
          -2.07388445027597) .* y6 .^ 1 + (0.0644578889486432) .* y6 .^ 2 + (1.48694192336712)
           .* y6 .^ 3 + (-0.342732343508459) .* y6 .^ 4 + (-0.28354905627486) .*
          y6 .^ 5 + (0.285962950438068) .* y6 .^ 6 + (-0.636152569361198) .* y6 .^
          7 + (0.366150443719291) .* y6 .^ 8 + (-0.0828508982910206) .* y6 .^ 9 +
          (-0.563705749593331) .* y6 .^ 10 + (0.776595477279603) .* y6 .^ 11 + (
          0.1926228538253) .* y6 .^ 12 + (-0.498078974634704) .* y6 .^ 13 + (0.0171362386178266)
           .* y6 .^ 14 + (0.1124286846701) .* y6 .^ 15 + (-0.0122812355313894) .*
          y6 .^ 16 + (-0.00672691237091445) .* y6 .^ 17 + (-0.000400306716607446)
           .* y6 .^ 18 + (0.0148755061792277) .* y6 .^ 17.*x6 .^ 1 + (-0.0074118319137531)
           .* y6 .^ 16.*x6 .^ 1 + (-0.0434733710718068) .* y6 .^ 16.*x6 .^ 2 + (
          -0.0215411191812912) .* y6 .^ 15.*x6 .^ 1 + (0.0674711824806431) .*
          y6 .^ 15.*x6 .^ 2 + (0.0237969622416573) .* y6 .^ 15.*x6 .^ 3 + (-0.117755735135683)
           .* y6 .^ 14.*x6 .^ 1 + (0.0720695022745426) .* y6 .^ 14.*x6 .^ 2 + (-0.032609189819994)
           .* y6 .^ 14.*x6 .^ 3 + (0.0568386694999502) .* y6 .^ 14.*x6 .^ 4 + (0.0900755579728093)
           .* y6 .^ 13.*x6 .^ 1 + (-0.332019147721496) .* y6 .^ 13.*x6 .^ 2 + (0.0973477864412099)
           .* y6 .^ 13.*x6 .^ 3 + (-0.198345948895326) .* y6 .^ 13.*x6 .^ 4 + (-0.0831025936017059)
           .* y6 .^ 13.*x6 .^ 5 + (0.611745812515164) .* y6 .^ 12.*x6 .^ 1 + (-0.0934383898733385)
           .* y6 .^ 12.*x6 .^ 2 + (0.541313629533994) .* y6 .^ 12.*x6 .^ 3 + (-0.277280202150173)
           .* y6 .^ 12.*x6 .^ 4 + (0.352824849402888) .* y6 .^ 12.*x6 .^ 5 + (0.0285913047609366)
           .* y6 .^ 12.*x6 .^ 6 + (-0.551781593791943) .* y6 .^ 11.*x6 .^ 1 + (0.480354145101821)
           .* y6 .^ 11.*x6 .^ 2 + (-0.33700884135788) .* y6 .^ 11.*x6 .^ 3 + (0.0220709694279074)
           .* y6 .^ 11.*x6 .^ 4 + (0.00126989858363576) .* y6 .^ 11.*x6 .^ 5 + (
          -0.195272118160877) .* y6 .^ 11.*x6 .^ 6 + (-0.00880331982211974) .*
          y6 .^ 11.*x6 .^ 7 + (-0.340087882696028) .* y6 .^ 10.*x6 .^ 1 + (0.167751341172529)
           .* y6 .^ 10.*x6 .^ 2 + (-0.548892223037262) .* y6 .^ 10.*x6 .^ 3 + (0.380973013339342)
           .* y6 .^ 10.*x6 .^ 4 + (-0.329019399725308) .* y6 .^ 10.*x6 .^ 5 + (0.335408487671082)
           .* y6 .^ 10.*x6 .^ 6 + (-0.033339793411781) .* y6 .^ 10.*x6 .^ 7 + (0.0324973519422749)
           .* y6 .^ 10.*x6 .^ 8 + (0.562740423874149) .* y6 .^ 9.*x6 .^ 1 + (-0.861811967922633)
           .* y6 .^ 9.*x6 .^ 2 + (0.473008314777252) .* y6 .^ 9.*x6 .^ 3 + (-0.728288515834281)
           .* y6 .^ 9.*x6 .^ 4 + (0.189310382166729) .* y6 .^ 9.*x6 .^ 5 + (-0.18430211484455)
           .* y6 .^ 9.*x6 .^ 6 + (-0.154907209425904) .* y6 .^ 9.*x6 .^ 7 + (0.0751048673744012)
           .* y6 .^ 9.*x6 .^ 8 + (-0.0226384023097619) .* y6 .^ 9.*x6 .^ 9 + (-1.38999899322325)
           .* y6 .^ 8.*x6 .^ 1 + (0.820972731157374) .* y6 .^ 8.*x6 .^ 2 + (-0.690416574987237)
           .* y6 .^ 8.*x6 .^ 3 + (0.169202931229058) .* y6 .^ 8.*x6 .^ 4 + (0.541710839203928)
           .* y6 .^ 8.*x6 .^ 5 + (-0.0710309241538594) .* y6 .^ 8.*x6 .^ 6 + (0.590966672640858)
           .* y6 .^ 8.*x6 .^ 7 + (-0.185261309629367) .* y6 .^ 8.*x6 .^ 8 + (-0.0230996140118009)
           .* y6 .^ 8.*x6 .^ 9 + (0.671972515705929) .* y6 .^ 7.*x6 .^ 1 + (1.1626207692766)
           .* y6 .^ 7.*x6 .^ 2 + (-0.756668158911542) .* y6 .^ 7.*x6 .^ 3 + (2.10591022142632)
           .* y6 .^ 7.*x6 .^ 4 + (-0.979152378683444) .* y6 .^ 7.*x6 .^ 5 + (0.968930832040255)
           .* y6 .^ 7.*x6 .^ 6 + (-0.601445958386042) .* y6 .^ 7.*x6 .^ 7 + (-0.37805760919921)
           .* y6 .^ 7.*x6 .^ 8 + (0.172578667999613) .* y6 .^ 7.*x6 .^ 9 + (0.811409943387043)
           .* y6 .^ 6.*x6 .^ 1 + (-1.34540202916415) .* y6 .^ 6.*x6 .^ 2 + (0.919063203099365)
           .* y6 .^ 6.*x6 .^ 3 + (-0.514905321788479) .* y6 .^ 6.*x6 .^ 4 + (-0.0565840431474071)
           .* y6 .^ 6.*x6 .^ 5 + (0.122294358507937) .* y6 .^ 6.*x6 .^ 6 + (-1.60499938829487)
           .* y6 .^ 6.*x6 .^ 7 + (0.750978882746646) .* y6 .^ 6.*x6 .^ 8 + (0.0985693881343304)
           .* y6 .^ 6.*x6 .^ 9 + (-0.69488140169421) .* y6 .^ 5.*x6 .^ 1 + (1.19747613239136)
           .* y6 .^ 5.*x6 .^ 2 + (-0.714212139218628) .* y6 .^ 5.*x6 .^ 3 + (-0.158555295378956)
           .* y6 .^ 5.*x6 .^ 4 + (0.330878740747823) .* y6 .^ 5.*x6 .^ 5 + (-1.55909361375478)
           .* y6 .^ 5.*x6 .^ 6 + (0.873216394794726) .* y6 .^ 5.*x6 .^ 7 + (0.845805319303574)
           .* y6 .^ 5.*x6 .^ 8 + (-0.495229776223459) .* y6 .^ 5.*x6 .^ 9 + (2.35951837323305)
           .* y6 .^ 4.*x6 .^ 1 + (-1.04967027120853) .* y6 .^ 4.*x6 .^ 2 + (-0.420247397631488)
           .* y6 .^ 4.*x6 .^ 3 + (1.3347292209981) .* y6 .^ 4.*x6 .^ 4 + (-2.87816279868556)
           .* y6 .^ 4.*x6 .^ 5 + (0.60224347224061) .* y6 .^ 4.*x6 .^ 6 + (1.52325196777108)
           .* y6 .^ 4.*x6 .^ 7 + (-0.267402684454198) .* y6 .^ 4.*x6 .^ 8 + (-0.239248202729716)
           .* y6 .^ 4.*x6 .^ 9 + (-0.626243309723717) .* y6 .^ 3.*x6 .^ 1 + (-3.12482715234883)
           .* y6 .^ 3.*x6 .^ 2 + (2.45047851439218) .* y6 .^ 3.*x6 .^ 3 + (-1.60726565919526)
           .* y6 .^ 3.*x6 .^ 4 + (0.711296483441231) .* y6 .^ 3.*x6 .^ 5 + (2.26809002487794)
           .* y6 .^ 3.*x6 .^ 6 + (-1.70137078099865) .* y6 .^ 3.*x6 .^ 7 + (-0.39044487214142)
           .* y6 .^ 3.*x6 .^ 8 + (0.360941257941209) .* y6 .^ 3.*x6 .^ 9 + (-2.78019805520102)
           .* y6 .^ 2.*x6 .^ 1 + (1.98524261410352) .* y6 .^ 2.*x6 .^ 2 + (0.194746124371648)
           .* y6 .^ 2.*x6 .^ 3 + (-1.73197637919833) .* y6 .^ 2.*x6 .^ 4 + (2.79103789581133)
           .* y6 .^ 2.*x6 .^ 5 + (-0.240083328465182) .* y6 .^ 2.*x6 .^ 6 + (-1.35260773587785)
           .* y6 .^ 2.*x6 .^ 7 + (0.265831112985154) .* y6 .^ 2.*x6 .^ 8 + (0.133452170164536)
           .* y6 .^ 2.*x6 .^ 9 + (0.650583392593029) .* y6 .^ 1.*x6 .^ 1 + (1.50451813002227)
           .* y6 .^ 1.*x6 .^ 2 + (-1.14668416460682) .* y6 .^ 1.*x6 .^ 3 + (0.454222113727352)
           .* y6 .^ 1.*x6 .^ 4 + (-0.0343978657127673) .* y6 .^ 1.*x6 .^ 5 + (-0.81303609330021)
           .* y6 .^ 1.*x6 .^ 6 + (0.474411724069721) .* y6 .^ 1.*x6 .^ 7 + (0.194649128486682)
           .* y6 .^ 1.*x6 .^ 8 + (-0.128933750027675) .* y6 .^ 1.*x6 .^ 9);
         else //SH
           x1 :=(p - 3155007.46717796)/1902724.74357708;
           y1 :=(T - 340.729994750689)/26.7750632578421;
           d :=91.2556357096757 + 67.6689469701425*(-0.153816874289484 + (1.09030980859846)
           .* x1 .^ 1 + (0.40884234442083) .* x1 .^ 2 + (0.178663669446626) .*
          x1 .^ 3 + (0.154102735637681) .* x1 .^ 4 + (0.320544056071162) .* x1 .^
          5 + (0.329397036539936) .* x1 .^ 6 + (0.141924392037996) .* x1 .^ 7 +
          (0.0208843014024313) .* x1 .^ 8 + (-0.28855690407307) .* y1 .^ 1 + (0.112882218117448)
           .* y1 .^ 2 + (-0.0319904285325252) .* y1 .^ 3 + (0.0589388814565942) .*
          y1 .^ 4 + (-0.099009646625881) .* y1 .^ 5 + (0.0488187054080812) .*
          y1 .^ 6 + (-0.00393953415918085) .* y1 .^ 7 + (-0.000265281797498745) .*
          y1 .^ 8 + (6.35227177418435e-06) .* y1 .^ 9 + (-0.000208820474064316) .*
          y1 .^ 8.*x1 .^ 1 + (-0.0054003557389728) .* y1 .^ 7.*x1 .^ 1 + (-0.00179841148776328)
           .* y1 .^ 7.*x1 .^ 2 + (0.152552314576544) .* y1 .^ 6.*x1 .^ 1 + (0.14626810597185)
           .* y1 .^ 6.*x1 .^ 2 + (0.0440889999328306) .* y1 .^ 6.*x1 .^ 3 + (-0.587631813651913)
           .* y1 .^ 5.*x1 .^ 1 + (-1.10912607572411) .* y1 .^ 5.*x1 .^ 2 + (-0.834114226987898)
           .* y1 .^ 5.*x1 .^ 3 + (-0.217407506824295) .* y1 .^ 5.*x1 .^ 4 + (0.697135085518535)
           .* y1 .^ 4.*x1 .^ 1 + (2.32055613407982) .* y1 .^ 4.*x1 .^ 2 + (3.18576639310759)
           .* y1 .^ 4.*x1 .^ 3 + (1.93485621029609) .* y1 .^ 4.*x1 .^ 4 + (0.431322330019011)
           .* y1 .^ 4.*x1 .^ 5 + (-0.294011395864131) .* y1 .^ 3.*x1 .^ 1 + (-1.81655659985923)
           .* y1 .^ 3.*x1 .^ 2 + (-4.29630124616595) .* y1 .^ 3.*x1 .^ 3 + (-4.50782282113991)
           .* y1 .^ 3.*x1 .^ 4 + (-2.15622252969935) .* y1 .^ 3.*x1 .^ 5 + (-0.384201211563032)
           .* y1 .^ 3.*x1 .^ 6 + (0.241138173533525) .* y1 .^ 2.*x1 .^ 1 + (0.61015099031029)
           .* y1 .^ 2.*x1 .^ 2 + (2.27061229452656) .* y1 .^ 2.*x1 .^ 3 + (4.04690776768162)
           .* y1 .^ 2.*x1 .^ 4 + (3.28973055199247) .* y1 .^ 2.*x1 .^ 5 + (1.18787434153965)
           .* y1 .^ 2.*x1 .^ 6 + (0.146402805200256) .* y1 .^ 2.*x1 .^ 7 + (-0.524272291726848)
           .* y1 .^ 1.*x1 .^ 1 + (-0.422418073183747) .* y1 .^ 1.*x1 .^ 2 + (-0.525589359584282)
           .* y1 .^ 1.*x1 .^ 3 + (-1.38333810133086) .* y1 .^ 1.*x1 .^ 4 + (-1.8696345064376)
           .* y1 .^ 1.*x1 .^ 5 + (-1.14196418867597) .* y1 .^ 1.*x1 .^ 6 + (-0.290220924323982)
           .* y1 .^ 1.*x1 .^ 7 + (-0.0184972812650676) .* y1 .^ 1.*x1 .^ 8);
         end if;
       end if;
  annotation (Documentation(info="<html>
<p>Computes&nbsp;density&nbsp;as&nbsp;a&nbsp;function&nbsp;of&nbsp;pressure&nbsp;and&nbsp;temperature.</p>
</html>"));
  end density_pT;

  redeclare function extends dynamicViscosity
    "Calculates dynamic viscosity of refrigerant"

    /*The functional form of the dynamic viscosity is implented as presented in
 Huber et al. (1999), Transport propertiers of refrigerants R32, R125, R134a and R125 + R32 mixtures in and beyond the critical region */

protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";
    Real Tred = state.T/262.6 "Reduced temperature for lower density terms";
    Real omegaEta "Reduced effective collision cross section";
    Real dilgasEta "dilute-gas viscosity";
    Real M = 52 "molar Mass in g/mol";
    Real resEta "Residual portion of the viscosity";
    Real resEtaL "Residual portion of the viscosity";
    Real resEtaG "Residual portion of the viscosity";
    Real etaL;
    Real etaG;
    Real dcrit = 424 / 0.0520 * 1e-3 "critical density";
    Real dmol = state.d / 0.0520 * 1e-3 "molar density in mol/L";
    Real dmol_bub "molar density at bubble line in mol/L";
    Real dmol_dew "molar density at dew line in mol/L";

  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;
    if (state.phase == 1 or phase_dT == 1) then
    // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
    omegaEta :=1.16145/Tred^(0.14874) + 0.52487*exp((-0.77320)*Tred) + 2.16178*exp(-2.43787*Tred);
    dilgasEta :=26.69579e-9*sqrt(Tred*M)/(omegaEta*0.4282^2);
    resEta :=10^(-7)*exp(0.3745666e1 + (-0.2593564e4)/state.T)*(exp((0.3861782e1 + 0.1807046e5/state.T^(1.5))
        *dmol^(0.1) + (dmol/dcrit - 1)*sqrt(dmol)*(0.1478233e1 + (-0.5001262e3)/state.T + 0.5455701e5/state.T
        ^2)) - 1);
    eta :=dilgasEta + resEta;

    else
  // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
      dmol_bub :=bubbleState.d/0.0520*1e-3;
      dmol_dew :=dewState.d/0.0520*1e-3;
      omegaEta :=1.16145/Tred^(0.14874) + 0.52487*exp((-0.77320)*Tred) + 2.16178*exp(-2.43787*Tred);
      dilgasEta :=26.69579e-9*sqrt(Tred*M)/(omegaEta*0.4282^2);

      resEtaL :=10^(-7)*exp(0.3745666e1 + (-0.2593564e4)/state.T)*(exp((0.3861782e1 + 0.1807046e5/state.T^(1.5))
        *dmol_bub^(0.1) + (dmol_bub/dcrit - 1)*sqrt(dmol_bub)*(0.1478233e1 + (-0.5001262e3)/state.T + 0.5455701e5
        /state.T^2)) - 1);
      resEtaG :=10^(-7)*exp(0.3745666e1 + (-0.2593564e4)/state.T)*(exp((0.3861782e1 + 0.1807046e5/state.T^(1.5))
        *dmol_dew^(0.1) + (dmol_dew/dcrit - 1)*sqrt(dmol_dew)*(0.1478233e1 + (-0.5001262e3)/state.T + 0.5455701e5
        /state.T^2)) - 1);

      etaL :=dilgasEta + resEtaL;
      etaG :=dilgasEta + resEtaG;

      eta := (quality/etaG + (1 - quality)/etaL)^(-1);
    end if;

  annotation (Documentation(info="<html>
<p>Calculates&nbsp;dynamic&nbsp;viscosity&nbsp;of&nbsp;refrigerant.</p>
</html>"));
  end dynamicViscosity;

  redeclare function extends thermalConductivity
  "Calculates thermal conductivity of refrigerant"
    /*The functional form of the thermal conductivity is implented as presented in
    Huber et al. (1999), Transport propertiers of refrigerants R32, R125, R134a and R125 + R32 mixtures in and beyond the critical region*/

protected
      SaturationProperties sat = setSat_T(state.T) "Saturation properties";
      Integer phase_dT "Phase calculated by density and temperature";

      ThermodynamicState bubbleState "Thermodynamic state at bubble line";
      ThermodynamicState dewState "Thermodynamic state at dew line";
      Real quality "Vapour quality";
      Real lambdaIdg "Thermal conductivity for the limit of zero density";
      Real lambdaRes "Thermal conductivity for residual part";
      Real lambdaResL "Thermal conductivity for residual part at bubble line";
      Real lambdaResG "Thermal conductivity for residual part at dew line";
      Real lambdaG;
      Real lambdaL;
      Real dmol = state.d / 0.0520 * 1e-3 "molar density in mol/L";
      Real dmol_bub "molar density at bubble line in mol/L";
      Real dmol_dew "molar density at dew line in mol/L";

  algorithm
      // Check phase
      if state.phase == 0 then
          phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
        else
          phase_dT :=state.phase;
        end if;
      if (state.phase == 1 or phase_dT == 1) then
        lambdaIdg :=0.124363e-1 + (-0.628224e-3)*state.T + 0.199947e-6*state.T^2;
        lambdaRes :=(0.793100e-2 + (-0.129997e-4)*state.T)*dmol + ((-0.373196e-3) + 0.189222e-5*state.T)*
        dmol^2 + (0.195280e-4 + (-0.116382e-6)*state.T)*dmol^3 + ((-0.267308e-6) + 0.299505e-8*state.T)*dmol^
        4;
        lambda :=lambdaIdg + lambdaRes;

      else
        bubbleState := setBubbleState(setSat_T(state.T));
        dewState := setDewState(setSat_T(state.T));
        quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

        // Calculate the dynamic visocity near the limit of zero density
        dmol_bub :=bubbleState.d/0.0520*1e-3;
        dmol_dew :=dewState.d/0.0520*1e-3;

        lambdaIdg :=0.124363e-1 + (-0.628224e-3)*state.T + 0.199947e-6*state.T^2;
        lambdaResL :=(0.793100e-2 + (-0.129997e-4)*state.T)*dmol_bub + ((-0.373196e-3) + 0.189222e-5*state.T)
        *dmol_bub^2 + (0.195280e-4 + (-0.116382e-6)*state.T)*dmol_bub^3 + ((-0.267308e-6) + 0.299505e-8*
        state.T)*dmol_bub^4;
        lambdaResG :=(0.793100e-2 + (-0.129997e-4)*state.T)*dmol_dew + ((-0.373196e-3) + 0.189222e-5*state.T)
        *dmol_dew^2 + (0.195280e-4 + (-0.116382e-6)*state.T)*dmol_dew^3 + ((-0.267308e-6) + 0.299505e-8*
        state.T)*dmol_dew^4;

        lambdaL :=lambdaIdg + lambdaResL;
        lambdaG :=lambdaIdg + lambdaResG;

        // Calculate the final dynamic visocity
        lambda := (quality/lambdaG + (1 - quality)/lambdaL)^(-1);
      end if;

  annotation (Documentation(info="<html>
<p>Calculates&nbsp;thermal&nbsp;conductivity&nbsp;of&nbsp;refrigerant.</p>
</html>"));
  end thermalConductivity;

  redeclare function extends surfaceTension
  "Surface tension in two phase region of refrigerant"

    /*The functional form of the surface tension is implented as presented in
    Fröba and Leipertz (2003), Thermophysical Properties of the Refrigerant
    Mixtures R410A and R407C from Dynamic Light Scattering (DLS).
    International Journal ofThermophysics, Vol. 24, No. 5.
  */
protected
  Real x = abs(1- sat.Tsat/343.16) "Dimensionless temperature";

  algorithm
    sigma :=0.07147*x^(1.246);

  annotation (Documentation(info="<html>
<p>Surface&nbsp;tension&nbsp;in&nbsp;two&nbsp;phase&nbsp;region&nbsp;of&nbsp;refrigerant.</p>
</html>"));
  end surfaceTension;

annotation (Documentation(info="<html>
<p>This package provides a refrigerant model for R32 using a hybrid approach developed by Sangi et al.. The hybrid approach is implemented in IBPSA.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium and the refrigerant model is implemented by complete the template IBPSA.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord . The fitting coefficients required in the template are saved in the package IBPSA.DataBase.Media.Refrigerants.R32 . </p>
</html>", revisions="<html>
<ul>
<li>December 10, 2018, by Stephan Goebel: First implementation (see <a href=\"https://github.com/RWTH-EBC/Aixlib/issues/665\">issue 665</a>)</li>
<li>July 16, 2019, by Christian Vering</li>
</ul>
</html>
"));
end R32_IIR_P1_70_T233_373_Formula;
