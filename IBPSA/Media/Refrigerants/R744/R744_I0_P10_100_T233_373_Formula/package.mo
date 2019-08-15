﻿within IBPSA.Media.Refrigerants.R744;
package R744_I0_P10_100_T233_373_Formula "Refrigerant model for R744 using   
    a hybrid approach with explicit formulas"

  /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
    */
  constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
    each chemicalFormula="CO2",
    each structureFormula="CO2",
    each casRegistryNumber="124-38-9",
    each iupacName="Carbon dioxide",
    each molarMass=0.0440098,
    each criticalTemperature=304.1282,
    each criticalPressure=7377300,
    each criticalMolarVolume=0.0021*0.044,
    each triplePointTemperature=216.55,
    each triplePointPressure=518000,
    each normalBoilingPoint=195.15,
    each meltingPoint=216.6,
    each acentricFactor=0.22394,
    each dipoleMoment=0,
    each hasCriticalData=true) "Thermodynamic constants for R744";
  //(sublimes)

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    IBPSA.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
  mediumName="R744",
  substanceNames={"R744"},
  singleState=false,
  SpecificEnthalpy(
    start=0,
    nominal=0,
    min=-3.958414680723884e+05,
    max=6.915853192761162e+04),
  Density(
    start=500,
    nominal=350,
    min=14.53,
    max=1139),
  AbsolutePressure(
    start=10e5,
    nominal=50e5,
    min=10e5,
    max=100e5),
  Temperature(
    start=268.37,
    nominal=333.15,
    min=233.15,
    max=373.15),
  smoothModel=true,
  onePhase=false,
  ThermoStates=Choices.IndependentVariables.phX,
  fluidConstants=refrigerantConstants);
  /*The vector substanceNames is mandatory, as the number of
      substances is determined based on its size. Here we assume
      a single-component medium.
      singleState is true if u and d do not depend on pressure, but only
      on a thermal variable (temperature or enthalpy). Otherwise, set it
      to false.
      For a single-substance medium, just set reducedX and fixedX to true,
      and there's no need to bother about medium compositions at all. Otherwise,
      set final reducedX = true if the medium model has nS-1 independent mass
      fraction, or reducedX = false if the medium model has nS independent
      mass fractions (nS = number of substances).
      If a mixture has a fixed composition set fixedX=true, otherwise false.
      The modifiers for reducedX and fixedX should normally be final
      since the other equations are based on these values.

      It is also possible to redeclare the min, max, and start attributes of
      Medium types, defined in the base class Interfaces.PartialMedium
      (the example of Temperature is shown here). Min and max attributes
      should be set in accordance to the limits of validity of the medium
      model, while the start attribute should be a reasonable default value
      for the initialization of nonlinear solver iterations.
    */
  /*Provide records thats contain the coefficients for the smooth transition
    between different regions.
  */
  redeclare record SmoothTransition "Record that contains ranges to calculate
    a smooth transition between different regions"
    SpecificEnthalpy T_ph=2.5;
    SpecificEntropy T_ps=2.5;
    AbsolutePressure d_pT=2.5;
    SpecificEnthalpy d_ph=2.5;
    Real d_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
    annotation (Documentation(info="<html>
<p>Record&nbsp;that&nbsp;contains&nbsp;ranges&nbsp;to&nbsp;calculate a&nbsp;smooth&nbsp;transition&nbsp;between&nbsp;different&nbsp;regions.</p>
</html>"));
  end SmoothTransition;
  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */

 redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"

protected
    Real idealAlpha0[8]={8.37304456,-3.70454304,2.5,1.99427042,
        0.62105248,0.41195293,1.04028922,0.08327678}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";
     Real idealPhi0[8]={0,0,0,3.15163,6.11190,6.77708,11.32384,27.08792}
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";

 algorithm
    f_Idg := log(delta) + idealAlpha0[1] + idealAlpha0[2]*tau + idealAlpha0[3]
      *log(tau) + sum(idealAlpha0[i]*log(1 - exp(-tau*idealPhi0[i])) for i in
          4:8);

    annotation (Documentation(info="<html>
<p>Dimensionless&nbsp;Helmholtz&nbsp;energy&nbsp;(Ideal&nbsp;gas&nbsp;contribution&nbsp;alpha_0).</p>
</html>"));
 end f_Idg;

  redeclare function extends f_Res
    "Dimensionless Helmholtz energy (Residual part alpha_r)"

protected
    Real[7,3] p=[0.388568232032E+00,0.000,1.00; 0.293854759427E+01,
        0.750,1.00; -0.558671885349E+01,1.000,1.00; -0.767531995925E+00,2.000,
        1.00; 0.317290055804E+00,0.750,2.00; 0.548033158978E+00,2.000,2.00; 0.122794112203E+00,
        0.750,3.00]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
    Real[27,4] b=[0.216589615432E+01,1.500,1.00,1; 0.158417351097E+01,
        1.500,2.00,1; -0.231327054055E+00,2.500,4.00,1; 0.581169164314E-01,0.000,
        5.00,1; -0.553691372054E+00,1.500,5.00,1; 0.489466159094E+00,2.000,5.00,
        1; -0.242757398435E-01,0.000,6.00,1; 0.624947905017E-01,1.000,6.00,1;
        -0.121758602252E+00,2.000,6.00,1; -0.370556852701E+00,3.000,1.00,2; -0.167758797004E-01,
        6.000,1.00,2; -0.119607366380E+00,3.000,4.00,2; -0.456193625088E-01,6.000,
        4.00,2; 0.356127892703E-01,8.000,4.00,2; -0.744277271321E-02,6.000,7.00,
        2; -0.173957049024E-02,0.000,8.00,2; -0.218101212895E-01,7.000,2.00,3;
        0.243321665592E-01,12.000,3.00,3; -0.374401334235E-01,16.000,3.00,3; 0.143387157569E+00,
        22.000,5.00,4; -0.134919690833E+00,24.000,5.00,4; -0.231512250535E-01,
        16.000,6.00,4; 0.123631254929E-01,24.000,7.00,4; 0.210583219729E-02,8.000,
        8.00,4; -0.339585190264E-03,2.000,10.00,4; 0.559936517716E-02,28.000,4.00,
        5; -0.303351180556E-03,14.000,8.00,6]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
    Real[5,9] g=[-0.213654886883E+03,1.000,2.00,2,2,-25.,-325.,
        1.16,1.; 0.266415691493E+05,0.000,2.00,2,2,-25.,-300.,1.19,1.; -0.240272122046E+05,
        1.000,2.00,2,2,-25.,-300.,1.19,1.; -0.283416034240E+03,3.000,3.00,2,2,
        -15.,-275.,1.25,1.; 0.212472844002E+03,3.000,3.00,2,2,-20.,-275.,1.22,
        1.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
    Real[3,12] a=[-0.666422765408E+00,0.000,1.00,2,2,0.875,0.300,
        0.70,10.0,275.,0.3,3.5; 0.726086323499E+00,0.000,1.00,2,2,0.925,0.300,
        0.70,10.0,275.,0.3,3.5; 0.550686686128E-01,0.000,1.00,2,2,0.875,0.300,
        0.70,12.5,275.,1.0,3.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

    Real[3] Psi={exp(-a[i, 9]*(delta - 1)^2 - a[i, 10]*(tau - 1)^2) for i in 1
        :3} "Psi";
    Real[3] Theta={(1 - tau) + a[i, 8]*((delta - 1)^2)^(0.5/a[i, 7]) for i in
            1:3} "Theta";
    Real[3] Dis={Theta[i]^2 + a[i, 11]*((delta - 1)^2)^a[i, 12] for i in 1:3}
      "Distance function";
    Real[3] Disb={Dis[i]^a[i, 6] for i in 1:3}
      "Distance function to the power of b";

  algorithm
    f_Res := sum(p[i, 1]*tau^p[i, 2]*delta^p[i, 3] for i in 1:7) + sum(b[i, 1]
      *tau^b[i, 2]*delta^b[i, 3]*exp(-delta^b[i, 4]) for i in 1:27) + sum(g[i,
      1]*tau^g[i, 2]*delta^g[i, 3]*exp(g[i, 6]*(delta - g[i, 9])^g[i, 4] + g[
      i, 7]*(tau - g[i, 8])^g[i, 5]) for i in 1:5) + sum(a[i, 1]*Disb[i]*
      delta*Psi[i] for i in 1:3);

    annotation (Documentation(info="<html>
<p>Dimensionless&nbsp;Helmholtz&nbsp;energy&nbsp;(Residual&nbsp;part&nbsp;alpha_r).</p>
</html>"));
  end f_Res;

  redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"

protected
     Real idealAlpha0[8]={8.37304456,-3.70454304,2.5,1.99427042,
        0.62105248,0.41195293,1.04028922,0.08327678}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";
     Real idealPhi0[8]={0,0,0,3.15163,6.11190,6.77708,11.32384,27.08792}
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";

  algorithm
    t_fIdg_t := tau*idealAlpha0[2] + idealAlpha0[3] + tau*sum(idealAlpha0[i]*
      idealPhi0[i]*((1 - exp(-tau*idealPhi0[i]))^(-1) - 1) for i in 4:8);

    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*(dalpha_0/dtau)_delta=const.</p>
</html>"));
  end t_fIdg_t;

  redeclare function extends tt_fIdg_tt
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
protected
     Real idealAlpha0[8]={8.37304456,-3.70454304,2.5,1.99427042,
        0.62105248,0.41195293,1.04028922,0.08327678}
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";
     Real idealPhi0[8]={0,0,0,3.15163,6.11190,6.77708,11.32384,27.08792}
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";

  algorithm
    tt_fIdg_tt := -idealAlpha0[3] - tau^2*sum(idealAlpha0[i]*idealPhi0[i]^2*
      exp(-tau*idealPhi0[i])*(1 - exp(-tau*idealPhi0[i]))^(-2) for i in 4:8);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*(ddalpha_0/(dtau*dtau))_delta=const.</p>
</html>"));
  end tt_fIdg_tt;

  redeclare function extends t_fRes_t
    "Short form for tau*(dalpha_r/dtau)_delta=const"

protected
     Real residualPolN[7]={0.38856823203161,0.29385475942740E+01,
        -0.55867188534934E+01,-0.76753199592477E+00,0.31729005580416E+00,0.54803315897737E+00,
        0.12279411220335E+00}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpN[27]={0.21658961543220E+01,0.15841735109724E+01,
        -0.23132705405503E+00,0.58116916431436E-01,-0.55369137205382E+00,0.48946615909422E+00,
        -0.24275739843501E-01,0.62494790501678E-01,-0.12175860225246E+00,-0.37055685270086E+00,
        -0.16775879700426E-01,-0.11960736637987E+00,-0.45619362508778E-01,0.35612789270346E-01,
        -0.74427727132052E-02,-0.17395704902432E-02,-0.21810121289527E-01,0.24332166559236E-01,
        -0.37440133423463E-01,0.14338715756878E+00,-0.13491969083286E+00,-0.23151225053480E-01,
        0.12363125492901E-01,0.21058321972940E-02,-0.33958519026368E-03,0.55993651771592E-02,
        -0.30335118055646E-03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualGbsN[5]={-0.21365488688320E+03,0.26641569149272E+05,
        -0.24027212204557E+05,-0.28341603423999E+03,0.21247284400179E+03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaN[3]={-0.66642276540751E+00,0.72608632349897E+00,
        0.550686686128E-01}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualPolD[7]={1,1,1,1,2,2,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualExpD[27]={1,2,4,5,5,5,6,6,6,1,1,4,4,4,7,8,2,
        3,3,5,5,6,7,8,10,4,8}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsD[5]={2,2,2,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaa[3]={3.5,3.5,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualPolT[7]={0,0.75,1,2,0.75,2,0.75}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpT[27]={1.5,1.5,2.5,0,1.5,2,0,1,2,3,6,3,6,8,
        6,0,7,12,16,22,24,16,24,8,2,28,14}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsT[5]={1,0,1,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNab[3]={0.875,0.925,0.875}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualExpC[27]={1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,
        3,3,4,4,4,4,4,4,5,6}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsAlpha[5]={25,25,25,15,20}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsBeta[5]={325,300,300,275,275}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaBeta[3]={0.3,0.3,0.3}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualGbsGamma[5]={1.16,1.19,1.19,1.25,1.22}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsEpsilon[5]={1,1,1,1,1}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaA[3]={0.7,0.7,0.7}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaB[3]={0.3,0.3,1}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaC[3]={10,10,12.5}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualNaD[3]={275,275,275}
      "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

    Real[3] Theta={(1 - tau) + residualNaA[i]*((delta - 1)^2)^(0.5/
        residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis={Theta[i]^2 + residualNaB[i]*((delta - 1)^2)^(residualNaa[i])
        for i in 1:3} "Dis";
    Real[3] Psi={exp(-residualNaC[i]*(delta - 1)^2 - residualNaD[i]*(tau - 1)^
        2) for i in 1:3} "Psi";
  algorithm
    t_fRes_t := sum(residualPolN[i]*residualPolT[i]*delta^(residualPolD[i])*
      tau^(residualPolT[i]) for i in 1:7) + sum(residualExpN[i]*residualExpT[
      i]*delta^(residualExpD[i])*tau^(residualExpT[i])*exp(-delta^(
      residualExpC[i])) for i in 1:27) + sum(residualGbsN[i]*delta^(
      residualGbsD[i])*tau^(residualGbsT[i])*exp(-residualGbsAlpha[i]*(delta -
      residualGbsEpsilon[i])^2 - residualGbsBeta[i]*(tau - residualGbsGamma[i])
      ^2)*(residualGbsT[i] - 2*tau*residualGbsBeta[i]*(tau - residualGbsGamma[
      i])) for i in 1:5) + sum(residualNaN[i]*delta*tau*((-2*Theta[i]*
      residualNab[i]*Dis[i]^(residualNab[i] - 1))*Psi[i] + Dis[i]^(
      residualNab[i])*(-2)*residualNaD[i]*(tau - 1)*Psi[i]) for i in 1:3);

    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*(dalpha_r/dtau)_delta=const.</p>
</html>"));
  end t_fRes_t;

  redeclare function extends tt_fRes_tt
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"

protected
     Real residualPolN[7]={0.38856823203161,0.29385475942740E+01,
        -0.55867188534934E+01,-0.76753199592477E+00,0.31729005580416E+00,0.54803315897737E+00,
        0.12279411220335E+00}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpN[27]={0.21658961543220E+01,0.15841735109724E+01,
        -0.23132705405503E+00,0.58116916431436E-01,-0.55369137205382E+00,0.48946615909422E+00,
        -0.24275739843501E-01,0.62494790501678E-01,-0.12175860225246E+00,-0.37055685270086E+00,
        -0.16775879700426E-01,-0.11960736637987E+00,-0.45619362508778E-01,0.35612789270346E-01,
        -0.74427727132052E-02,-0.17395704902432E-02,-0.21810121289527E-01,0.24332166559236E-01,
        -0.37440133423463E-01,0.14338715756878E+00,-0.13491969083286E+00,-0.23151225053480E-01,
        0.12363125492901E-01,0.21058321972940E-02,-0.33958519026368E-03,0.55993651771592E-02,
        -0.30335118055646E-03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualGbsN[5]={-0.21365488688320E+03,0.26641569149272E+05,
        -0.24027212204557E+05,-0.28341603423999E+03,0.21247284400179E+03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaN[3]={-0.66642276540751E+00,0.72608632349897E+00,
        0.550686686128E-01}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualPolD[7]={1,1,1,1,2,2,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualExpD[27]={1,2,4,5,5,5,6,6,6,1,1,4,4,4,7,8,2,
        3,3,5,5,6,7,8,10,4,8}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsD[5]={2,2,2,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaa[3]={3.5,3.5,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualPolT[7]={0,0.75,1,2,0.75,2,0.75}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpT[27]={1.5,1.5,2.5,0,1.5,2,0,1,2,3,6,3,6,8,
        6,0,7,12,16,22,24,16,24,8,2,28,14}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsT[5]={1,0,1,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNab[3]={0.875,0.925,0.875}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualExpC[27]={1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,
        3,3,4,4,4,4,4,4,5,6}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsAlpha[5]={25,25,25,15,20}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsBeta[5]={325,300,300,275,275}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaBeta[3]={0.3,0.3,0.3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualGbsGamma[5]={1.16,1.19,1.19,1.25,1.22}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsEpsilon[5]={1,1,1,1,1}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaA[3]={0.7,0.7,0.7}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaB[3]={0.3,0.3,1}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaC[3]={10,10,12.5}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualNaD[3]={275,275,275};
    Real[3] Theta={(1 - tau) + residualNaA[i]*((delta - 1)^2)^(0.5/
        residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis={Theta[i]^2 + residualNaB[i]*((delta - 1)^2)^(residualNaa[i])
        for i in 1:3} "Theta";
    Real[3] Psi={exp(-residualNaC[i]*(delta - 1)^2 - residualNaD[i]*(tau - 1)^
        2) for i in 1:3} "Psi";
    Real[3] Dis_tt_b={2*residualNab[i]*Dis[i]^(residualNab[i] - 1) + 4*Theta[
        i]^2*residualNab[i]*(residualNab[i] - 1)*Dis[i]^(residualNab[i] - 2)
        for i in 1:3} "(ddDis^b/dtdt)";
    Real[3] Dis_t_b={-2*Theta[i]*residualNab[i]*Dis[i]^(residualNab[i] - 1)
        for i in 1:3} "(dDis^b/dt)";
    Real[3] Psi_t={-2*residualNaD[i]*(tau - 1)*Psi[i] for i in 1:3}
      "(dPsi/dt)";
    Real[3] Psi_tt={(2*residualNaD[i]*(tau - 1)^2 - 1)*2*residualNaD[i]*Psi[i]
        for i in 1:3} "(ddPsi/dtdt)";

  algorithm
    tt_fRes_tt := sum(residualPolN[i]*residualPolT[i]*(residualPolT[i] - 1)*
      delta^(residualPolD[i])*tau^(residualPolT[i]) for i in 1:7) + sum(
      residualExpN[i]*residualExpT[i]*(residualExpT[i] - 1)*delta^(
      residualExpD[i])*tau^(residualExpT[i])*exp(-delta^(residualExpC[i]))
      for i in 1:27) + sum(residualGbsN[i]*delta^(residualGbsD[i])*tau^(
      residualGbsT[i] + 2)*exp(-residualGbsAlpha[i]*(delta -
      residualGbsEpsilon[i])^2 - residualGbsBeta[i]*(tau - residualGbsGamma[i])
      ^2)*((residualGbsT[i]/tau - 2*residualGbsBeta[i]*(tau -
      residualGbsGamma[i]))^2 - residualGbsT[i]/tau^2 - 2*residualGbsBeta[i])
      for i in 1:5) + sum(tau^2*residualNaN[i]*delta*(Dis_tt_b[i]*Psi[i] + 2*
      Dis_t_b[i]*Psi_t[i] + Dis[i]^residualNab[i]*Psi_tt[i]) for i in 1:3);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*(ddalpha_r/(dtau*dtau))_delta=const.</p>
</html>"));
  end tt_fRes_tt;

  redeclare function extends d_fRes_d
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"

protected
     Real[7,3] p=[0.388568232032E+00,0.000,1.00; 0.293854759427E+01,
        0.750,1.00; -0.558671885349E+01,1.000,1.00; -0.767531995925E+00,2.000,
        1.00; 0.317290055804E+00,0.750,2.00; 0.548033158978E+00,2.000,2.00; 0.122794112203E+00,
        0.750,3.00]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real[27,4] b=[0.216589615432E+01,1.500,1.00,1; 0.158417351097E+01,
        1.500,2.00,1; -0.231327054055E+00,2.500,4.00,1; 0.581169164314E-01,0.000,
        5.00,1; -0.553691372054E+00,1.500,5.00,1; 0.489466159094E+00,2.000,5.00,
        1; -0.242757398435E-01,0.000,6.00,1; 0.624947905017E-01,1.000,6.00,1;
        -0.121758602252E+00,2.000,6.00,1; -0.370556852701E+00,3.000,1.00,2; -0.167758797004E-01,
        6.000,1.00,2; -0.119607366380E+00,3.000,4.00,2; -0.456193625088E-01,6.000,
        4.00,2; 0.356127892703E-01,8.000,4.00,2; -0.744277271321E-02,6.000,7.00,
        2; -0.173957049024E-02,0.000,8.00,2; -0.218101212895E-01,7.000,2.00,3;
        0.243321665592E-01,12.000,3.00,3; -0.374401334235E-01,16.000,3.00,3; 0.143387157569E+00,
        22.000,5.00,4; -0.134919690833E+00,24.000,5.00,4; -0.231512250535E-01,
        16.000,6.00,4; 0.123631254929E-01,24.000,7.00,4; 0.210583219729E-02,8.000,
        8.00,4; -0.339585190264E-03,2.000,10.00,4; 0.559936517716E-02,28.000,4.00,
        5; -0.303351180556E-03,14.000,8.00,6]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real[5,9] g=[-0.213654886883E+03,1.000,2.00,2,2,-25.,-325.,
        1.16,1.; 0.266415691493E+05,0.000,2.00,2,2,-25.,-300.,1.19,1.; -0.240272122046E+05,
        1.000,2.00,2,2,-25.,-300.,1.19,1.; -0.283416034240E+03,3.000,3.00,2,2,
        -15.,-275.,1.25,1.; 0.212472844002E+03,3.000,3.00,2,2,-20.,-275.,1.22,
        1.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real[3,12] a=[-0.666422765408E+00,0.000,1.00,2,2,0.875,0.300,
        0.70,10.0,275.,0.3,3.5; 0.726086323499E+00,0.000,1.00,2,2,0.925,0.300,
        0.70,10.0,275.,0.3,3.5; 0.550686686128E-01,0.000,1.00,2,2,0.875,0.300,
        0.70,12.5,275.,1.0,3.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer nPoly=7
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer nBwr=27
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer nGauss=5
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer nNonAna=3
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

    Real[nNonAna] Psi={exp(-a[i, 9]*(delta - 1)^2 - a[i, 10]*(tau - 1)^2)
        for i in 1:nNonAna} "Psi";
    Real[nNonAna] Theta={(1 - tau) + a[i, 8]*((delta - 1)^2)^(0.5/a[i, 7])
        for i in 1:nNonAna} "Theta";
    Real[nNonAna] Dis={Theta[i]^2 + a[i, 11]*((delta - 1)^2)^a[i, 12] for i in
            1:nNonAna} "Distance function";
    Real[nNonAna] Disb={Dis[i]^a[i, 6] for i in 1:nNonAna}
      "Distance function to the power of b";

    Real[nNonAna] Psi_d={-a[i, 9]*(2*delta - 2)*Psi[i] for i in 1:nNonAna}
          "Psi";
    Real[nNonAna] Theta_d={if (delta - 1) <> 0 then (a[i, 8]*(2*delta - 2)*((
        delta - 1)^2)^(0.5/a[i, 7]))/(2*a[i, 7]*(delta - 1)^2) else 0 for i in
            1:nNonAna}
          "Theta";
    Real[nNonAna] Dis_d={if (delta - 1) <> 0 then (2*a[i, 11]*a[i, 12]*((
        delta - 1)^2)^a[i, 12])/(delta - 1) + 2*Theta[i]*Theta_d[i] else 0
        for i in 1:nNonAna}
          "Distance function";
    Real[nNonAna] Disb_d={if Dis[i] <> 0 then a[i, 6]*Dis[i]^(a[i, 6] - 1)*
        Dis_d[i] else 0 for i in 1:nNonAna}
          "Distance function to the power of b";

  algorithm
    d_fRes_d := sum(p[i, 1]*p[i, 3]*delta^(p[i, 3])*tau^p[i, 2] for i in 1:
      nPoly) + sum(delta*(b[i, 1]*exp(-delta^b[i, 4])*(delta^(b[i, 3] - 1)*
      tau^b[i, 2]*(b[i, 3] - b[i, 4]*delta^b[i, 4]))) for i in 1:nBwr) + sum(
      delta*(g[i, 1]*delta^g[i, 3]*tau^g[i, 2]*exp(g[i, 6]*(delta - g[i, 9])^2
       + g[i, 7]*(tau - g[i, 8])^2)*(g[i, 3]/delta + 2*g[i, 6]*(delta - g[i, 9])))
      for i in 1:nGauss) + sum(delta*(a[i, 1]*(delta*Disb[i]*Psi_d[i] + delta*
      Psi[i]*Disb_d[i] + Disb[i]*Psi[i])) for i in 1:nNonAna);

    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;delta*(dalpha_r/(ddelta))_tau=const.</p>
</html>"));
  end d_fRes_d;

  redeclare function extends dd_fRes_dd
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"

protected
     Real residualPolN[7]={0.38856823203161,0.29385475942740E+01,
        -0.55867188534934E+01,-0.76753199592477E+00,0.31729005580416E+00,0.54803315897737E+00,
        0.12279411220335E+00}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpN[27]={0.21658961543220E+01,0.15841735109724E+01,
        -0.23132705405503E+00,0.58116916431436E-01,-0.55369137205382E+00,0.48946615909422E+00,
        -0.24275739843501E-01,0.62494790501678E-01,-0.12175860225246E+00,-0.37055685270086E+00,
        -0.16775879700426E-01,-0.11960736637987E+00,-0.45619362508778E-01,0.35612789270346E-01,
        -0.74427727132052E-02,-0.17395704902432E-02,-0.21810121289527E-01,0.24332166559236E-01,
        -0.37440133423463E-01,0.14338715756878E+00,-0.13491969083286E+00,-0.23151225053480E-01,
        0.12363125492901E-01,0.21058321972940E-02,-0.33958519026368E-03,0.55993651771592E-02,
        -0.30335118055646E-03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualGbsN[5]={-0.21365488688320E+03,0.26641569149272E+05,
        -0.24027212204557E+05,-0.28341603423999E+03,0.21247284400179E+03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaN[3]={-0.66642276540751E+00,0.72608632349897E+00,
        0.550686686128E-01}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualPolD[7]={1,1,1,1,2,2,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualExpD[27]={1,2,4,5,5,5,6,6,6,1,1,4,4,4,7,8,2,
        3,3,5,5,6,7,8,10,4,8}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsD[5]={2,2,2,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaa[3]={3.5,3.5,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualPolT[7]={0,0.75,1,2,0.75,2,0.75}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpT[27]={1.5,1.5,2.5,0,1.5,2,0,1,2,3,6,3,6,8,
        6,0,7,12,16,22,24,16,24,8,2,28,14}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsT[5]={1,0,1,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNab[3]={0.875,0.925,0.875}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualExpC[27]={1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,
        3,3,4,4,4,4,4,4,5,6}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsAlpha[5]={25,25,25,15,20}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsBeta[5]={325,300,300,275,275}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaBeta[3]={0.3,0.3,0.3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualGbsGamma[5]={1.16,1.19,1.19,1.25,1.22}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsEpsilon[5]={1,1,1,1,1}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaA[3]={0.7,0.7,0.7}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaB[3]={0.3,0.3,1}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaC[3]={10,10,12.5}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualNaD[3]={275,275,275}
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
    Real[3] Theta={(1 - tau) + residualNaA[i]*((delta - 1)^2)^(0.5/
        residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis={Theta[i]^2 + residualNaB[i]*((delta - 1)^2)^(residualNaa[i])
        for i in 1:3} "Theta";
    Real[3] Psi={exp(-residualNaC[i]*(delta - 1)^2 - residualNaD[i]*(tau - 1)^
        2) for i in 1:3} "Psi";
    Real[3] Psi_d={-2*residualNaC[i]*(delta - 1)*Psi[i] for i in 1:3}
      "(dPsi/dd)";
    Real[3] Dis_d={(delta - 1)*(residualNaA[i]*Psi[i]*0.5*residualNaBeta[i]*((
        delta - 1)^2)^((0.5/residualNaBeta[i]) - 1) + 2*residualNaB[i]*
        residualNaa[i]*((delta - 1)^2)^(residualNaa[i] - 1)) for i in 1:3}
      "(dDis/dd)";
    Real[3] Dis_d_b={residualNab[i]*Dis[i]^(residualNab[i] - 1)*Dis_d[i] for
        i in 1:3} "(dDis^b/dd)";
    Real[3] Psi_dd={(2*residualNaC[i]*(delta - 1)^2 - 1)*2*residualNaC[i]*Psi[
        i] for i in 1:3} "(ddPsi/dddd)";
    Real[3] Dis_dd={(1/(delta - 1))*Dis_d[i] + (delta - 1)^2*(4*residualNaB[i]
        *residualNaa[i]*(residualNaa[i] - 1)*((delta - 1)^2)^(residualNaa[i] -
        2) + 2*residualNaA[i]^2*(1/residualNaBeta[i])^2*(((delta - 1)^2)^(1/(2
        *residualNaBeta[i]) - 1))^2 + residualNaA[i]*Theta[i]*4/
        residualNaBeta[i]*(1/(2*residualNaBeta[i]) - 1)*((delta - 1)^2)^(1/(2*
        residualNaBeta[i]) - 2)) for i in 1:3} "(ddDis/dddd)";
    Real[3] Dis_dd_b={residualNab[i]*(Dis[i]^(residualNab[i] - 1)*Dis_dd[i] +
        (residualNab[i] - 1)*Dis[i]^(residualNab[i] - 2)*Dis_d[i]^2) for i in
            1:3} "(ddDis^b/dddd)";

  algorithm
    dd_fRes_dd := sum(residualPolN[i]*residualPolD[i]*(residualPolD[i] - 1)*
      delta^(residualPolD[i])*tau^(residualPolT[i]) for i in 1:7) + sum(
      residualExpN[i]*exp(-delta^(residualExpC[i]))*(delta^(residualExpD[i])*
      tau^(residualExpT[i])*((residualExpD[i] - residualExpC[i]*delta^(
      residualExpC[i]))*(residualExpD[i] - 1 - residualExpC[i]*delta^(
      residualExpC[i])) - residualExpC[i]^2*delta^(residualExpC[i]))) for i in
          1:27) + sum(delta^2*residualGbsN[i]*tau^(residualGbsT[i])*exp(-
      residualGbsAlpha[i]*(delta - residualGbsEpsilon[i])^2 - residualGbsBeta[
      i]*(tau - residualGbsGamma[i])^2)*(-2*residualGbsAlpha[i]*delta^(
      residualGbsD[i]) + 4*residualGbsAlpha[i]^2*delta^(residualGbsD[i])*(
      delta - residualGbsEpsilon[i])^2 - 4*residualGbsD[i]*residualGbsAlpha[i]
      *delta^(residualGbsD[i] - 1)*(delta - residualGbsEpsilon[i]) +
      residualGbsD[i]*(residualGbsD[i] - 1)*delta^(residualGbsD[i] - 2)) for
      i in 1:5) + sum(delta^2*residualNaN[i]*(Dis[i]^(residualNab[i])*(2*
      Psi_d[i] + delta*Psi_dd[i]) + 2*Dis_d_b[i]*(Psi[i] + delta*Psi_d[i]) +
      Dis_dd_b[i]*delta*Psi[i]) for i in 1:3);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;delta*delta(ddalpha_r/(ddelta*delta))_tau=const.</p>
</html>"));
  end dd_fRes_dd;

  redeclare function extends td_fRes_td
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"

protected
     Real residualPolN[7]={0.38856823203161,0.29385475942740E+01,
        -0.55867188534934E+01,-0.76753199592477E+00,0.31729005580416E+00,0.54803315897737E+00,
        0.12279411220335E+00}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpN[27]={0.21658961543220E+01,0.15841735109724E+01,
        -0.23132705405503E+00,0.58116916431436E-01,-0.55369137205382E+00,0.48946615909422E+00,
        -0.24275739843501E-01,0.62494790501678E-01,-0.12175860225246E+00,-0.37055685270086E+00,
        -0.16775879700426E-01,-0.11960736637987E+00,-0.45619362508778E-01,0.35612789270346E-01,
        -0.74427727132052E-02,-0.17395704902432E-02,-0.21810121289527E-01,0.24332166559236E-01,
        -0.37440133423463E-01,0.14338715756878E+00,-0.13491969083286E+00,-0.23151225053480E-01,
        0.12363125492901E-01,0.21058321972940E-02,-0.33958519026368E-03,0.55993651771592E-02,
        -0.30335118055646E-03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualGbsN[5]={-0.21365488688320E+03,0.26641569149272E+05,
        -0.24027212204557E+05,-0.28341603423999E+03,0.21247284400179E+03}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaN[3]={-0.66642276540751E+00,0.72608632349897E+00,
        0.550686686128E-01}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualPolD[7]={1,1,1,1,2,2,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualExpD[27]={1,2,4,5,5,5,6,6,6,1,1,4,4,4,7,8,2,
        3,3,5,5,6,7,8,10,4,8}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsD[5]={2,2,2,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaa[3]={3.5,3.5,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualPolT[7]={0,0.75,1,2,0.75,2,0.75}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualExpT[27]={1.5,1.5,2.5,0,1.5,2,0,1,2,3,6,3,6,8,
        6,0,7,12,16,22,24,16,24,8,2,28,14}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Integer residualGbsT[5]={1,0,1,3,3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNab[3]={0.875,0.925,0.875}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualExpC[27]={1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,
        3,3,4,4,4,4,4,4,5,6}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsAlpha[5]={25,25,25,15,20}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsBeta[5]={325,300,300,275,275}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
     Real residualNaBeta[3]={0.3,0.3,0.3}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualGbsGamma[5]={1.16,1.19,1.19,1.25,1.22}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualGbsEpsilon[5]={1,1,1,1,1}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaA[3]={0.7,0.7,0.7}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaB[3]={0.3,0.3,1}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real residualNaC[3]={10,10,12.5}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Integer residualNaD[3]={275,275,275}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
    Real[3] Theta={(1 - tau) + residualNaA[i]*((delta - 1)^2)^(0.5/
        residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis={Theta[i]^2 + residualNaB[i]*((delta - 1)^2)^(residualNaa[i])
        for i in 1:3} "Theta";
    Real[3] Psi={exp(-residualNaC[i]*(delta - 1)^2 - residualNaD[i]*(tau - 1)^
        2) for i in 1:3} "Psi";
    Real[3] Psi_d={-2*residualNaC[i]*(delta - 1)*Psi[i] for i in 1:3}
      "(dPsi/dd)";
    Real[3] Dis_d={(delta - 1)*(residualNaA[i]*Psi[i]*0.5*residualNaBeta[i]*((
        delta - 1)^2)^((0.5/residualNaBeta[i]) - 1) + 2*residualNaB[i]*
        residualNaa[i]*((delta - 1)^2)^(residualNaa[i] - 1)) for i in 1:3}
      "(dDis/dd)";
    Real[3] Dis_d_b={residualNab[i]*Dis[i]^(residualNab[i] - 1)*Dis_d[i] for
        i in 1:3} "(dDis^b/dd)";
    Real[3] Dis_t_b={-2*Theta[i]*residualNab[i]*Dis[i]^(residualNab[i] - 1)
        for i in 1:3} "(dDis^b/dt)";
    Real[3] Psi_t={-2*residualNaD[i]*(tau - 1)*Psi[i] for i in 1:3}
      "(dPsi/dt)";
    Real[3] Psi_dt={4*residualNaC[i]*residualNaD[i]*(delta - 1)*(tau - 1)*Psi[
        i] for i in 1:3} "(ddPsi/dtdd)";
    Real[3] Dis_dt_b={2*residualNab[i]*(2/residualNaBeta[i])*Dis[i]^(
        residualNab[i] - 1)*(delta - 1)*((delta - 1)^2)^(0.5/(residualNaBeta[
        i]) - 1) - 2*Theta[i]*residualNab[i]*(residualNab[i] - 1)*Dis[i]^(
        residualNab[i] - 2)*Dis_d[i] for i in 1:3} "(ddDis^b/dddt)";

  algorithm
    td_fRes_td := sum(residualPolN[i]*residualPolD[i]*residualPolT[i]*delta^(
      residualPolD[i])*tau^(residualPolT[i]) for i in 1:7) + sum(residualExpN[
      i]*exp(-delta^(residualExpC[i]))*delta^(residualExpD[i])*residualExpT[i]
      *tau^(residualExpT[i])*(residualExpD[i] - residualExpC[i]*delta^(
      residualExpC[i])) for i in 1:27) + sum(delta*tau*residualGbsN[i]*delta^(
      residualGbsD[i])*tau^(residualGbsT[i])*exp(-residualGbsAlpha[i]*(delta -
      residualGbsEpsilon[i])^2 - residualGbsBeta[i]*(tau - residualGbsGamma[i])
      ^2)*((residualGbsD[i]/delta) - 2*residualGbsAlpha[i]*(delta -
      residualGbsEpsilon[i]))*((residualGbsT[i]/tau) - 2*residualGbsBeta[i]*(
      tau - residualGbsGamma[i])) for i in 1:5) + sum(tau*delta*residualNaN[i]
      *(Dis[i]^(residualNab[i])*(Psi_t[i] + delta*Psi_dt[i]) + delta*Dis_d_b[
      i]*Psi_t[i] + Dis_t_b[i]*(Psi[i] + delta*Psi_d[i]) + Dis_dt_b[i]*delta*
      Psi[i]) for i in 1:3);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*delta*(ddalpha_r/(dtau*ddelta)).</p>
</html>"));
  end td_fRes_td;

  redeclare function extends ttt_fIdg_ttt
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
protected
     Real idealAlpha0[8]={8.37304456,-3.70454304,2.5,1.99427042,
        0.62105248,0.41195293,1.04028922,0.08327678}
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";
     Real idealPhi0[8]={0,0,0,3.15163,6.11190,6.77708,11.32384,27.08792}
    "Constants for Dimensionsless Helmholtz energy (Residual part alpha_0)";

  algorithm
    ttt_fIdg_ttt := 2*idealAlpha0[3] + sum(tau^3*idealAlpha0[i]*idealPhi0[i]^3
      *exp(-idealPhi0[i]*tau)*(exp(idealPhi0[i]*tau) + 1)/((exp(-idealPhi0[i]*
      tau) - 1)^3) for i in 4:8);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const.</p>
</html>"));
  end ttt_fIdg_ttt;

  redeclare function extends ttt_fRes_ttt
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"

protected
     Real[7,3] p=[0.388568232032E+00,0.000,1.00; 0.293854759427E+01,
        0.750,1.00; -0.558671885349E+01,1.000,1.00; -0.767531995925E+00,2.000,
        1.00; 0.317290055804E+00,0.750,2.00; 0.548033158978E+00,2.000,2.00; 0.122794112203E+00,
        0.750,3.00]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[27,4] b=[0.216589615432E+01,1.500,1.00,1; 0.158417351097E+01,
        1.500,2.00,1; -0.231327054055E+00,2.500,4.00,1; 0.581169164314E-01,0.000,
        5.00,1; -0.553691372054E+00,1.500,5.00,1; 0.489466159094E+00,2.000,5.00,
        1; -0.242757398435E-01,0.000,6.00,1; 0.624947905017E-01,1.000,6.00,1;
        -0.121758602252E+00,2.000,6.00,1; -0.370556852701E+00,3.000,1.00,2; -0.167758797004E-01,
        6.000,1.00,2; -0.119607366380E+00,3.000,4.00,2; -0.456193625088E-01,6.000,
        4.00,2; 0.356127892703E-01,8.000,4.00,2; -0.744277271321E-02,6.000,7.00,
        2; -0.173957049024E-02,0.000,8.00,2; -0.218101212895E-01,7.000,2.00,3;
        0.243321665592E-01,12.000,3.00,3; -0.374401334235E-01,16.000,3.00,3; 0.143387157569E+00,
        22.000,5.00,4; -0.134919690833E+00,24.000,5.00,4; -0.231512250535E-01,
        16.000,6.00,4; 0.123631254929E-01,24.000,7.00,4; 0.210583219729E-02,8.000,
        8.00,4; -0.339585190264E-03,2.000,10.00,4; 0.559936517716E-02,28.000,4.00,
        5; -0.303351180556E-03,14.000,8.00,6]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[5,9] g=[-0.213654886883E+03,1.000,2.00,2,2,-25.,-325.,
        1.16,1.; 0.266415691493E+05,0.000,2.00,2,2,-25.,-300.,1.19,1.; -0.240272122046E+05,
        1.000,2.00,2,2,-25.,-300.,1.19,1.; -0.283416034240E+03,3.000,3.00,2,2,
        -15.,-275.,1.25,1.; 0.212472844002E+03,3.000,3.00,2,2,-20.,-275.,1.22,
        1.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

  algorithm
    ttt_fRes_ttt := sum(delta^p[i, 3]*p[i, 1]*p[i, 2]*tau^(p[i, 2])*(p[i, 2] -
      1)*(p[i, 2] - 2) for i in 1:7) + sum(b[i, 1]*b[i, 2]*delta^b[i, 3]*tau^(
      b[i, 2])*exp(-delta^b[i, 4])*(b[i, 2] - 1)*(b[i, 2] - 2) for i in 1:27) +
      sum(tau^3*(delta^g[i, 3]*g[i, 1]*tau^(g[i, 2] - 3)*exp(g[i, 6]*(delta -
      g[i, 9])^2 + g[i, 7]*(g[i, 8] - tau)^2)*(g[i, 2]^3 - 6*g[i, 2]^2*g[i, 7]
      *g[i, 8]*tau + 6*g[i, 2]^2*g[i, 7]*tau^2 - 3*g[i, 2]^2 + 12*g[i, 2]*g[i,
      7]^2*g[i, 8]^2*tau^2 - 24*g[i, 2]*g[i, 7]^2*g[i, 8]*tau^3 + 12*g[i, 2]*
      g[i, 7]^2*tau^4 + 6*g[i, 2]*g[i, 7]*g[i, 8]*tau + 2*g[i, 2] - 8*g[i, 7]^
      3*g[i, 8]^3*tau^3 + 24*g[i, 7]^3*g[i, 8]^2*tau^4 - 24*g[i, 7]^3*g[i, 8]*
      tau^5 + 8*g[i, 7]^3*tau^6 - 12*g[i, 7]^2*g[i, 8]*tau^3 + 12*g[i, 7]^2*
      tau^4)) for i in 1:5);

    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const.</p>
</html>"));
  end ttt_fRes_ttt;

  redeclare function extends ddd_fRes_ddd "Short form for delta*delta*delta*
    (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"

protected
     Real[7,3] p=[0.388568232032E+00,0.000,1.00; 0.293854759427E+01,
        0.750,1.00; -0.558671885349E+01,1.000,1.00; -0.767531995925E+00,2.000,
        1.00; 0.317290055804E+00,0.750,2.00; 0.548033158978E+00,2.000,2.00; 0.122794112203E+00,
        0.750,3.00]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[27,4] b=[0.216589615432E+01,1.500,1.00,1; 0.158417351097E+01,
        1.500,2.00,1; -0.231327054055E+00,2.500,4.00,1; 0.581169164314E-01,0.000,
        5.00,1; -0.553691372054E+00,1.500,5.00,1; 0.489466159094E+00,2.000,5.00,
        1; -0.242757398435E-01,0.000,6.00,1; 0.624947905017E-01,1.000,6.00,1;
        -0.121758602252E+00,2.000,6.00,1; -0.370556852701E+00,3.000,1.00,2; -0.167758797004E-01,
        6.000,1.00,2; -0.119607366380E+00,3.000,4.00,2; -0.456193625088E-01,6.000,
        4.00,2; 0.356127892703E-01,8.000,4.00,2; -0.744277271321E-02,6.000,7.00,
        2; -0.173957049024E-02,0.000,8.00,2; -0.218101212895E-01,7.000,2.00,3;
        0.243321665592E-01,12.000,3.00,3; -0.374401334235E-01,16.000,3.00,3; 0.143387157569E+00,
        22.000,5.00,4; -0.134919690833E+00,24.000,5.00,4; -0.231512250535E-01,
        16.000,6.00,4; 0.123631254929E-01,24.000,7.00,4; 0.210583219729E-02,8.000,
        8.00,4; -0.339585190264E-03,2.000,10.00,4; 0.559936517716E-02,28.000,4.00,
        5; -0.303351180556E-03,14.000,8.00,6]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[5,9] g=[-0.213654886883E+03,1.000,2.00,2,2,-25.,-325.,
        1.16,1.; 0.266415691493E+05,0.000,2.00,2,2,-25.,-300.,1.19,1.; -0.240272122046E+05,
        1.000,2.00,2,2,-25.,-300.,1.19,1.; -0.283416034240E+03,3.000,3.00,2,2,
        -15.,-275.,1.25,1.; 0.212472844002E+03,3.000,3.00,2,2,-20.,-275.,1.22,
        1.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

  algorithm
    ddd_fRes_ddd := sum(delta^(p[i, 3])*p[i, 1]*p[i, 3]*tau^p[i, 2]*(p[i, 3] -
      1)*(p[i, 3] - 2) for i in 1:7) + sum(-b[i, 1]*delta^(b[i, 3])*tau^b[i, 2]
      *exp(-delta^b[i, 4])*(b[i, 4]^3*delta^b[i, 4] - 3*b[i, 4]^2*delta^b[i, 4]
       - 2*b[i, 3] + 3*b[i, 4]^2*delta^(2*b[i, 4]) - 3*b[i, 4]^3*delta^(2*b[i,
      4]) + b[i, 4]^3*delta^(3*b[i, 4]) + 3*b[i, 3]^2 - b[i, 3]^3 + 2*b[i, 4]*
      delta^b[i, 4] - 3*b[i, 3]*b[i, 4]^2*delta^(2*b[i, 4]) - 6*b[i, 3]*b[i, 4]
      *delta^b[i, 4] + 3*b[i, 3]*b[i, 4]^2*delta^b[i, 4] + 3*b[i, 3]^2*b[i, 4]
      *delta^b[i, 4]) for i in 1:27) + sum(delta^(g[i, 3])*g[i, 1]*tau^g[i, 2]
      *exp(g[i, 6]*(delta - g[i, 9])^2 + g[i, 7]*(g[i, 8] - tau)^2)*(8*delta^6
      *g[i, 6]^3 - 24*delta^5*g[i, 6]^3*g[i, 9] + 12*delta^4*g[i, 3]*g[i, 6]^2
       + 24*delta^4*g[i, 6]^3*g[i, 9]^2 + 12*delta^4*g[i, 6]^2 - 24*delta^3*g[
      i, 3]*g[i, 6]^2*g[i, 9] - 8*delta^3*g[i, 6]^3*g[i, 9]^3 - 12*delta^3*g[
      i, 6]^2*g[i, 9] + 6*delta^2*g[i, 3]^2*g[i, 6] + 12*delta^2*g[i, 3]*g[i,
      6]^2*g[i, 9]^2 - 6*delta*g[i, 3]^2*g[i, 6]*g[i, 9] + 6*delta*g[i, 3]*g[
      i, 6]*g[i, 9] + g[i, 3]^3 - 3*g[i, 3]^2 + 2*g[i, 3]) for i in 1:5);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;delta*delta*delta*(dddalpha_r/(ddelta*ddelta*ddelta))_tau=const.</p>
</html>"));
  end ddd_fRes_ddd;

  redeclare function extends tdd_fRes_tdd
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"

protected
     Real[7,3] p=[0.388568232032E+00,0.000,1.00; 0.293854759427E+01,
        0.750,1.00; -0.558671885349E+01,1.000,1.00; -0.767531995925E+00,2.000,
        1.00; 0.317290055804E+00,0.750,2.00; 0.548033158978E+00,2.000,2.00; 0.122794112203E+00,
        0.750,3.00]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[27,4] b=[0.216589615432E+01,1.500,1.00,1; 0.158417351097E+01,
        1.500,2.00,1; -0.231327054055E+00,2.500,4.00,1; 0.581169164314E-01,0.000,
        5.00,1; -0.553691372054E+00,1.500,5.00,1; 0.489466159094E+00,2.000,5.00,
        1; -0.242757398435E-01,0.000,6.00,1; 0.624947905017E-01,1.000,6.00,1;
        -0.121758602252E+00,2.000,6.00,1; -0.370556852701E+00,3.000,1.00,2; -0.167758797004E-01,
        6.000,1.00,2; -0.119607366380E+00,3.000,4.00,2; -0.456193625088E-01,6.000,
        4.00,2; 0.356127892703E-01,8.000,4.00,2; -0.744277271321E-02,6.000,7.00,
        2; -0.173957049024E-02,0.000,8.00,2; -0.218101212895E-01,7.000,2.00,3;
        0.243321665592E-01,12.000,3.00,3; -0.374401334235E-01,16.000,3.00,3; 0.143387157569E+00,
        22.000,5.00,4; -0.134919690833E+00,24.000,5.00,4; -0.231512250535E-01,
        16.000,6.00,4; 0.123631254929E-01,24.000,7.00,4; 0.210583219729E-02,8.000,
        8.00,4; -0.339585190264E-03,2.000,10.00,4; 0.559936517716E-02,28.000,4.00,
        5; -0.303351180556E-03,14.000,8.00,6]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[5,9] g=[-0.213654886883E+03,1.000,2.00,2,2,-25.,-325.,
        1.16,1.; 0.266415691493E+05,0.000,2.00,2,2,-25.,-300.,1.19,1.; -0.240272122046E+05,
        1.000,2.00,2,2,-25.,-300.,1.19,1.; -0.283416034240E+03,3.000,3.00,2,2,
        -15.,-275.,1.25,1.; 0.212472844002E+03,3.000,3.00,2,2,-20.,-275.,1.22,
        1.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
  algorithm
    tdd_fRes_tdd := sum(delta^(p[i, 3])*p[i, 1]*p[i, 2]*p[i, 3]*tau^(p[i, 2])*
      (p[i, 3] - 1) for i in 1:7) + sum(-b[i, 1]*b[i, 2]*delta^(b[i, 3])*tau^(
      b[i, 2])*exp(-delta^b[i, 4])*(b[i, 3] + b[i, 4]^2*delta^b[i, 4] - b[i, 4]
      ^2*delta^(2*b[i, 4]) - b[i, 3]^2 - b[i, 4]*delta^b[i, 4] + 2*b[i, 3]*b[
      i, 4]*delta^b[i, 4]) for i in 1:27) + sum(delta^(g[i, 3])*g[i, 1]*tau^(
      g[i, 2])*exp(g[i, 6]*(delta - g[i, 9])^2 + g[i, 7]*(g[i, 8] - tau)^2)*(2
      *g[i, 7]*tau^2 - 2*g[i, 7]*g[i, 8]*tau + g[i, 2])*(4*delta^4*g[i, 6]^2 -
      8*delta^3*g[i, 6]^2*g[i, 9] + 4*delta^2*g[i, 3]*g[i, 6] + 4*delta^2*g[i,
      6]^2*g[i, 9]^2 + 2*delta^2*g[i, 6] - 4*delta*g[i, 3]*g[i, 6]*g[i, 9] +
      g[i, 3]^2 - g[i, 3]) for i in 1:5);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta)).</p>
</html>"));
  end tdd_fRes_tdd;

  redeclare function extends ttd_fRes_ttd
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"

protected
     Real[7,3] p=[0.388568232032E+00,0.000,1.00; 0.293854759427E+01,
        0.750,1.00; -0.558671885349E+01,1.000,1.00; -0.767531995925E+00,2.000,
        1.00; 0.317290055804E+00,0.750,2.00; 0.548033158978E+00,2.000,2.00; 0.122794112203E+00,
        0.750,3.00]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[27,4] b=[0.216589615432E+01,1.500,1.00,1; 0.158417351097E+01,
        1.500,2.00,1; -0.231327054055E+00,2.500,4.00,1; 0.581169164314E-01,0.000,
        5.00,1; -0.553691372054E+00,1.500,5.00,1; 0.489466159094E+00,2.000,5.00,
        1; -0.242757398435E-01,0.000,6.00,1; 0.624947905017E-01,1.000,6.00,1;
        -0.121758602252E+00,2.000,6.00,1; -0.370556852701E+00,3.000,1.00,2; -0.167758797004E-01,
        6.000,1.00,2; -0.119607366380E+00,3.000,4.00,2; -0.456193625088E-01,6.000,
        4.00,2; 0.356127892703E-01,8.000,4.00,2; -0.744277271321E-02,6.000,7.00,
        2; -0.173957049024E-02,0.000,8.00,2; -0.218101212895E-01,7.000,2.00,3;
        0.243321665592E-01,12.000,3.00,3; -0.374401334235E-01,16.000,3.00,3; 0.143387157569E+00,
        22.000,5.00,4; -0.134919690833E+00,24.000,5.00,4; -0.231512250535E-01,
        16.000,6.00,4; 0.123631254929E-01,24.000,7.00,4; 0.210583219729E-02,8.000,
        8.00,4; -0.339585190264E-03,2.000,10.00,4; 0.559936517716E-02,28.000,4.00,
        5; -0.303351180556E-03,14.000,8.00,6]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";

     Real[5,9] g=[-0.213654886883E+03,1.000,2.00,2,2,-25.,-325.,
        1.16,1.; 0.266415691493E+05,0.000,2.00,2,2,-25.,-300.,1.19,1.; -0.240272122046E+05,
        1.000,2.00,2,2,-25.,-300.,1.19,1.; -0.283416034240E+03,3.000,3.00,2,2,
        -15.,-275.,1.25,1.; 0.212472844002E+03,3.000,3.00,2,2,-20.,-275.,1.22,
        1.]
        "Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)";
  algorithm
    ttd_fRes_ttd := sum(delta^(p[i, 3])*p[i, 1]*p[i, 2]*p[i, 3]*tau^(p[i, 2])*
      (p[i, 2] - 1) for i in 1:7) + sum(b[i, 1]*b[i, 2]*delta^(b[i, 3])*tau^(
      b[i, 2])*exp(-delta^b[i, 4])*(b[i, 3] - b[i, 4]*delta^b[i, 4])*(b[i, 2] -
      1) for i in 1:27) + sum(delta^(g[i, 3])*g[i, 1]*tau^(g[i, 2])*exp(g[i, 6]
      *(delta - g[i, 9])^2 + g[i, 7]*(g[i, 8] - tau)^2)*(2*g[i, 6]*delta^2 - 2
      *g[i, 6]*g[i, 9]*delta + g[i, 3])*(g[i, 2]^2 - 4*g[i, 2]*g[i, 7]*g[i, 8]
      *tau + 4*g[i, 2]*g[i, 7]*tau^2 - g[i, 2] + 4*g[i, 7]^2*g[i, 8]^2*tau^2 -
      8*g[i, 7]^2*g[i, 8]*tau^3 + 4*g[i, 7]^2*tau^4 + 2*g[i, 7]*tau^2) for i in
          1:5);
    annotation (Documentation(info="<html>
<p>Short&nbsp;form&nbsp;for&nbsp;tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta)).</p>
</html>"));
  end ttd_fRes_ttd;
  /*Provide functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp).
*/
  redeclare function extends saturationPressure
    "Saturation pressure of refrigerant (Ancillary equation)"
protected
    Real OM = abs(1 - T/304.1282)
    "Regression term for inverse of the reduced temperature";

  algorithm
    if T > 304.1282 then
      //if T >= 304.1282 then
      p := 7377300;
    elseif T <= 216.55 then
      p := 518000;
    else
      p := 7377300*exp((304.1282/T)*((-10.8874701459618) .* (OM) .^ (1.02777903636517)
         + (-2.53014476472302) .* (OM) .^ (3.04857880618312) + (4.85976334934365)
         .* (OM) .^ (1.12780675832611)));
    end if;
    annotation (Documentation(info="<html>
<p>Saturation&nbsp;pressure&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end saturationPressure;

  redeclare function extends saturationTemperature
    "Saturation temperature of refrigerant (Ancillary equation)"
protected
    Real x "Regression term for centred and scaled pressure";
  algorithm
    if p >= 7377300 then
      T := 304.1282;
    elseif p <= 518000 then
      T := 216.55;
    else
      x := (p - 3445540.85867591) ./ 1822725.70538495;
      T := 268.600000000000 + 20.5103632342287 .* ((0.200822882160402) + (0.971452596229363)
         .* x .^ 1 + (-0.189436119639029) .* x .^ 2 + (0.0563877648731632) .*
        x .^ 3 + (-0.020714524035119) .* x .^ 4 + (0.00842457137711057) .* x .^
        5 + (-0.00369132626395774) .* x .^ 6 + (0.00114310539368957) .* x .^ 7
         + (-0.000400215031011729) .* x .^ 8 + (0.000675120780717472) .* x .^
        9 + (-0.000337725889546381) .* x .^ 10 + (-0.000123533921282085) .* x .^
        11 + (2.54822197136637e-05) .* x .^ 12 + (7.84687400408321e-05) .* x .^
        13 + (-5.67729643824132e-06) .* x .^ 14 + (-1.55649714573718e-05) .*
        x .^ 15 + (-4.6244025542171e-06) .* x .^ 16 + (5.77175283129492e-06) .*
        x .^ 17 + (-1.06584203525244e-06) .* x .^ 18);
    end if;
    annotation (Documentation(info="<html>
<p>Saturation&nbsp;temperature&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end saturationTemperature;

  redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
protected
    Real x "Regression term for centred and scaled saturation temperature";
  algorithm
    x := abs(1 - (sat.Tsat ./ 304.128200000000));
    dl := (478.968682010804 + (495.683257706123) .* x .^ (1/3) + (3543.67960624232)
       .* x .^ (2/3) + (-16584.0906529594) .* x .^ (3/3) + (39329.3130708854) .*
      x .^ (4/3) + (7445.88449470718) .* x .^ (5/3) + (-254232.892949454) .*
      x .^ (6/3) + (489081.275821062) .* x .^ (7/3) + (-51539.65263982) .* x .^
      (8/3) + (-948816.669406408) .* x .^ (9/3) + (1205337.05384885) .* x .^ (
      10/3) + (-479896.34391407) .* x .^ (11/3));

    annotation (Documentation(info="<html>
<p>Boiling&nbsp;curve&nbsp;specific&nbsp;density&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end bubbleDensity;

  redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
protected
    Real x "Regression term for centred and scaled saturation temperature";
  algorithm
    x := abs(1 - (sat.Tsat ./ 304.128200000000));
    dv := (462.48836810312 + (-610.315494915381) .* x .^ (1/3) + (-2823.72517117551)
       .* x .^ (2/3) + (16650.8365223046) .* x .^ (3/3) + (-49525.3789777128) .*
      x .^ (4/3) + (52571.1979874299) .* x .^ (5/3) + (74412.4761984176) .* x .^
      (6/3) + (-159900.265678589) .* x .^ (7/3) + (-119473.839067579) .* x .^
      (8/3) + (203760.826571182) .* x .^ (9/3) + (280692.836303772) .* x .^ (10
      /3) + (40256.3509590889) .* x .^ (11/3) + (-336116.042618752) .* x .^ (12
      /3) + (-570463.466661569) .* x .^ (13/3) + (-382871.321141713) .* x .^ (
      14/3) + (211234.622165815) .* x .^ (15/3) + (1120586.29646474) .* x .^ (
      16/3) + (2579594.67174698) .* x .^ (17/3) + (-856309.127058874) .* x .^
      (18/3) + (-1480616.80660559) .* x .^ (19/3) + (-1952678.05291741) .* x .^
      (20/3) + (-1966218.66650212) .* x .^ (21/3) + (-1411789.30657025) .* x .^
      (22/3) + (204923.572495633) .* x .^ (23/3) + (7059952.78039912) .* x .^
      (24/3));
    annotation (Documentation(info="<html>
<p>Dew&nbsp;curve&nbsp;specific&nbsp;density&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end dewDensity;

  redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x "Regression term for scaled saturation pressure";
    Real hl_IIR "Regression term for enthalpy";
  algorithm
    x := sat.psat ./ 7377300;
    if x >= 1 then
      x := 7.377284304216208e+06 ./ 7377300;
    end if;
    hl_IIR := 194327.316977888 .* exp((1./x) .* ((-0.769139700781037) .* (1 -
      x) .^ (0.722830089188778) + (0.460882432656297) .* (1 - x) .^ (-0.0152191856879518)
       + (0.22272419609671) .* (1 - x) .^ (3.00703720797531) + (0.141897620188616)
       .* (1 - x) .^ (50.6995880180848) + (0.0519530578466151) .* (1 - x) .^ (
      9.69794921193602)));
    hl := hl_IIR - 505.8414680723884e+03;
    annotation (Documentation(info="<html>
<p>Boiling&nbsp;curve&nbsp;specific&nbsp;enthalpy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x "Regression term for centred and scaled saturation pressure";
    Real hv_IIR "Regression term for enthalpy";
  algorithm
    x := abs(1 - sat.psat ./ 7377300);
    hv_IIR := (333020.719819463 + (87137.700738337) .* x .^ (1/3) + (128074.858979777)
       .* x .^ (2/3) + (15856.5163122911) .* x .^ (3/3) + (-825356.778644089) .*
      x .^ (4/3) + (1438792.78172267) .* x .^ (5/3) + (-133857.617994352) .*
      x .^ (6/3) + (-902180.017600717) .* x .^ (7/3) + (-812539.662160855) .*
      x .^ (8/3) + (685305.621672549) .* x .^ (9/3) + (689783.232726976) .* x .^
      (10/3) + (1027396.02629172) .* x .^ (11/3) + (-527730.424281767) .* x .^
      (12/3) + (-228779.518490116) .* x .^ (13/3) + (-842117.608572627) .* x .^
      (14/3) + (-1110850.40019966) .* x .^ (15/3) + (165936.295201719) .* x .^
      (16/3) + (-381364.657497601) .* x .^ (17/3) + (1065824.60373945) .* x .^
      (18/3) + (2128788.40782349) .* x .^ (19/3) + (577593.240467662) .* x .^
      (20/3) + (1278047.43879684) .* x .^ (21/3) + (-1222329.61991827) .* x .^
      (22/3) + (-3539546.26251493) .* x .^ (23/3) + (-3243680.19253677) .* x .^
      (24/3) + (-168642.585698017) .* x .^ (25/3) + (4210620.55406797) .* x .^
      (26/3) + (6052566.3465585) .* x .^ (27/3) + (-5526855.61850467) .* x .^
      (28/3));
    hv := hv_IIR - 505.8414680723884e+03;
    annotation (Documentation(info="<html>
<p>Dew&nbsp;curve&nbsp;specific&nbsp;enthalpy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x "Regression term for scaled saturation pressure";
    Real sl_IIR "Regression term for entropy";
  algorithm
    x := sat.psat ./ 7377300;
    if x >= 1 then
      x := 7.377284304216208e+06 ./ 7377300;
    end if;
    sl_IIR := 971.502865291826 .* exp((1./x) .* ((0.332362265133049) .* (1 -
      x) .^ (-0.0157738143026104) + (-0.53827965447008) .* (1 - x) .^ (0.710529444013852)
       + (0.0376198585567208) .* (1 - x) .^ (10.3660660062362) + (0.146071000768772)
       .* (1 - x) .^ (3.14098135792114)));
    sl := sl_IIR - 2.736808957627727E3;
    annotation (Documentation(info="<html>
<p>Boiling&nbsp;curve&nbsp;specific&nbsp;entropy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end bubbleEntropy;

  redeclare function extends dewEntropy
    "Dew curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x "Regression term for scaled saturation pressure";
    Real sv_IIR "Regression term for entropy";
  algorithm
    x := sat.psat ./ 7377300;
    if x >= 1 then
      x := 7.377284304216208e+06 ./ 7377300;
    end if;
    sv_IIR := 1852.51697191582 .* exp((1./x) .* ((-0.104686424493378) .* (1 -
      x) .^ (1.91767692218586) + (-0.231351021595994) .* (1 - x) .^ (-0.00970758719031325)
       + (0.350507795905541) .* (1 - x) .^ (0.456797862631896) + (-0.0111283896749802)
       .* (1 - x) .^ (8.11458177168435)));
    sv := sv_IIR - 2.736808957627727E3;
    annotation (Documentation(info="<html>
<p>Dew&nbsp;curve&nbsp;specific&nbsp;entropy&nbsp;of&nbsp;refrigerant&nbsp;(Ancillary&nbsp;equation).</p>
</html>"));
  end dewEntropy;
  /*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on
    the Helmholtz EoS.
*/
  redeclare replaceable function temperature_ph
    "Calculates temperature as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

protected
    SmoothTransition st "Smooth transition";
    SpecificEnthalpy dh=st.T_ph "Enthalpy gradient for a smooth transition";
    SpecificEnthalpy h_dew "Specific enthalpy at dew line";
    SpecificEnthalpy h_bubble "Specific enthalpy at bubble line";
    Real x1 "Regression term for centred and scaled pressure";
    Real y1 "Regression term for centred and scaled enthalpy";
    Real T1 "Regression term for the temperature";
    Real x2 "Regression term for centred and scaled pressure";
    Real y2 "Regression term for centred and scaled enthalpy";
    Real T2 "Regression term for the temperature";
    Real x3 "Regression term for centred and scaled pressure";
    Real y3 "Regression term for centred and scaled enthalpy";
    Real x_scr "Regression term for centred and scaled pressure";
    Real h_scr "Regression term for centred and scaled enthalpy";
    Real h_IIR "Regression term for the enthalpy";

  algorithm
    h_IIR := h + 505.8414680723884e+03;
    h_dew := dewEnthalpy(sat=setSat_p(p=p)) + 505.8414680723884e+03;
    h_bubble := bubbleEnthalpy(sat=setSat_p(p=p)) + 505.8414680723884e+03;
    x_scr := (p - 8689000)/757339.201855197;
    h_scr := 284773.077243989 + 8625.39176119581*((-0.26968374724995) + (-0.686038150275524)
       .* x_scr .^ 1 + (0.192604296642739) .* x_scr .^ 2 + (-0.142034551199029)
       .* x_scr .^ 3 + (-0.251951854627595) .* x_scr .^ 4 + (0.571531783870116)
       .* x_scr .^ 5 + (1.11768878334674) .* x_scr .^ 6 + (-1.8049309139747) .*
      x_scr .^ 7 + (-2.23879529796539) .* x_scr .^ 8 + (3.01031299057939) .*
      x_scr .^ 9 + (2.5191621143989) .* x_scr .^ 10 + (-2.94309246578317) .*
      x_scr .^ 11 + (-1.65772169673076) .* x_scr .^ 12 + (1.73431739837587) .*
      x_scr .^ 13 + (0.634400227016547) .* x_scr .^ 14 + (-0.606654645116181) .*
      x_scr .^ 15 + (-0.130769568314684) .* x_scr .^ 16 + (0.116029826531554) .*
      x_scr .^ 17 + (0.0112418969238134) .* x_scr .^ 18 + (-0.00935823150820951)
       .* x_scr .^ 19);
    if p < 7377300 then
      if h_IIR < h_bubble - dh then
        //SC
        x1 := (p - 6097764.94682380)/2585452.16490808;
        y1 := (h_IIR - 153365.801954585)/65673.4529788826;
        T := 250.119094022263 + 27.8301755311303*(0.0984832309267652 + (0.00389756589392757)
           .* x1 .^ 1 + (-0.00204989599989688) .* x1 .^ 2 + (1.1459222893016) .*
          y1 .^ 1 + (-0.070343134597504) .* y1 .^ 2 + (-0.0562686778415428) .*
          y1 .^ 3 + (0.00879891946010096) .* y1 .^ 4 + (0.0661811304570504) .*
          y1 .^ 5 + (-0.061982511612663) .* y1 .^ 6 + (-0.033103421121683) .*
          y1 .^ 7 + (0.0708210077537962) .* y1 .^ 8 + (-0.0381143725065783) .*
          y1 .^ 9 + (0.0081280075955589) .* y1 .^ 10 + (-0.000259913572675876)
           .* y1 .^ 11 + (-9.4154620197727e-05) .* y1 .^ 12 + (0.00114111755205254)
           .* y1 .^ 11.*x1 .^ 1 + (-0.00888450759269475) .* y1 .^ 10.*x1 .^ 1 +
          (-0.00208685488221609) .* y1 .^ 10.*x1 .^ 2 + (0.0278960316992357) .*
          y1 .^ 9.*x1 .^ 1 + (0.0112452499058972) .* y1 .^ 9.*x1 .^ 2 + (-0.0394466728409158)
           .* y1 .^ 8.*x1 .^ 1 + (-0.0196830066253284) .* y1 .^ 8.*x1 .^ 2 + (
          0.0147652303732295) .* y1 .^ 7.*x1 .^ 1 + (0.00266275029347203) .*
          y1 .^ 7.*x1 .^ 2 + (0.0181578424828338) .* y1 .^ 6.*x1 .^ 1 + (0.0298953638879228)
           .* y1 .^ 6.*x1 .^ 2 + (-0.0100341747271017) .* y1 .^ 5.*x1 .^ 1 + (
          -0.0270609660358611) .* y1 .^ 5.*x1 .^ 2 + (-0.00184545542883243) .*
          y1 .^ 4.*x1 .^ 1 + (-0.00807933082815375) .* y1 .^ 4.*x1 .^ 2 + (0.0056870535948233)
           .* y1 .^ 3.*x1 .^ 1 + (0.0148022794963983) .* y1 .^ 3.*x1 .^ 2 + (0.0134565003032703)
           .* y1 .^ 2.*x1 .^ 1 + (-0.00137103728603173) .* y1 .^ 2.*x1 .^ 2 +
          (0.0267940317659499) .* y1 .^ 1.*x1 .^ 1 + (-0.00459360679387857) .*
          y1 .^ 1.*x1 .^ 2);
      elseif h_IIR > h_dew + dh then
        //SH
        x2 := (p - 4742415.01272265)/2338206.42191283;
        y2 := (h_IIR - 485679.617572220)/49740.9272100767;
        T := 325.770836615015 + 45.8537417710473*(-0.0314099744127785 + (0.444339343950006)
           .* x2 .^ 1 + (-0.0427212246316783) .* x2 .^ 2 + (0.00274245407717317)
           .* x2 .^ 3 + (-0.00461920614601444) .* x2 .^ 4 + (-0.00176224711211021)
           .* x2 .^ 5 + (0.0132656103773099) .* x2 .^ 6 + (0.0105752427479749)
           .* x2 .^ 7 + (-0.0236760630222917) .* x2 .^ 8 + (-0.0168720406747937)
           .* x2 .^ 9 + (0.022713086930061) .* x2 .^ 10 + (0.0136176749179793)
           .* x2 .^ 11 + (-0.0112129614107892) .* x2 .^ 12 + (-0.00584990443240667)
           .* x2 .^ 13 + (0.0024211858418993) .* x2 .^ 14 + (0.00111300232860791)
           .* x2 .^ 15 + (-0.000117019357467813) .* x2 .^ 16 + (-3.20429644832931e-05)
           .* x2 .^ 17 + (0.837110380684298) .* y2 .^ 1 + (0.0965962834229711)
           .* y2 .^ 2 + (-0.0192570270037383) .* y2 .^ 3 + (0.0023662867214345)
           .* y2 .^ 4 + (-0.0145584955227089) .* y2 .^ 5 + (0.00746574972430255)
           .* y2 .^ 6 + (0.00627822681033568) .* y2 .^ 7 + (-0.00611036225015518)
           .* y2 .^ 8 + (0.000974745324996649) .* y2 .^ 9 + (0.00121343128586345)
           .* y2 .^ 10 + (-0.000915758584624007) .* y2 .^ 11 + (0.000206196177257671)
           .* y2 .^ 12 + (-0.00116092378210656) .* x2 .^ 16.*y2 .^ 1 + (-0.00233608836377314)
           .* x2 .^ 15.*y2 .^ 1 + (-0.00298788587186705) .* x2 .^ 15.*y2 .^ 2 +
          (0.00806608261834735) .* x2 .^ 14.*y2 .^ 1 + (-0.00133146318650065) .*
          x2 .^ 14.*y2 .^ 2 + (-0.00568837228275852) .* x2 .^ 14.*y2 .^ 3 + (0.0185469324339728)
           .* x2 .^ 13.*y2 .^ 1 + (0.0257266792132771) .* x2 .^ 13.*y2 .^ 2 +
          (-0.0145834870786212) .* x2 .^ 13.*y2 .^ 3 + (0.000208301251904854) .*
          x2 .^ 13.*y2 .^ 4 + (-0.016572873737851) .* x2 .^ 12.*y2 .^ 1 + (0.0131347761181012)
           .* x2 .^ 12.*y2 .^ 2 + (0.0180795600719053) .* x2 .^ 12.*y2 .^ 3 +
          (-0.00176016596448422) .* x2 .^ 12.*y2 .^ 4 + (0.00132457553597643) .*
          x2 .^ 12.*y2 .^ 5 + (-0.0490929689741519) .* x2 .^ 11.*y2 .^ 1 + (-0.0777820483376422)
           .* x2 .^ 11.*y2 .^ 2 + (0.061947474184922) .* x2 .^ 11.*y2 .^ 3 + (
          -0.00575732208592028) .* x2 .^ 11.*y2 .^ 4 + (0.0028993960220229) .*
          x2 .^ 11.*y2 .^ 5 + (5.20988964635086e-05) .* x2 .^ 11.*y2 .^ 6 + (0.0107088107250875)
           .* x2 .^ 10.*y2 .^ 1 + (-0.0318185996209532) .* x2 .^ 10.*y2 .^ 2 +
          (-0.0200555153646824) .* x2 .^ 10.*y2 .^ 3 + (0.00393767013775708) .*
          x2 .^ 10.*y2 .^ 4 + (-0.00363140821310015) .* x2 .^ 10.*y2 .^ 5 + (5.51773352489347e-05)
           .* x2 .^ 10.*y2 .^ 6 + (-6.00904996718504e-05) .* x2 .^ 10.*y2 .^ 7
           + (0.0564015649305773) .* x2 .^ 9.*y2 .^ 1 + (0.116211454372248) .*
          x2 .^ 9.*y2 .^ 2 + (-0.101410426217775) .* x2 .^ 9.*y2 .^ 3 + (0.017710987889682)
           .* x2 .^ 9.*y2 .^ 4 + (-0.00902205584903315) .* x2 .^ 9.*y2 .^ 5 +
          (-0.000510794675874849) .* x2 .^ 9.*y2 .^ 6 + (-0.000478722193048678)
           .* x2 .^ 9.*y2 .^ 7 + (0.000159484042662665) .* x2 .^ 9.*y2 .^ 8 +
          (0.00165601255693273) .* x2 .^ 8.*y2 .^ 1 + (0.0274642225330768) .*
          x2 .^ 8.*y2 .^ 2 + (0.01130644050621) .* x2 .^ 8.*y2 .^ 3 + (-0.00313612659494668)
           .* x2 .^ 8.*y2 .^ 4 + (0.00721355108320489) .* x2 .^ 8.*y2 .^ 5 + (
          0.00058296877219357) .* x2 .^ 8.*y2 .^ 6 + (-0.00279434195063629) .*
          x2 .^ 8.*y2 .^ 7 + (0.000565553736578638) .* x2 .^ 8.*y2 .^ 8 + (0.000185649477412129)
           .* x2 .^ 8.*y2 .^ 9 + (-0.0237743395012459) .* x2 .^ 7.*y2 .^ 1 + (
          -0.092672681497705) .* x2 .^ 7.*y2 .^ 2 + (0.0735659308834566) .*
          x2 .^ 7.*y2 .^ 3 + (-0.0217028472001825) .* x2 .^ 7.*y2 .^ 4 + (0.0127657381034912)
           .* x2 .^ 7.*y2 .^ 5 + (0.00369435121533928) .* x2 .^ 7.*y2 .^ 6 + (
          0.000707730613885534) .* x2 .^ 7.*y2 .^ 7 + (-0.0016528915219958) .*
          x2 .^ 7.*y2 .^ 8 + (-0.000301527813376657) .* x2 .^ 7.*y2 .^ 9 + (0.000353019886328202)
           .* x2 .^ 7.*y2 .^ 10 + (0.00200090742302188) .* x2 .^ 6.*y2 .^ 1 +
          (-0.0037941265333612) .* x2 .^ 6.*y2 .^ 2 + (-0.016367448986788) .*
          x2 .^ 6.*y2 .^ 3 + (0.00123472853074749) .* x2 .^ 6.*y2 .^ 4 + (-0.0043183338007886)
           .* x2 .^ 6.*y2 .^ 5 + (-0.000791594933192776) .* x2 .^ 6.*y2 .^ 6 +
          (0.00501342324148632) .* x2 .^ 6.*y2 .^ 7 + (-0.00173556260432616) .*
          x2 .^ 6.*y2 .^ 8 + (0.00114045574733164) .* x2 .^ 6.*y2 .^ 9 + (-0.00137226225896949)
           .* x2 .^ 6.*y2 .^ 10 + (0.00037952482473772) .* x2 .^ 6.*y2 .^ 11 +
          (-0.00518905655947852) .* x2 .^ 5.*y2 .^ 1 + (0.0387517167083185) .*
          x2 .^ 5.*y2 .^ 2 + (-0.0187682285365427) .* x2 .^ 5.*y2 .^ 3 + (0.00862362389750097)
           .* x2 .^ 5.*y2 .^ 4 + (-0.00556082895705846) .* x2 .^ 5.*y2 .^ 5 +
          (-0.00590910281966607) .* x2 .^ 5.*y2 .^ 6 + (-0.000963184828529965)
           .* x2 .^ 5.*y2 .^ 7 + (0.00273322888722273) .* x2 .^ 5.*y2 .^ 8 + (
          -0.00060825456966656) .* x2 .^ 5.*y2 .^ 9 + (0.000998864592646648) .*
          x2 .^ 5.*y2 .^ 10 + (-0.0007007543932457) .* x2 .^ 5.*y2 .^ 11 + (8.78046888345559e-05)
           .* x2 .^ 5.*y2 .^ 12 + (-0.0108537264305887) .* x2 .^ 4.*y2 .^ 1 +
          (-0.00513202654010906) .* x2 .^ 4.*y2 .^ 2 + (0.0338321480469933) .*
          x2 .^ 4.*y2 .^ 3 + (-0.00602505449699182) .* x2 .^ 4.*y2 .^ 4 + (-0.0168402572851103)
           .* x2 .^ 4.*y2 .^ 5 + (0.00852496642629238) .* x2 .^ 4.*y2 .^ 6 + (
          0.00224153137219189) .* x2 .^ 4.*y2 .^ 7 + (-0.00258555229224404) .*
          x2 .^ 4.*y2 .^ 8 + (-0.0027103244607679) .* x2 .^ 4.*y2 .^ 9 + (0.00366757356902761)
           .* x2 .^ 4.*y2 .^ 10 + (-0.00112358749371662) .* x2 .^ 4.*y2 .^ 11 +
          (4.95666855068354e-05) .* x2 .^ 4.*y2 .^ 12 + (0.000904216747891165)
           .* x2 .^ 3.*y2 .^ 1 + (-0.00609103745602836) .* x2 .^ 3.*y2 .^ 2 +
          (0.000415552432675825) .* x2 .^ 3.*y2 .^ 3 + (0.00891459432121028) .*
          x2 .^ 3.*y2 .^ 4 + (-0.00780964044175517) .* x2 .^ 3.*y2 .^ 5 + (-0.00593874435918624)
           .* x2 .^ 3.*y2 .^ 6 + (0.00201976666145268) .* x2 .^ 3.*y2 .^ 7 + (
          0.00980435683857743) .* x2 .^ 3.*y2 .^ 8 + (-0.000495536068926341) .*
          x2 .^ 3.*y2 .^ 9 + (-0.00869557457099743) .* x2 .^ 3.*y2 .^ 10 + (0.00495906324016952)
           .* x2 .^ 3.*y2 .^ 11 + (-0.000779545644811908) .* x2 .^ 3.*y2 .^ 12
           + (0.0415192402574172) .* x2 .^ 2.*y2 .^ 1 + (-0.012569648063452) .*
          x2 .^ 2.*y2 .^ 2 + (-0.0256234101385241) .* x2 .^ 2.*y2 .^ 3 + (0.00618076894733697)
           .* x2 .^ 2.*y2 .^ 4 + (0.0194955159561419) .* x2 .^ 2.*y2 .^ 5 + (6.09276078122551e-05)
           .* x2 .^ 2.*y2 .^ 6 + (-0.000433840684470545) .* x2 .^ 2.*y2 .^ 7 +
          (-0.0163567605252973) .* x2 .^ 2.*y2 .^ 8 + (0.00594081462490066) .*
          x2 .^ 2.*y2 .^ 9 + (0.00850206980246039) .* x2 .^ 2.*y2 .^ 10 + (-0.00643247113942379)
           .* x2 .^ 2.*y2 .^ 11 + (0.00125819952363372) .* x2 .^ 2.*y2 .^ 12 +
          (-0.140009686882945) .* x2 .^ 1.*y2 .^ 1 + (0.0204087567923358) .*
          x2 .^ 1.*y2 .^ 2 + (-0.00105100101152042) .* x2 .^ 1.*y2 .^ 3 + (-0.0079360915109717)
           .* x2 .^ 1.*y2 .^ 4 + (0.019159622527817) .* x2 .^ 1.*y2 .^ 5 + (-0.00825234493717037)
           .* x2 .^ 1.*y2 .^ 6 + (-0.0118328037065763) .* x2 .^ 1.*y2 .^ 7 + (
          0.015393829178147) .* x2 .^ 1.*y2 .^ 8 + (-0.00400769308934593) .*
          x2 .^ 1.*y2 .^ 9 + (-0.00469195213648668) .* x2 .^ 1.*y2 .^ 10 + (0.00381965826823239)
           .* x2 .^ 1.*y2 .^ 11 + (-0.000822508284396234) .* x2 .^ 1.*y2 .^ 12);
      elseif h_IIR < h_bubble then
        //SC
        x1 := (p - 6097764.94682380)/2585452.16490808;
        y1 := (h_IIR - 153365.801954585)/65673.4529788826;
        T1 := 250.119094022263 + 27.8301755311303*(0.0984832309267652 + (0.00389756589392757)
           .* x1 .^ 1 + (-0.00204989599989688) .* x1 .^ 2 + (1.1459222893016) .*
          y1 .^ 1 + (-0.070343134597504) .* y1 .^ 2 + (-0.0562686778415428) .*
          y1 .^ 3 + (0.00879891946010096) .* y1 .^ 4 + (0.0661811304570504) .*
          y1 .^ 5 + (-0.061982511612663) .* y1 .^ 6 + (-0.033103421121683) .*
          y1 .^ 7 + (0.0708210077537962) .* y1 .^ 8 + (-0.0381143725065783) .*
          y1 .^ 9 + (0.0081280075955589) .* y1 .^ 10 + (-0.000259913572675876)
           .* y1 .^ 11 + (-9.4154620197727e-05) .* y1 .^ 12 + (0.00114111755205254)
           .* y1 .^ 11.*x1 .^ 1 + (-0.00888450759269475) .* y1 .^ 10.*x1 .^ 1 +
          (-0.00208685488221609) .* y1 .^ 10.*x1 .^ 2 + (0.0278960316992357) .*
          y1 .^ 9.*x1 .^ 1 + (0.0112452499058972) .* y1 .^ 9.*x1 .^ 2 + (-0.0394466728409158)
           .* y1 .^ 8.*x1 .^ 1 + (-0.0196830066253284) .* y1 .^ 8.*x1 .^ 2 + (
          0.0147652303732295) .* y1 .^ 7.*x1 .^ 1 + (0.00266275029347203) .*
          y1 .^ 7.*x1 .^ 2 + (0.0181578424828338) .* y1 .^ 6.*x1 .^ 1 + (0.0298953638879228)
           .* y1 .^ 6.*x1 .^ 2 + (-0.0100341747271017) .* y1 .^ 5.*x1 .^ 1 + (
          -0.0270609660358611) .* y1 .^ 5.*x1 .^ 2 + (-0.00184545542883243) .*
          y1 .^ 4.*x1 .^ 1 + (-0.00807933082815375) .* y1 .^ 4.*x1 .^ 2 + (0.0056870535948233)
           .* y1 .^ 3.*x1 .^ 1 + (0.0148022794963983) .* y1 .^ 3.*x1 .^ 2 + (0.0134565003032703)
           .* y1 .^ 2.*x1 .^ 1 + (-0.00137103728603173) .* y1 .^ 2.*x1 .^ 2 +
          (0.0267940317659499) .* y1 .^ 1.*x1 .^ 1 + (-0.00459360679387857) .*
          y1 .^ 1.*x1 .^ 2);
        T := saturationTemperature(p)*(1 - (h_bubble - h_IIR)/dh) + T1*(
          h_bubble - h_IIR)/dh;
      elseif h_IIR > h_dew then
        //SH
        x2 := (p - 4742415.01272265)/2338206.42191283;
        y2 := (h_IIR - 485679.617572220)/49740.9272100767;
        T2 := 325.770836615015 + 45.8537417710473*(-0.0314099744127785 + (0.444339343950006)
           .* x2 .^ 1 + (-0.0427212246316783) .* x2 .^ 2 + (0.00274245407717317)
           .* x2 .^ 3 + (-0.00461920614601444) .* x2 .^ 4 + (-0.00176224711211021)
           .* x2 .^ 5 + (0.0132656103773099) .* x2 .^ 6 + (0.0105752427479749)
           .* x2 .^ 7 + (-0.0236760630222917) .* x2 .^ 8 + (-0.0168720406747937)
           .* x2 .^ 9 + (0.022713086930061) .* x2 .^ 10 + (0.0136176749179793)
           .* x2 .^ 11 + (-0.0112129614107892) .* x2 .^ 12 + (-0.00584990443240667)
           .* x2 .^ 13 + (0.0024211858418993) .* x2 .^ 14 + (0.00111300232860791)
           .* x2 .^ 15 + (-0.000117019357467813) .* x2 .^ 16 + (-3.20429644832931e-05)
           .* x2 .^ 17 + (0.837110380684298) .* y2 .^ 1 + (0.0965962834229711)
           .* y2 .^ 2 + (-0.0192570270037383) .* y2 .^ 3 + (0.0023662867214345)
           .* y2 .^ 4 + (-0.0145584955227089) .* y2 .^ 5 + (0.00746574972430255)
           .* y2 .^ 6 + (0.00627822681033568) .* y2 .^ 7 + (-0.00611036225015518)
           .* y2 .^ 8 + (0.000974745324996649) .* y2 .^ 9 + (0.00121343128586345)
           .* y2 .^ 10 + (-0.000915758584624007) .* y2 .^ 11 + (0.000206196177257671)
           .* y2 .^ 12 + (-0.00116092378210656) .* x2 .^ 16.*y2 .^ 1 + (-0.00233608836377314)
           .* x2 .^ 15.*y2 .^ 1 + (-0.00298788587186705) .* x2 .^ 15.*y2 .^ 2 +
          (0.00806608261834735) .* x2 .^ 14.*y2 .^ 1 + (-0.00133146318650065) .*
          x2 .^ 14.*y2 .^ 2 + (-0.00568837228275852) .* x2 .^ 14.*y2 .^ 3 + (0.0185469324339728)
           .* x2 .^ 13.*y2 .^ 1 + (0.0257266792132771) .* x2 .^ 13.*y2 .^ 2 +
          (-0.0145834870786212) .* x2 .^ 13.*y2 .^ 3 + (0.000208301251904854) .*
          x2 .^ 13.*y2 .^ 4 + (-0.016572873737851) .* x2 .^ 12.*y2 .^ 1 + (0.0131347761181012)
           .* x2 .^ 12.*y2 .^ 2 + (0.0180795600719053) .* x2 .^ 12.*y2 .^ 3 +
          (-0.00176016596448422) .* x2 .^ 12.*y2 .^ 4 + (0.00132457553597643) .*
          x2 .^ 12.*y2 .^ 5 + (-0.0490929689741519) .* x2 .^ 11.*y2 .^ 1 + (-0.0777820483376422)
           .* x2 .^ 11.*y2 .^ 2 + (0.061947474184922) .* x2 .^ 11.*y2 .^ 3 + (
          -0.00575732208592028) .* x2 .^ 11.*y2 .^ 4 + (0.0028993960220229) .*
          x2 .^ 11.*y2 .^ 5 + (5.20988964635086e-05) .* x2 .^ 11.*y2 .^ 6 + (0.0107088107250875)
           .* x2 .^ 10.*y2 .^ 1 + (-0.0318185996209532) .* x2 .^ 10.*y2 .^ 2 +
          (-0.0200555153646824) .* x2 .^ 10.*y2 .^ 3 + (0.00393767013775708) .*
          x2 .^ 10.*y2 .^ 4 + (-0.00363140821310015) .* x2 .^ 10.*y2 .^ 5 + (5.51773352489347e-05)
           .* x2 .^ 10.*y2 .^ 6 + (-6.00904996718504e-05) .* x2 .^ 10.*y2 .^ 7
           + (0.0564015649305773) .* x2 .^ 9.*y2 .^ 1 + (0.116211454372248) .*
          x2 .^ 9.*y2 .^ 2 + (-0.101410426217775) .* x2 .^ 9.*y2 .^ 3 + (0.017710987889682)
           .* x2 .^ 9.*y2 .^ 4 + (-0.00902205584903315) .* x2 .^ 9.*y2 .^ 5 +
          (-0.000510794675874849) .* x2 .^ 9.*y2 .^ 6 + (-0.000478722193048678)
           .* x2 .^ 9.*y2 .^ 7 + (0.000159484042662665) .* x2 .^ 9.*y2 .^ 8 +
          (0.00165601255693273) .* x2 .^ 8.*y2 .^ 1 + (0.0274642225330768) .*
          x2 .^ 8.*y2 .^ 2 + (0.01130644050621) .* x2 .^ 8.*y2 .^ 3 + (-0.00313612659494668)
           .* x2 .^ 8.*y2 .^ 4 + (0.00721355108320489) .* x2 .^ 8.*y2 .^ 5 + (
          0.00058296877219357) .* x2 .^ 8.*y2 .^ 6 + (-0.00279434195063629) .*
          x2 .^ 8.*y2 .^ 7 + (0.000565553736578638) .* x2 .^ 8.*y2 .^ 8 + (0.000185649477412129)
           .* x2 .^ 8.*y2 .^ 9 + (-0.0237743395012459) .* x2 .^ 7.*y2 .^ 1 + (
          -0.092672681497705) .* x2 .^ 7.*y2 .^ 2 + (0.0735659308834566) .*
          x2 .^ 7.*y2 .^ 3 + (-0.0217028472001825) .* x2 .^ 7.*y2 .^ 4 + (0.0127657381034912)
           .* x2 .^ 7.*y2 .^ 5 + (0.00369435121533928) .* x2 .^ 7.*y2 .^ 6 + (
          0.000707730613885534) .* x2 .^ 7.*y2 .^ 7 + (-0.0016528915219958) .*
          x2 .^ 7.*y2 .^ 8 + (-0.000301527813376657) .* x2 .^ 7.*y2 .^ 9 + (0.000353019886328202)
           .* x2 .^ 7.*y2 .^ 10 + (0.00200090742302188) .* x2 .^ 6.*y2 .^ 1 +
          (-0.0037941265333612) .* x2 .^ 6.*y2 .^ 2 + (-0.016367448986788) .*
          x2 .^ 6.*y2 .^ 3 + (0.00123472853074749) .* x2 .^ 6.*y2 .^ 4 + (-0.0043183338007886)
           .* x2 .^ 6.*y2 .^ 5 + (-0.000791594933192776) .* x2 .^ 6.*y2 .^ 6 +
          (0.00501342324148632) .* x2 .^ 6.*y2 .^ 7 + (-0.00173556260432616) .*
          x2 .^ 6.*y2 .^ 8 + (0.00114045574733164) .* x2 .^ 6.*y2 .^ 9 + (-0.00137226225896949)
           .* x2 .^ 6.*y2 .^ 10 + (0.00037952482473772) .* x2 .^ 6.*y2 .^ 11 +
          (-0.00518905655947852) .* x2 .^ 5.*y2 .^ 1 + (0.0387517167083185) .*
          x2 .^ 5.*y2 .^ 2 + (-0.0187682285365427) .* x2 .^ 5.*y2 .^ 3 + (0.00862362389750097)
           .* x2 .^ 5.*y2 .^ 4 + (-0.00556082895705846) .* x2 .^ 5.*y2 .^ 5 +
          (-0.00590910281966607) .* x2 .^ 5.*y2 .^ 6 + (-0.000963184828529965)
           .* x2 .^ 5.*y2 .^ 7 + (0.00273322888722273) .* x2 .^ 5.*y2 .^ 8 + (
          -0.00060825456966656) .* x2 .^ 5.*y2 .^ 9 + (0.000998864592646648) .*
          x2 .^ 5.*y2 .^ 10 + (-0.0007007543932457) .* x2 .^ 5.*y2 .^ 11 + (8.78046888345559e-05)
           .* x2 .^ 5.*y2 .^ 12 + (-0.0108537264305887) .* x2 .^ 4.*y2 .^ 1 +
          (-0.00513202654010906) .* x2 .^ 4.*y2 .^ 2 + (0.0338321480469933) .*
          x2 .^ 4.*y2 .^ 3 + (-0.00602505449699182) .* x2 .^ 4.*y2 .^ 4 + (-0.0168402572851103)
           .* x2 .^ 4.*y2 .^ 5 + (0.00852496642629238) .* x2 .^ 4.*y2 .^ 6 + (
          0.00224153137219189) .* x2 .^ 4.*y2 .^ 7 + (-0.00258555229224404) .*
          x2 .^ 4.*y2 .^ 8 + (-0.0027103244607679) .* x2 .^ 4.*y2 .^ 9 + (0.00366757356902761)
           .* x2 .^ 4.*y2 .^ 10 + (-0.00112358749371662) .* x2 .^ 4.*y2 .^ 11 +
          (4.95666855068354e-05) .* x2 .^ 4.*y2 .^ 12 + (0.000904216747891165)
           .* x2 .^ 3.*y2 .^ 1 + (-0.00609103745602836) .* x2 .^ 3.*y2 .^ 2 +
          (0.000415552432675825) .* x2 .^ 3.*y2 .^ 3 + (0.00891459432121028) .*
          x2 .^ 3.*y2 .^ 4 + (-0.00780964044175517) .* x2 .^ 3.*y2 .^ 5 + (-0.00593874435918624)
           .* x2 .^ 3.*y2 .^ 6 + (0.00201976666145268) .* x2 .^ 3.*y2 .^ 7 + (
          0.00980435683857743) .* x2 .^ 3.*y2 .^ 8 + (-0.000495536068926341) .*
          x2 .^ 3.*y2 .^ 9 + (-0.00869557457099743) .* x2 .^ 3.*y2 .^ 10 + (0.00495906324016952)
           .* x2 .^ 3.*y2 .^ 11 + (-0.000779545644811908) .* x2 .^ 3.*y2 .^ 12
           + (0.0415192402574172) .* x2 .^ 2.*y2 .^ 1 + (-0.012569648063452) .*
          x2 .^ 2.*y2 .^ 2 + (-0.0256234101385241) .* x2 .^ 2.*y2 .^ 3 + (0.00618076894733697)
           .* x2 .^ 2.*y2 .^ 4 + (0.0194955159561419) .* x2 .^ 2.*y2 .^ 5 + (6.09276078122551e-05)
           .* x2 .^ 2.*y2 .^ 6 + (-0.000433840684470545) .* x2 .^ 2.*y2 .^ 7 +
          (-0.0163567605252973) .* x2 .^ 2.*y2 .^ 8 + (0.00594081462490066) .*
          x2 .^ 2.*y2 .^ 9 + (0.00850206980246039) .* x2 .^ 2.*y2 .^ 10 + (-0.00643247113942379)
           .* x2 .^ 2.*y2 .^ 11 + (0.00125819952363372) .* x2 .^ 2.*y2 .^ 12 +
          (-0.140009686882945) .* x2 .^ 1.*y2 .^ 1 + (0.0204087567923358) .*
          x2 .^ 1.*y2 .^ 2 + (-0.00105100101152042) .* x2 .^ 1.*y2 .^ 3 + (-0.0079360915109717)
           .* x2 .^ 1.*y2 .^ 4 + (0.019159622527817) .* x2 .^ 1.*y2 .^ 5 + (-0.00825234493717037)
           .* x2 .^ 1.*y2 .^ 6 + (-0.0118328037065763) .* x2 .^ 1.*y2 .^ 7 + (
          0.015393829178147) .* x2 .^ 1.*y2 .^ 8 + (-0.00400769308934593) .*
          x2 .^ 1.*y2 .^ 9 + (-0.00469195213648668) .* x2 .^ 1.*y2 .^ 10 + (0.00381965826823239)
           .* x2 .^ 1.*y2 .^ 11 + (-0.000822508284396234) .* x2 .^ 1.*y2 .^ 12);
        T := saturationTemperature(p)*(1 - (h_IIR - h_dew)/dh) + T2*(h_IIR -
          h_dew)/dh;
      else
        T := saturationTemperature(p);
      end if;
    elseif h_IIR < h_scr then
      //SC
      x1 := (p - 6097764.94682380)/2585452.16490808;
      y1 := (h_IIR - 153365.801954585)/65673.4529788826;
      T := 250.119094022263 + 27.8301755311303*(0.0984832309267652 + (0.00389756589392757)
         .* x1 .^ 1 + (-0.00204989599989688) .* x1 .^ 2 + (1.1459222893016) .*
        y1 .^ 1 + (-0.070343134597504) .* y1 .^ 2 + (-0.0562686778415428) .*
        y1 .^ 3 + (0.00879891946010096) .* y1 .^ 4 + (0.0661811304570504) .*
        y1 .^ 5 + (-0.061982511612663) .* y1 .^ 6 + (-0.033103421121683) .*
        y1 .^ 7 + (0.0708210077537962) .* y1 .^ 8 + (-0.0381143725065783) .*
        y1 .^ 9 + (0.0081280075955589) .* y1 .^ 10 + (-0.000259913572675876) .*
        y1 .^ 11 + (-9.4154620197727e-05) .* y1 .^ 12 + (0.00114111755205254) .*
        y1 .^ 11.*x1 .^ 1 + (-0.00888450759269475) .* y1 .^ 10.*x1 .^ 1 + (-0.00208685488221609)
         .* y1 .^ 10.*x1 .^ 2 + (0.0278960316992357) .* y1 .^ 9.*x1 .^ 1 + (0.0112452499058972)
         .* y1 .^ 9.*x1 .^ 2 + (-0.0394466728409158) .* y1 .^ 8.*x1 .^ 1 + (-0.0196830066253284)
         .* y1 .^ 8.*x1 .^ 2 + (0.0147652303732295) .* y1 .^ 7.*x1 .^ 1 + (0.00266275029347203)
         .* y1 .^ 7.*x1 .^ 2 + (0.0181578424828338) .* y1 .^ 6.*x1 .^ 1 + (0.0298953638879228)
         .* y1 .^ 6.*x1 .^ 2 + (-0.0100341747271017) .* y1 .^ 5.*x1 .^ 1 + (-0.0270609660358611)
         .* y1 .^ 5.*x1 .^ 2 + (-0.00184545542883243) .* y1 .^ 4.*x1 .^ 1 + (-0.00807933082815375)
         .* y1 .^ 4.*x1 .^ 2 + (0.0056870535948233) .* y1 .^ 3.*x1 .^ 1 + (0.0148022794963983)
         .* y1 .^ 3.*x1 .^ 2 + (0.0134565003032703) .* y1 .^ 2.*x1 .^ 1 + (-0.00137103728603173)
         .* y1 .^ 2.*x1 .^ 2 + (0.0267940317659499) .* y1 .^ 1.*x1 .^ 1 + (-0.00459360679387857)
         .* y1 .^ 1.*x1 .^ 2);
    elseif h_IIR > h_scr then
      //SCr
      x3 := (p - 8303715.32739191)/897740.208497623;
      y3 := (h_IIR - 411640.117478088)/71613.3314216309;
      T := 327.197781935892 + 20.1689191976422*(-0.481681032173056 + (0.340880756284145)
         .* x3 .^ 1 + (-0.0189052771014906) .* x3 .^ 2 + (0.898533079116176) .*
        y3 .^ 1 + (0.6990529125834) .* y3 .^ 2 + (0.104098429636939) .* y3 .^
        3 + (-0.121154138164734) .* y3 .^ 4 + (0.0024522493687735) .* y3 .^ 5 +
        (0.0240911243159528) .* y3 .^ 6 + (-0.0113436636739131) .* y3 .^ 7 + (
        -0.00337608018566535) .* y3 .^ 8 + (0.00582909108085912) .* y3 .^ 9 +
        (-6.40449860099882e-06) .* y3 .^ 10 + (-0.000939036255501953) .* y3 .^
        11 + (-0.00148696936311922) .* y3 .^ 10.*x3 .^ 1 + (-0.00179434912959592)
         .* y3 .^ 9.*x3 .^ 1 + (3.08343385541494e-05) .* y3 .^ 9.*x3 .^ 2 + (0.00999079694572103)
         .* y3 .^ 8.*x3 .^ 1 + (-0.000857644807702166) .* y3 .^ 8.*x3 .^ 2 + (
        0.00864417561353578) .* y3 .^ 7.*x3 .^ 1 + (-0.00118437955830187) .*
        y3 .^ 7.*x3 .^ 2 + (-0.0281216242373478) .* y3 .^ 6.*x3 .^ 1 + (0.00474753441451223)
         .* y3 .^ 6.*x3 .^ 2 + (-0.0138264060178187) .* y3 .^ 5.*x3 .^ 1 + (0.00355971143102101)
         .* y3 .^ 5.*x3 .^ 2 + (0.0472332916594976) .* y3 .^ 4.*x3 .^ 1 + (-0.00941298519624451)
         .* y3 .^ 4.*x3 .^ 2 + (0.0133946337552411) .* y3 .^ 3.*x3 .^ 1 + (-0.00414526384253996)
         .* y3 .^ 3.*x3 .^ 2 + (-0.104950210334764) .* y3 .^ 2.*x3 .^ 1 + (0.0106618719338033)
         .* y3 .^ 2.*x3 .^ 2 + (0.0233968615764063) .* y3 .^ 1.*x3 .^ 1 + (0.005080472749631)
         .* y3 .^ 1.*x3 .^ 2);
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
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

protected
    SmoothTransition st "Smooth transition";
    SpecificEntropy ds=st.T_ps "Entropy gradient for a smooth transition";
    SpecificEntropy s_dew "Specififc entropy at dew line";
    SpecificEntropy s_bubble "Specific entropy at bubble line";
    Real x1 "Regression term for centred and scaled logarithmic pressure";
    Real y1 "Regression term for centred and scaled entropy";
    Real T1 "Regression term for the temperature";
    Real x2 "Regression term for centred and scaled logarithmic pressure";
    Real x3 "Regression term for centred and scaled logarithmic pressure";
    Real y2 "Regression term for centred and scaled entropy";
    Real y3 "Regression term for centred and scaled entropy";
    Real T2 "Regression term for the temperature";
    Real T3 "Regression term for the temperature";
    Real x_scr "Regression term for centred and scaled logarithmic pressure";
    Real s_scr "Regression term for centred and scaled entropy";
    Real s_IIR "Regression term for centred and scaled entropy";

  algorithm
    s_IIR := s + 2.736808957627727E3;
    s_dew := dewEntropy(sat=setSat_p(p=p)) + 2.736808957627727E3;
    s_bubble := bubbleEntropy(sat=setSat_p(p=p)) + 2.736808957627727E3;
    x_scr := (log(p) - 15.9737451344477)/0.0876291056536608;
    s_scr := 1271.18991015299 + 31.6158276743894*(((-0.211615238120171) + (-0.695040296083562)
       .* x_scr .^ 1 + (0.0767031043759982) .* x_scr .^ 2 + (-1.08621654427118)
       .* x_scr .^ 3 + (0.64986780713796) .* x_scr .^ 4 + (6.66822473831742) .*
      x_scr .^ 5 + (-2.93033262430351) .* x_scr .^ 6 + (-19.3613495658065) .*
      x_scr .^ 7 + (6.58168042042789) .* x_scr .^ 8 + (30.3233775210149) .*
      x_scr .^ 9 + (-8.07302046371493) .* x_scr .^ 10 + (-27.8354882948879) .*
      x_scr .^ 11 + (5.69068924735857) .* x_scr .^ 12 + (15.4214777750273) .*
      x_scr .^ 13 + (-2.2957976898621) .* x_scr .^ 14 + (-5.07489232309945) .*
      x_scr .^ 15 + (0.492023438569825) .* x_scr .^ 16 + (0.913548979443457) .*
      x_scr .^ 17 + (-0.0433875271986535) .* x_scr .^ 18 + (-0.0693083941975675)
       .* x_scr .^ 19));

    if p < 7377300 then
      if s_IIR < s_bubble - ds then
        //SC
        x1 := (log(p) - 15.4659744379055)/0.570086745208579;
        y1 := (s_IIR - 690.083971553611)/257.741313505105;
        T := 237.773569203860 + 29.9013115665379*(-0.00525956394114347 + (0.0375567079196747)
           .* x1 .^ 1 + (0.00972661642336815) .* x1 .^ 2 + (0.00381361486468428)
           .* x1 .^ 3 + (0.00193486385069378) .* x1 .^ 4 + (-0.00285990159484531)
           .* x1 .^ 5 + (-0.00217211266237801) .* x1 .^ 6 + (0.000863446951870381)
           .* x1 .^ 7 + (0.000936458432247542) .* x1 .^ 8 + (0.000179029664496414)
           .* x1 .^ 9 + (1.03089400550965) .* y1 .^ 1 + (0.0322865666650518) .*
          y1 .^ 2 + (-0.0143650676978548) .* y1 .^ 3 + (-0.0264644143207841) .*
          y1 .^ 4 + (-0.00828281662087412) .* y1 .^ 5 + (0.0659997607583463) .*
          y1 .^ 6 + (-0.0323632662220968) .* y1 .^ 7 + (-0.0575917408804803) .*
          y1 .^ 8 + (0.0720228816964693) .* y1 .^ 9 + (-0.0312549550494376) .*
          y1 .^ 10 + (0.00579559144612026) .* y1 .^ 11 + (-0.000407464137871825)
           .* y1 .^ 12 + (-0.0012679316784007) .* y1 .^ 11.*x1 .^ 1 + (0.00980308384470109)
           .* y1 .^ 10.*x1 .^ 1 + (0.00165786352974735) .* y1 .^ 10.*x1 .^ 2 +
          (0.00953434347169057) .* y1 .^ 9.*x1 .^ 1 + (-0.0615897553214999) .*
          y1 .^ 9.*x1 .^ 2 + (0.0212406826365093) .* y1 .^ 9.*x1 .^ 3 + (-0.0983846089625151)
           .* y1 .^ 8.*x1 .^ 1 + (0.117406763333374) .* y1 .^ 8.*x1 .^ 2 + (0.0789137879311679)
           .* y1 .^ 8.*x1 .^ 3 + (-0.073398617157631) .* y1 .^ 8.*x1 .^ 4 + (0.0970414204139202)
           .* y1 .^ 7.*x1 .^ 1 + (0.0611752532336594) .* y1 .^ 7.*x1 .^ 2 + (-0.228461656266479)
           .* y1 .^ 7.*x1 .^ 3 + (-0.0263578130023818) .* y1 .^ 7.*x1 .^ 4 + (
          0.109724544680481) .* y1 .^ 7.*x1 .^ 5 + (0.0635920487027199) .* y1 .^
          6.*x1 .^ 1 + (-0.157912979100403) .* y1 .^ 6.*x1 .^ 2 + (-0.0683189232949799)
           .* y1 .^ 6.*x1 .^ 3 + (0.246631425316431) .* y1 .^ 6.*x1 .^ 4 + (-0.00486123102410811)
           .* y1 .^ 6.*x1 .^ 5 + (-0.0962393999777624) .* y1 .^ 6.*x1 .^ 6 + (
          -0.0889658480657323) .* y1 .^ 5.*x1 .^ 1 + (-0.0747550185729336) .*
          y1 .^ 5.*x1 .^ 2 + (0.259855489926179) .* y1 .^ 5.*x1 .^ 3 + (0.0730784271531593)
           .* y1 .^ 5.*x1 .^ 4 + (-0.222239059379547) .* y1 .^ 5.*x1 .^ 5 + (-0.00567963332242039)
           .* y1 .^ 5.*x1 .^ 6 + (0.0529022997592714) .* y1 .^ 5.*x1 .^ 7 + (-0.0177429946256117)
           .* y1 .^ 4.*x1 .^ 1 + (0.0952431584414644) .* y1 .^ 4.*x1 .^ 2 + (0.0698394554910627)
           .* y1 .^ 4.*x1 .^ 3 + (-0.224921719234958) .* y1 .^ 4.*x1 .^ 4 + (-0.058180014507978)
           .* y1 .^ 4.*x1 .^ 5 + (0.134186505281863) .* y1 .^ 4.*x1 .^ 6 + (0.0205374264488603)
           .* y1 .^ 4.*x1 .^ 7 + (-0.0159284363200894) .* y1 .^ 4.*x1 .^ 8 + (
          0.0287592512544731) .* y1 .^ 3.*x1 .^ 1 + (0.0491942360544333) .*
          y1 .^ 3.*x1 .^ 2 + (-0.112651093458106) .* y1 .^ 3.*x1 .^ 3 + (-0.079196960627254)
           .* y1 .^ 3.*x1 .^ 4 + (0.140263116310967) .* y1 .^ 3.*x1 .^ 5 + (0.0508940119284918)
           .* y1 .^ 3.*x1 .^ 6 + (-0.0529661534499776) .* y1 .^ 3.*x1 .^ 7 + (
          -0.0166986185097119) .* y1 .^ 3.*x1 .^ 8 + (0.00176647696804449) .*
          y1 .^ 3.*x1 .^ 9 + (0.0124152784209372) .* y1 .^ 2.*x1 .^ 1 + (-0.0179971244252732)
           .* y1 .^ 2.*x1 .^ 2 + (-0.0322994481146215) .* y1 .^ 2.*x1 .^ 3 + (
          0.0541253384686689) .* y1 .^ 2.*x1 .^ 4 + (0.0456788056781579) .*
          y1 .^ 2.*x1 .^ 5 + (-0.0383463117593314) .* y1 .^ 2.*x1 .^ 6 + (-0.0236820513068561)
           .* y1 .^ 2.*x1 .^ 7 + (0.00659980651152344) .* y1 .^ 2.*x1 .^ 8 + (
          0.00352442504613421) .* y1 .^ 2.*x1 .^ 9 + (0.0163022160812854) .*
          y1 .^ 1.*x1 .^ 1 + (-0.00489205577886678) .* y1 .^ 1.*x1 .^ 2 + (0.01643693613578)
           .* y1 .^ 1.*x1 .^ 3 + (0.0235508330883492) .* y1 .^ 1.*x1 .^ 4 + (-0.0197488167296418)
           .* y1 .^ 1.*x1 .^ 5 + (-0.02328824067435) .* y1 .^ 1.*x1 .^ 6 + (0.00462649266914588)
           .* y1 .^ 1.*x1 .^ 7 + (0.00848748804094358) .* y1 .^ 1.*x1 .^ 8 + (
          0.00183100126500413) .* y1 .^ 1.*x1 .^ 9);
      elseif s_IIR > s_dew + ds then
        //SH
        x2 := (log(p) - 15.3277337030617)/0.621120317258441;
        y2 := (s_IIR - 2354.62309776343)/368.384949113833;
        T := 477.564423674341 + 167.046899022306*(-0.190630753743194 + (0.343613906426244)
           .* x2 .^ 1 + (0.0178236658542171) .* x2 .^ 2 + (0.000724427476874153)
           .* x2 .^ 3 + (2.01944545092901e-05) .* x2 .^ 4 + (0.920077717547061)
           .* y2 .^ 1 + (0.157946589333349) .* y2 .^ 2 + (-0.00821751740744134)
           .* y2 .^ 3 + (0.00554031098787947) .* y2 .^ 4 + (-0.000679995762371423)
           .* y2 .^ 5 + (0.000288678780790623) .* y2 .^ 6 + (-0.000385005336459924)
           .* y2 .^ 7 + (-6.00371076374742e-05) .* y2 .^ 8 + (0.000122950368672675)
           .* y2 .^ 9 + (1.80552297476392e-05) .* y2 .^ 10 + (-1.89254817525203e-05)
           .* y2 .^ 11 + (-6.07234524403335e-05) .* y2 .^ 10.*x2 .^ 1 + (0.000212341445729102)
           .* y2 .^ 9.*x2 .^ 1 + (-0.000149174219683957) .* y2 .^ 9.*x2 .^ 2 +
          (-9.11733428849875e-05) .* y2 .^ 8.*x2 .^ 1 + (0.000470816396590746)
           .* y2 .^ 8.*x2 .^ 2 + (-5.02631131875637e-05) .* y2 .^ 8.*x2 .^ 3 +
          (-0.000394507431163453) .* y2 .^ 7.*x2 .^ 1 + (1.47062985772559e-05)
           .* y2 .^ 7.*x2 .^ 2 + (0.000235306131520488) .* y2 .^ 7.*x2 .^ 3 +
          (-1.52516334992849e-05) .* y2 .^ 7.*x2 .^ 4 + (0.000368301152506869)
           .* y2 .^ 6.*x2 .^ 1 + (-0.00113338308665754) .* y2 .^ 6.*x2 .^ 2 +
          (-0.000348458707983049) .* y2 .^ 6.*x2 .^ 3 + (3.07496495612071e-05)
           .* y2 .^ 6.*x2 .^ 4 + (0.000489108570627152) .* y2 .^ 5.*x2 .^ 1 +
          (0.00048963005451104) .* y2 .^ 5.*x2 .^ 2 + (-3.08278835931454e-05) .*
          y2 .^ 5.*x2 .^ 3 + (-1.45202120736564e-05) .* y2 .^ 5.*x2 .^ 4 + (-0.000971295227211896)
           .* y2 .^ 4.*x2 .^ 1 + (0.000828572831707275) .* y2 .^ 4.*x2 .^ 2 +
          (0.000477377154969464) .* y2 .^ 4.*x2 .^ 3 + (4.17805354167385e-05) .*
          y2 .^ 4.*x2 .^ 4 + (0.000459558933317606) .* y2 .^ 3.*x2 .^ 1 + (-0.000278806520235111)
           .* y2 .^ 3.*x2 .^ 2 + (-0.000103826446087262) .* y2 .^ 3.*x2 .^ 3 +
          (-4.38144207776239e-05) .* y2 .^ 3.*x2 .^ 4 + (0.0116613992466142) .*
          y2 .^ 2.*x2 .^ 1 + (0.000430539993332003) .* y2 .^ 2.*x2 .^ 2 + (-0.000380156226912084)
           .* y2 .^ 2.*x2 .^ 3 + (-4.24737984512163e-05) .* y2 .^ 2.*x2 .^ 4 +
          (0.0622335598206458) .* y2 .^ 1.*x2 .^ 1 + (6.48796001281074e-05) .*
          y2 .^ 1.*x2 .^ 2 + (0.000201074897751942) .* y2 .^ 1.*x2 .^ 3 + (5.02059371747915e-05)
           .* y2 .^ 1.*x2 .^ 4);
      elseif s_IIR < s_bubble then
        //SC+smooth
        x1 := (log(p) - 15.4659744379055)/0.570086745208579;
        y1 := (s_IIR - 690.083971553611)/257.741313505105;
        T1 := 237.773569203860 + 29.9013115665379*(-0.00525956394114347 + (0.0375567079196747)
           .* x1 .^ 1 + (0.00972661642336815) .* x1 .^ 2 + (0.00381361486468428)
           .* x1 .^ 3 + (0.00193486385069378) .* x1 .^ 4 + (-0.00285990159484531)
           .* x1 .^ 5 + (-0.00217211266237801) .* x1 .^ 6 + (0.000863446951870381)
           .* x1 .^ 7 + (0.000936458432247542) .* x1 .^ 8 + (0.000179029664496414)
           .* x1 .^ 9 + (1.03089400550965) .* y1 .^ 1 + (0.0322865666650518) .*
          y1 .^ 2 + (-0.0143650676978548) .* y1 .^ 3 + (-0.0264644143207841) .*
          y1 .^ 4 + (-0.00828281662087412) .* y1 .^ 5 + (0.0659997607583463) .*
          y1 .^ 6 + (-0.0323632662220968) .* y1 .^ 7 + (-0.0575917408804803) .*
          y1 .^ 8 + (0.0720228816964693) .* y1 .^ 9 + (-0.0312549550494376) .*
          y1 .^ 10 + (0.00579559144612026) .* y1 .^ 11 + (-0.000407464137871825)
           .* y1 .^ 12 + (-0.0012679316784007) .* y1 .^ 11.*x1 .^ 1 + (0.00980308384470109)
           .* y1 .^ 10.*x1 .^ 1 + (0.00165786352974735) .* y1 .^ 10.*x1 .^ 2 +
          (0.00953434347169057) .* y1 .^ 9.*x1 .^ 1 + (-0.0615897553214999) .*
          y1 .^ 9.*x1 .^ 2 + (0.0212406826365093) .* y1 .^ 9.*x1 .^ 3 + (-0.0983846089625151)
           .* y1 .^ 8.*x1 .^ 1 + (0.117406763333374) .* y1 .^ 8.*x1 .^ 2 + (0.0789137879311679)
           .* y1 .^ 8.*x1 .^ 3 + (-0.073398617157631) .* y1 .^ 8.*x1 .^ 4 + (0.0970414204139202)
           .* y1 .^ 7.*x1 .^ 1 + (0.0611752532336594) .* y1 .^ 7.*x1 .^ 2 + (-0.228461656266479)
           .* y1 .^ 7.*x1 .^ 3 + (-0.0263578130023818) .* y1 .^ 7.*x1 .^ 4 + (
          0.109724544680481) .* y1 .^ 7.*x1 .^ 5 + (0.0635920487027199) .* y1 .^
          6.*x1 .^ 1 + (-0.157912979100403) .* y1 .^ 6.*x1 .^ 2 + (-0.0683189232949799)
           .* y1 .^ 6.*x1 .^ 3 + (0.246631425316431) .* y1 .^ 6.*x1 .^ 4 + (-0.00486123102410811)
           .* y1 .^ 6.*x1 .^ 5 + (-0.0962393999777624) .* y1 .^ 6.*x1 .^ 6 + (
          -0.0889658480657323) .* y1 .^ 5.*x1 .^ 1 + (-0.0747550185729336) .*
          y1 .^ 5.*x1 .^ 2 + (0.259855489926179) .* y1 .^ 5.*x1 .^ 3 + (0.0730784271531593)
           .* y1 .^ 5.*x1 .^ 4 + (-0.222239059379547) .* y1 .^ 5.*x1 .^ 5 + (-0.00567963332242039)
           .* y1 .^ 5.*x1 .^ 6 + (0.0529022997592714) .* y1 .^ 5.*x1 .^ 7 + (-0.0177429946256117)
           .* y1 .^ 4.*x1 .^ 1 + (0.0952431584414644) .* y1 .^ 4.*x1 .^ 2 + (0.0698394554910627)
           .* y1 .^ 4.*x1 .^ 3 + (-0.224921719234958) .* y1 .^ 4.*x1 .^ 4 + (-0.058180014507978)
           .* y1 .^ 4.*x1 .^ 5 + (0.134186505281863) .* y1 .^ 4.*x1 .^ 6 + (0.0205374264488603)
           .* y1 .^ 4.*x1 .^ 7 + (-0.0159284363200894) .* y1 .^ 4.*x1 .^ 8 + (
          0.0287592512544731) .* y1 .^ 3.*x1 .^ 1 + (0.0491942360544333) .*
          y1 .^ 3.*x1 .^ 2 + (-0.112651093458106) .* y1 .^ 3.*x1 .^ 3 + (-0.079196960627254)
           .* y1 .^ 3.*x1 .^ 4 + (0.140263116310967) .* y1 .^ 3.*x1 .^ 5 + (0.0508940119284918)
           .* y1 .^ 3.*x1 .^ 6 + (-0.0529661534499776) .* y1 .^ 3.*x1 .^ 7 + (
          -0.0166986185097119) .* y1 .^ 3.*x1 .^ 8 + (0.00176647696804449) .*
          y1 .^ 3.*x1 .^ 9 + (0.0124152784209372) .* y1 .^ 2.*x1 .^ 1 + (-0.0179971244252732)
           .* y1 .^ 2.*x1 .^ 2 + (-0.0322994481146215) .* y1 .^ 2.*x1 .^ 3 + (
          0.0541253384686689) .* y1 .^ 2.*x1 .^ 4 + (0.0456788056781579) .*
          y1 .^ 2.*x1 .^ 5 + (-0.0383463117593314) .* y1 .^ 2.*x1 .^ 6 + (-0.0236820513068561)
           .* y1 .^ 2.*x1 .^ 7 + (0.00659980651152344) .* y1 .^ 2.*x1 .^ 8 + (
          0.00352442504613421) .* y1 .^ 2.*x1 .^ 9 + (0.0163022160812854) .*
          y1 .^ 1.*x1 .^ 1 + (-0.00489205577886678) .* y1 .^ 1.*x1 .^ 2 + (0.01643693613578)
           .* y1 .^ 1.*x1 .^ 3 + (0.0235508330883492) .* y1 .^ 1.*x1 .^ 4 + (-0.0197488167296418)
           .* y1 .^ 1.*x1 .^ 5 + (-0.02328824067435) .* y1 .^ 1.*x1 .^ 6 + (0.00462649266914588)
           .* y1 .^ 1.*x1 .^ 7 + (0.00848748804094358) .* y1 .^ 1.*x1 .^ 8 + (
          0.00183100126500413) .* y1 .^ 1.*x1 .^ 9);
        T := saturationTemperature(p)*(1 - (s_bubble - s_IIR)/ds) + T1*(
          s_bubble - s_IIR)/ds;
      elseif s_IIR > s_dew then
        //SH+smooth
        x2 := (log(p) - 15.3277337030617)/0.621120317258441;
        y2 := (s_IIR - 2354.62309776343)/368.384949113833;
        T2 := 477.564423674341 + 167.046899022306*(-0.190630753743194 + (0.343613906426244)
           .* x2 .^ 1 + (0.0178236658542171) .* x2 .^ 2 + (0.000724427476874153)
           .* x2 .^ 3 + (2.01944545092901e-05) .* x2 .^ 4 + (0.920077717547061)
           .* y2 .^ 1 + (0.157946589333349) .* y2 .^ 2 + (-0.00821751740744134)
           .* y2 .^ 3 + (0.00554031098787947) .* y2 .^ 4 + (-0.000679995762371423)
           .* y2 .^ 5 + (0.000288678780790623) .* y2 .^ 6 + (-0.000385005336459924)
           .* y2 .^ 7 + (-6.00371076374742e-05) .* y2 .^ 8 + (0.000122950368672675)
           .* y2 .^ 9 + (1.80552297476392e-05) .* y2 .^ 10 + (-1.89254817525203e-05)
           .* y2 .^ 11 + (-6.07234524403335e-05) .* y2 .^ 10.*x2 .^ 1 + (0.000212341445729102)
           .* y2 .^ 9.*x2 .^ 1 + (-0.000149174219683957) .* y2 .^ 9.*x2 .^ 2 +
          (-9.11733428849875e-05) .* y2 .^ 8.*x2 .^ 1 + (0.000470816396590746)
           .* y2 .^ 8.*x2 .^ 2 + (-5.02631131875637e-05) .* y2 .^ 8.*x2 .^ 3 +
          (-0.000394507431163453) .* y2 .^ 7.*x2 .^ 1 + (1.47062985772559e-05)
           .* y2 .^ 7.*x2 .^ 2 + (0.000235306131520488) .* y2 .^ 7.*x2 .^ 3 +
          (-1.52516334992849e-05) .* y2 .^ 7.*x2 .^ 4 + (0.000368301152506869)
           .* y2 .^ 6.*x2 .^ 1 + (-0.00113338308665754) .* y2 .^ 6.*x2 .^ 2 +
          (-0.000348458707983049) .* y2 .^ 6.*x2 .^ 3 + (3.07496495612071e-05)
           .* y2 .^ 6.*x2 .^ 4 + (0.000489108570627152) .* y2 .^ 5.*x2 .^ 1 +
          (0.00048963005451104) .* y2 .^ 5.*x2 .^ 2 + (-3.08278835931454e-05) .*
          y2 .^ 5.*x2 .^ 3 + (-1.45202120736564e-05) .* y2 .^ 5.*x2 .^ 4 + (-0.000971295227211896)
           .* y2 .^ 4.*x2 .^ 1 + (0.000828572831707275) .* y2 .^ 4.*x2 .^ 2 +
          (0.000477377154969464) .* y2 .^ 4.*x2 .^ 3 + (4.17805354167385e-05) .*
          y2 .^ 4.*x2 .^ 4 + (0.000459558933317606) .* y2 .^ 3.*x2 .^ 1 + (-0.000278806520235111)
           .* y2 .^ 3.*x2 .^ 2 + (-0.000103826446087262) .* y2 .^ 3.*x2 .^ 3 +
          (-4.38144207776239e-05) .* y2 .^ 3.*x2 .^ 4 + (0.0116613992466142) .*
          y2 .^ 2.*x2 .^ 1 + (0.000430539993332003) .* y2 .^ 2.*x2 .^ 2 + (-0.000380156226912084)
           .* y2 .^ 2.*x2 .^ 3 + (-4.24737984512163e-05) .* y2 .^ 2.*x2 .^ 4 +
          (0.0622335598206458) .* y2 .^ 1.*x2 .^ 1 + (6.48796001281074e-05) .*
          y2 .^ 1.*x2 .^ 2 + (0.000201074897751942) .* y2 .^ 1.*x2 .^ 3 + (5.02059371747915e-05)
           .* y2 .^ 1.*x2 .^ 4);
        T := saturationTemperature(p)*(1 - (s_IIR - s_dew)/ds) + T2*(s_IIR -
          s_dew)/ds;
      else
        T := saturationTemperature(p);
      end if;
    elseif s_IIR > s_scr then
      //SCr
      x3 := (log(p) - 15.9636849410926)/0.0905971644333932;
      y3 := (s_IIR - 1684.98548505635)/176.231276873567;
      T := 327.841893249596 + 18.8072394686965*(-0.417723629037136 + (0.344735554261573)
         .* x3 .^ 1 + (0.00140489175581534) .* x3 .^ 2 + (0.796111390606469) .*
        y3 .^ 1 + (0.469370314543304) .* y3 .^ 2 + (0.0780692296275204) .* y3 .^
        3 + (-0.0324832922501074) .* y3 .^ 4 + (-0.00248824730779821) .* y3 .^
        5 + (0.00250865983045063) .* y3 .^ 6 + (-8.33028706454965e-05) .* y3 .^
        5.*x3 .^ 1 + (0.00222224815048957) .* y3 .^ 4.*x3 .^ 1 + (-0.000159447738460534)
         .* y3 .^ 4.*x3 .^ 2 + (-0.000588009343781178) .* y3 .^ 3.*x3 .^ 1 + (
        0.000330749546139952) .* y3 .^ 3.*x3 .^ 2 + (-0.022331382136452) .*
        y3 .^ 2.*x3 .^ 1 + (-9.78038881600861e-05) .* y3 .^ 2.*x3 .^ 2 + (0.0772413578677678)
         .* y3 .^ 1.*x3 .^ 1 + (0.00113367299843682) .* y3 .^ 1.*x3 .^ 2);
    elseif s_IIR < s_scr then
      //SC
      x1 := (log(p) - 15.4659744379055)/0.570086745208579;
      y1 := (s_IIR - 690.083971553611)/257.741313505105;
      T := 237.773569203860 + 29.9013115665379*(-0.00525956394114347 + (0.0375567079196747)
         .* x1 .^ 1 + (0.00972661642336815) .* x1 .^ 2 + (0.00381361486468428)
         .* x1 .^ 3 + (0.00193486385069378) .* x1 .^ 4 + (-0.00285990159484531)
         .* x1 .^ 5 + (-0.00217211266237801) .* x1 .^ 6 + (0.000863446951870381)
         .* x1 .^ 7 + (0.000936458432247542) .* x1 .^ 8 + (0.000179029664496414)
         .* x1 .^ 9 + (1.03089400550965) .* y1 .^ 1 + (0.0322865666650518) .*
        y1 .^ 2 + (-0.0143650676978548) .* y1 .^ 3 + (-0.0264644143207841) .*
        y1 .^ 4 + (-0.00828281662087412) .* y1 .^ 5 + (0.0659997607583463) .*
        y1 .^ 6 + (-0.0323632662220968) .* y1 .^ 7 + (-0.0575917408804803) .*
        y1 .^ 8 + (0.0720228816964693) .* y1 .^ 9 + (-0.0312549550494376) .*
        y1 .^ 10 + (0.00579559144612026) .* y1 .^ 11 + (-0.000407464137871825)
         .* y1 .^ 12 + (-0.0012679316784007) .* y1 .^ 11.*x1 .^ 1 + (0.00980308384470109)
         .* y1 .^ 10.*x1 .^ 1 + (0.00165786352974735) .* y1 .^ 10.*x1 .^ 2 + (
        0.00953434347169057) .* y1 .^ 9.*x1 .^ 1 + (-0.0615897553214999) .*
        y1 .^ 9.*x1 .^ 2 + (0.0212406826365093) .* y1 .^ 9.*x1 .^ 3 + (-0.0983846089625151)
         .* y1 .^ 8.*x1 .^ 1 + (0.117406763333374) .* y1 .^ 8.*x1 .^ 2 + (0.0789137879311679)
         .* y1 .^ 8.*x1 .^ 3 + (-0.073398617157631) .* y1 .^ 8.*x1 .^ 4 + (0.0970414204139202)
         .* y1 .^ 7.*x1 .^ 1 + (0.0611752532336594) .* y1 .^ 7.*x1 .^ 2 + (-0.228461656266479)
         .* y1 .^ 7.*x1 .^ 3 + (-0.0263578130023818) .* y1 .^ 7.*x1 .^ 4 + (0.109724544680481)
         .* y1 .^ 7.*x1 .^ 5 + (0.0635920487027199) .* y1 .^ 6.*x1 .^ 1 + (-0.157912979100403)
         .* y1 .^ 6.*x1 .^ 2 + (-0.0683189232949799) .* y1 .^ 6.*x1 .^ 3 + (0.246631425316431)
         .* y1 .^ 6.*x1 .^ 4 + (-0.00486123102410811) .* y1 .^ 6.*x1 .^ 5 + (-0.0962393999777624)
         .* y1 .^ 6.*x1 .^ 6 + (-0.0889658480657323) .* y1 .^ 5.*x1 .^ 1 + (-0.0747550185729336)
         .* y1 .^ 5.*x1 .^ 2 + (0.259855489926179) .* y1 .^ 5.*x1 .^ 3 + (0.0730784271531593)
         .* y1 .^ 5.*x1 .^ 4 + (-0.222239059379547) .* y1 .^ 5.*x1 .^ 5 + (-0.00567963332242039)
         .* y1 .^ 5.*x1 .^ 6 + (0.0529022997592714) .* y1 .^ 5.*x1 .^ 7 + (-0.0177429946256117)
         .* y1 .^ 4.*x1 .^ 1 + (0.0952431584414644) .* y1 .^ 4.*x1 .^ 2 + (0.0698394554910627)
         .* y1 .^ 4.*x1 .^ 3 + (-0.224921719234958) .* y1 .^ 4.*x1 .^ 4 + (-0.058180014507978)
         .* y1 .^ 4.*x1 .^ 5 + (0.134186505281863) .* y1 .^ 4.*x1 .^ 6 + (0.0205374264488603)
         .* y1 .^ 4.*x1 .^ 7 + (-0.0159284363200894) .* y1 .^ 4.*x1 .^ 8 + (0.0287592512544731)
         .* y1 .^ 3.*x1 .^ 1 + (0.0491942360544333) .* y1 .^ 3.*x1 .^ 2 + (-0.112651093458106)
         .* y1 .^ 3.*x1 .^ 3 + (-0.079196960627254) .* y1 .^ 3.*x1 .^ 4 + (0.140263116310967)
         .* y1 .^ 3.*x1 .^ 5 + (0.0508940119284918) .* y1 .^ 3.*x1 .^ 6 + (-0.0529661534499776)
         .* y1 .^ 3.*x1 .^ 7 + (-0.0166986185097119) .* y1 .^ 3.*x1 .^ 8 + (0.00176647696804449)
         .* y1 .^ 3.*x1 .^ 9 + (0.0124152784209372) .* y1 .^ 2.*x1 .^ 1 + (-0.0179971244252732)
         .* y1 .^ 2.*x1 .^ 2 + (-0.0322994481146215) .* y1 .^ 2.*x1 .^ 3 + (0.0541253384686689)
         .* y1 .^ 2.*x1 .^ 4 + (0.0456788056781579) .* y1 .^ 2.*x1 .^ 5 + (-0.0383463117593314)
         .* y1 .^ 2.*x1 .^ 6 + (-0.0236820513068561) .* y1 .^ 2.*x1 .^ 7 + (0.00659980651152344)
         .* y1 .^ 2.*x1 .^ 8 + (0.00352442504613421) .* y1 .^ 2.*x1 .^ 9 + (0.0163022160812854)
         .* y1 .^ 1.*x1 .^ 1 + (-0.00489205577886678) .* y1 .^ 1.*x1 .^ 2 + (0.01643693613578)
         .* y1 .^ 1.*x1 .^ 3 + (0.0235508330883492) .* y1 .^ 1.*x1 .^ 4 + (-0.0197488167296418)
         .* y1 .^ 1.*x1 .^ 5 + (-0.02328824067435) .* y1 .^ 1.*x1 .^ 6 + (0.00462649266914588)
         .* y1 .^ 1.*x1 .^ 7 + (0.00848748804094358) .* y1 .^ 1.*x1 .^ 8 + (0.00183100126500413)
         .* y1 .^ 1.*x1 .^ 9);
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
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";

protected
    SmoothTransition st "Smooth transition";
    AbsolutePressure dp=st.d_pT "Pressure gradient for a smooth transition";
    SaturationProperties sat=setSat_T(T=T) "Saturation properties";
    Real x1 "Regression term for centred and scaled pressure";
    Real y1 "Regression term for centred and scaled temperature";
    Real d1 "Regression term for the density";
    Real x2 "Regression term for centred and scaled pressure";
    Real y2 "Regression term for centred and scaled temperature";
    Real d2 "Regression term for the density";
    Real x3 "Regression term for centred and scaled pressure";
    Real y3 "Regression term for centred and scaled temperature";
    Real x4 "Regression term for centred and scaled pressure";
    Real y4 "Regression term for centred and scaled temperature";
    Real x5 "Regression term for centred and scaled pressure";
    Real y5 "Regression term for centred and scaled temperature";
    Real x6 "Regression term for centred and scaled pressure";
    Real y6 "Regression term for centred and scaled temperature";
    Real fitSCrSH "Regression term";
    Real fitSCrSC "Regression term";
    Real x_SCrSH "Regression term for centred and scaled temperature";
    Real x_SCrSC "Regression term for centred and scaled temperature";

  algorithm

    if T < 293.48 then
      fitSCrSH := 999E5;
      fitSCrSC := 0;
    elseif T > 335 then
      fitSCrSH := 999E5;
      fitSCrSC := 999E5;
    else
      x_SCrSH := (T - 310.6101043643270)/8.76584320026567;
      fitSCrSH := 7892500 + 1217198.69646113*(0.00188719085040888 .* x_SCrSH .^
        8 + 0.0124350377093051 .* x_SCrSH .^ 7 + 0.0137074261256939 .*
        x_SCrSH .^ 6 - 0.0194093733616778 .* x_SCrSH .^ 5 - 0.0159253973725892
         .* x_SCrSH .^ 4 + 0.0482368799973961 .* x_SCrSH .^ 3 + 0.134678047836633
         .* x_SCrSH .^ 2 + 0.960326246865776 .* x_SCrSH - 0.137487708236514);
      x_SCrSC := (T - 302.260412713472)/5.61368969154838;
      fitSCrSC := 7892500 + 1217198.69646113*(0.000119724593648295 .* x_SCrSC .^
        8 - 0.000333709955125262 .* x_SCrSC .^ 7 - 0.000492485309735125 .*
        x_SCrSC .^ 6 + 0.000188842225009553 .* x_SCrSC .^ 5 - 0.00341321580455679
         .* x_SCrSC .^ 4 - 0.00943221113935049 .* x_SCrSC .^ 3 - 0.0847871234324372
         .* x_SCrSC .^ 2 + 1.0454687249959 .* x_SCrSC + 0.096352688710157);
    end if;

    if p < 5784000 then
      if p < sat.psat - dp then
        //"SH"
        x1 := (p - 5519495.79447002)/2567703.39184083;
        y1 := (T - 323.196143266723)/28.5422300266500;
        d := 132.091744019263 + 76.6522972242426*(-0.159545317255397 + (1.01926707118493)
           .* x1 .^ 1 + (0.232721507740677) .* x1 .^ 2 + (0.0637721470284816) .*
          x1 .^ 3 + (0.00697505645251303) .* x1 .^ 4 + (0.0171500109603422) .*
          x1 .^ 5 + (0.0174512144655053) .* x1 .^ 6 + (0.000495265054733816) .*
          x1 .^ 7 + (-0.00265011383145745) .* x1 .^ 8 + (-0.000186293075538892)
           .* x1 .^ 9 + (7.15487921614317e-05) .* x1 .^ 10 + (-0.348266420768099)
           .* y1 .^ 1 + (0.145751418029237) .* y1 .^ 2 + (-0.0626747233532592)
           .* y1 .^ 3 + (-0.0180496910371365) .* y1 .^ 4 + (0.00878813080312919)
           .* y1 .^ 5 + (0.0503931240863202) .* y1 .^ 6 + (-0.0445413553535566)
           .* y1 .^ 7 + (0.0105926422069889) .* y1 .^ 8 + (0.000158640337862594)
           .* x1 .^ 9.*y1 .^ 1 + (0.00417487913241615) .* x1 .^ 8.*y1 .^ 1 + (
          -0.001772613519994) .* x1 .^ 8.*y1 .^ 2 + (0.00824627937624933) .*
          x1 .^ 7.*y1 .^ 1 + (-0.0149332490903717) .* x1 .^ 7.*y1 .^ 2 + (0.00595637375150662)
           .* x1 .^ 7.*y1 .^ 3 + (-0.0490519008171776) .* x1 .^ 6.*y1 .^ 1 + (
          0.0547644631894267) .* x1 .^ 6.*y1 .^ 2 + (-0.0294054443156379) .*
          x1 .^ 6.*y1 .^ 3 + (0.00644113577382396) .* x1 .^ 6.*y1 .^ 4 + (-0.141050144830697)
           .* x1 .^ 5.*y1 .^ 1 + (0.331124788177358) .* x1 .^ 5.*y1 .^ 2 + (-0.361637858402444)
           .* x1 .^ 5.*y1 .^ 3 + (0.199845308894148) .* x1 .^ 5.*y1 .^ 4 + (-0.0445539243958295)
           .* x1 .^ 5.*y1 .^ 5 + (-0.0895191026576243) .* x1 .^ 4.*y1 .^ 1 + (
          0.435000419295625) .* x1 .^ 4.*y1 .^ 2 + (-0.855765252276763) .* x1 .^
          4.*y1 .^ 3 + (0.794279259209092) .* x1 .^ 4.*y1 .^ 4 + (-0.349305438078168)
           .* x1 .^ 4.*y1 .^ 5 + (0.0587289941449) .* x1 .^ 4.*y1 .^ 6 + (-0.0673246981760775)
           .* x1 .^ 3.*y1 .^ 1 + (0.152276713823781) .* x1 .^ 3.*y1 .^ 2 + (-0.658989014138355)
           .* x1 .^ 3.*y1 .^ 3 + (1.12099169078695) .* x1 .^ 3.*y1 .^ 4 + (-0.852220059293641)
           .* x1 .^ 3.*y1 .^ 5 + (0.284103442427349) .* x1 .^ 3.*y1 .^ 6 + (-0.030598075669132)
           .* x1 .^ 3.*y1 .^ 7 + (-0.274835535466439) .* x1 .^ 2.*y1 .^ 1 + (0.10521659327455)
           .* x1 .^ 2.*y1 .^ 2 + (-0.0817699019842939) .* x1 .^ 2.*y1 .^ 3 + (
          0.540205525921847) .* x1 .^ 2.*y1 .^ 4 + (-0.805704737418588) .* x1 .^
          2.*y1 .^ 5 + (0.473195595542273) .* x1 .^ 2.*y1 .^ 6 + (-0.10962351779232)
           .* x1 .^ 2.*y1 .^ 7 + (0.00553839782424903) .* x1 .^ 2.*y1 .^ 8 + (
          -0.456453407756215) .* x1 .^ 1.*y1 .^ 1 + (0.257424821666076) .* x1 .^
          1.*y1 .^ 2 + (-0.0207597004660533) .* x1 .^ 1.*y1 .^ 3 + (-0.00617607581669293)
           .* x1 .^ 1.*y1 .^ 4 + (-0.243348931432783) .* x1 .^ 1.*y1 .^ 5 + (0.301605652645551)
           .* x1 .^ 1.*y1 .^ 6 + (-0.124499607368792) .* x1 .^ 1.*y1 .^ 7 + (0.0155731352048423)
           .* x1 .^ 1.*y1 .^ 8);
      elseif p > sat.psat + dp then
        //"SC"
        x2 := (p - 6580996.33416770)/2214553.60520798;
        y2 := (T - 267.837445960128)/20.0905008530052;
        d := 965.064886068137 + 111.097344509587*(0.146947556383107 + (0.116294045193668)
           .* x2 .^ 1 + (-0.00776505941118675) .* x2 .^ 2 + (0.000909338872673313)
           .* x2 .^ 3 + (1.21319825925124e-05) .* x2 .^ 4 + (8.97167217021812e-06)
           .* x2 .^ 5 + (-1.5308353581393e-05) .* x2 .^ 6 + (3.25771277715757e-06)
           .* x2 .^ 7 + (9.90491511851455e-07) .* x2 .^ 8 + (-5.33640713220979e-07)
           .* x2 .^ 9 + (-0.943249296676852) .* y2 .^ 1 + (-0.146272750957203)
           .* y2 .^ 2 + (-0.0570877777084003) .* y2 .^ 3 + (-0.0165198662527552)
           .* y2 .^ 4 + (0.00548909064326438) .* y2 .^ 5 + (-0.00353615752892107)
           .* y2 .^ 6 + (-0.00984303685396187) .* y2 .^ 7 + (-0.0033093738264456)
           .* y2 .^ 8 + (2.74502945704711e-06) .* x2 .^ 8.*y2 .^ 1 + (-3.61748982871047e-06)
           .* x2 .^ 7.*y2 .^ 1 + (-5.38064234037705e-06) .* x2 .^ 7.*y2 .^ 2 +
          (-4.3048770725053e-05) .* x2 .^ 6.*y2 .^ 1 + (-2.41498361533748e-05)
           .* x2 .^ 6.*y2 .^ 2 + (-4.58516940835319e-06) .* x2 .^ 6.*y2 .^ 3 +
          (0.000210275056813108) .* x2 .^ 5.*y2 .^ 1 + (0.000544157521874485) .*
          x2 .^ 5.*y2 .^ 2 + (0.000479178921972304) .* x2 .^ 5.*y2 .^ 3 + (0.00014173544041628)
           .* x2 .^ 5.*y2 .^ 4 + (-8.1659715995431e-05) .* x2 .^ 4.*y2 .^ 1 +
          (-0.00151824979097779) .* x2 .^ 4.*y2 .^ 2 + (-0.00329032034031329) .*
          x2 .^ 4.*y2 .^ 3 + (-0.00251687289333307) .* x2 .^ 4.*y2 .^ 4 + (-0.00064501646722513)
           .* x2 .^ 4.*y2 .^ 5 + (0.00081043050332391) .* x2 .^ 3.*y2 .^ 1 + (
          -0.00060579516562056) .* x2 .^ 3.*y2 .^ 2 + (0.00420529704478072) .*
          x2 .^ 3.*y2 .^ 3 + (0.0108011510380893) .* x2 .^ 3.*y2 .^ 4 + (0.00783557504988342)
           .* x2 .^ 3.*y2 .^ 5 + (0.00181838166402227) .* x2 .^ 3.*y2 .^ 6 + (
          -0.0126008967427799) .* x2 .^ 2.*y2 .^ 1 + (-0.00721185526704901) .*
          x2 .^ 2.*y2 .^ 2 + (0.0020952709802553) .* x2 .^ 2.*y2 .^ 3 + (-0.00737438124522966)
           .* x2 .^ 2.*y2 .^ 4 + (-0.0198586589754445) .* x2 .^ 2.*y2 .^ 5 + (
          -0.0130316521317318) .* x2 .^ 2.*y2 .^ 6 + (-0.00268476903693715) .*
          x2 .^ 2.*y2 .^ 7 + (0.0790651759889045) .* x2 .^ 1.*y2 .^ 1 + (0.0528486800895992)
           .* x2 .^ 1.*y2 .^ 2 + (0.0197031757182) .* x2 .^ 1.*y2 .^ 3 + (-0.00631626007050606)
           .* x2 .^ 1.*y2 .^ 4 + (0.0082655676765256) .* x2 .^ 1.*y2 .^ 5 + (0.0215232833104674)
           .* x2 .^ 1.*y2 .^ 6 + (0.0105534402562103) .* x2 .^ 1.*y2 .^ 7 + (0.00138543647533724)
           .* x2 .^ 1.*y2 .^ 8);
      elseif p < sat.psat then
        //"SH + smooth"
        x1 := (p - 5519495.79447002)/2567703.39184083;
        y1 := (T - 323.196143266723)/28.5422300266500;
        d1 := 132.091744019263 + 76.6522972242426*(-0.159545317255397 + (1.01926707118493)
           .* x1 .^ 1 + (0.232721507740677) .* x1 .^ 2 + (0.0637721470284816) .*
          x1 .^ 3 + (0.00697505645251303) .* x1 .^ 4 + (0.0171500109603422) .*
          x1 .^ 5 + (0.0174512144655053) .* x1 .^ 6 + (0.000495265054733816) .*
          x1 .^ 7 + (-0.00265011383145745) .* x1 .^ 8 + (-0.000186293075538892)
           .* x1 .^ 9 + (7.15487921614317e-05) .* x1 .^ 10 + (-0.348266420768099)
           .* y1 .^ 1 + (0.145751418029237) .* y1 .^ 2 + (-0.0626747233532592)
           .* y1 .^ 3 + (-0.0180496910371365) .* y1 .^ 4 + (0.00878813080312919)
           .* y1 .^ 5 + (0.0503931240863202) .* y1 .^ 6 + (-0.0445413553535566)
           .* y1 .^ 7 + (0.0105926422069889) .* y1 .^ 8 + (0.000158640337862594)
           .* x1 .^ 9.*y1 .^ 1 + (0.00417487913241615) .* x1 .^ 8.*y1 .^ 1 + (
          -0.001772613519994) .* x1 .^ 8.*y1 .^ 2 + (0.00824627937624933) .*
          x1 .^ 7.*y1 .^ 1 + (-0.0149332490903717) .* x1 .^ 7.*y1 .^ 2 + (0.00595637375150662)
           .* x1 .^ 7.*y1 .^ 3 + (-0.0490519008171776) .* x1 .^ 6.*y1 .^ 1 + (
          0.0547644631894267) .* x1 .^ 6.*y1 .^ 2 + (-0.0294054443156379) .*
          x1 .^ 6.*y1 .^ 3 + (0.00644113577382396) .* x1 .^ 6.*y1 .^ 4 + (-0.141050144830697)
           .* x1 .^ 5.*y1 .^ 1 + (0.331124788177358) .* x1 .^ 5.*y1 .^ 2 + (-0.361637858402444)
           .* x1 .^ 5.*y1 .^ 3 + (0.199845308894148) .* x1 .^ 5.*y1 .^ 4 + (-0.0445539243958295)
           .* x1 .^ 5.*y1 .^ 5 + (-0.0895191026576243) .* x1 .^ 4.*y1 .^ 1 + (
          0.435000419295625) .* x1 .^ 4.*y1 .^ 2 + (-0.855765252276763) .* x1 .^
          4.*y1 .^ 3 + (0.794279259209092) .* x1 .^ 4.*y1 .^ 4 + (-0.349305438078168)
           .* x1 .^ 4.*y1 .^ 5 + (0.0587289941449) .* x1 .^ 4.*y1 .^ 6 + (-0.0673246981760775)
           .* x1 .^ 3.*y1 .^ 1 + (0.152276713823781) .* x1 .^ 3.*y1 .^ 2 + (-0.658989014138355)
           .* x1 .^ 3.*y1 .^ 3 + (1.12099169078695) .* x1 .^ 3.*y1 .^ 4 + (-0.852220059293641)
           .* x1 .^ 3.*y1 .^ 5 + (0.284103442427349) .* x1 .^ 3.*y1 .^ 6 + (-0.030598075669132)
           .* x1 .^ 3.*y1 .^ 7 + (-0.274835535466439) .* x1 .^ 2.*y1 .^ 1 + (0.10521659327455)
           .* x1 .^ 2.*y1 .^ 2 + (-0.0817699019842939) .* x1 .^ 2.*y1 .^ 3 + (
          0.540205525921847) .* x1 .^ 2.*y1 .^ 4 + (-0.805704737418588) .* x1 .^
          2.*y1 .^ 5 + (0.473195595542273) .* x1 .^ 2.*y1 .^ 6 + (-0.10962351779232)
           .* x1 .^ 2.*y1 .^ 7 + (0.00553839782424903) .* x1 .^ 2.*y1 .^ 8 + (
          -0.456453407756215) .* x1 .^ 1.*y1 .^ 1 + (0.257424821666076) .* x1 .^
          1.*y1 .^ 2 + (-0.0207597004660533) .* x1 .^ 1.*y1 .^ 3 + (-0.00617607581669293)
           .* x1 .^ 1.*y1 .^ 4 + (-0.243348931432783) .* x1 .^ 1.*y1 .^ 5 + (0.301605652645551)
           .* x1 .^ 1.*y1 .^ 6 + (-0.124499607368792) .* x1 .^ 1.*y1 .^ 7 + (0.0155731352048423)
           .* x1 .^ 1.*y1 .^ 8);
        d := 0.995*bubbleDensity(sat)*(1 - (sat.psat - p)/dp) + d1*(sat.psat -
          p)/dp;
      elseif p > sat.psat then
        //"SC+smooth"
        x2 := (p - 6580996.33416770)/2214553.60520798;
        y2 := (T - 267.837445960128)/20.0905008530052;
        d2 := 965.064886068137 + 111.097344509587*(0.146947556383107 + (0.116294045193668)
           .* x2 .^ 1 + (-0.00776505941118675) .* x2 .^ 2 + (0.000909338872673313)
           .* x2 .^ 3 + (1.21319825925124e-05) .* x2 .^ 4 + (8.97167217021812e-06)
           .* x2 .^ 5 + (-1.5308353581393e-05) .* x2 .^ 6 + (3.25771277715757e-06)
           .* x2 .^ 7 + (9.90491511851455e-07) .* x2 .^ 8 + (-5.33640713220979e-07)
           .* x2 .^ 9 + (-0.943249296676852) .* y2 .^ 1 + (-0.146272750957203)
           .* y2 .^ 2 + (-0.0570877777084003) .* y2 .^ 3 + (-0.0165198662527552)
           .* y2 .^ 4 + (0.00548909064326438) .* y2 .^ 5 + (-0.00353615752892107)
           .* y2 .^ 6 + (-0.00984303685396187) .* y2 .^ 7 + (-0.0033093738264456)
           .* y2 .^ 8 + (2.74502945704711e-06) .* x2 .^ 8.*y2 .^ 1 + (-3.61748982871047e-06)
           .* x2 .^ 7.*y2 .^ 1 + (-5.38064234037705e-06) .* x2 .^ 7.*y2 .^ 2 +
          (-4.3048770725053e-05) .* x2 .^ 6.*y2 .^ 1 + (-2.41498361533748e-05)
           .* x2 .^ 6.*y2 .^ 2 + (-4.58516940835319e-06) .* x2 .^ 6.*y2 .^ 3 +
          (0.000210275056813108) .* x2 .^ 5.*y2 .^ 1 + (0.000544157521874485) .*
          x2 .^ 5.*y2 .^ 2 + (0.000479178921972304) .* x2 .^ 5.*y2 .^ 3 + (0.00014173544041628)
           .* x2 .^ 5.*y2 .^ 4 + (-8.1659715995431e-05) .* x2 .^ 4.*y2 .^ 1 +
          (-0.00151824979097779) .* x2 .^ 4.*y2 .^ 2 + (-0.00329032034031329) .*
          x2 .^ 4.*y2 .^ 3 + (-0.00251687289333307) .* x2 .^ 4.*y2 .^ 4 + (-0.00064501646722513)
           .* x2 .^ 4.*y2 .^ 5 + (0.00081043050332391) .* x2 .^ 3.*y2 .^ 1 + (
          -0.00060579516562056) .* x2 .^ 3.*y2 .^ 2 + (0.00420529704478072) .*
          x2 .^ 3.*y2 .^ 3 + (0.0108011510380893) .* x2 .^ 3.*y2 .^ 4 + (0.00783557504988342)
           .* x2 .^ 3.*y2 .^ 5 + (0.00181838166402227) .* x2 .^ 3.*y2 .^ 6 + (
          -0.0126008967427799) .* x2 .^ 2.*y2 .^ 1 + (-0.00721185526704901) .*
          x2 .^ 2.*y2 .^ 2 + (0.0020952709802553) .* x2 .^ 2.*y2 .^ 3 + (-0.00737438124522966)
           .* x2 .^ 2.*y2 .^ 4 + (-0.0198586589754445) .* x2 .^ 2.*y2 .^ 5 + (
          -0.0130316521317318) .* x2 .^ 2.*y2 .^ 6 + (-0.00268476903693715) .*
          x2 .^ 2.*y2 .^ 7 + (0.0790651759889045) .* x2 .^ 1.*y2 .^ 1 + (0.0528486800895992)
           .* x2 .^ 1.*y2 .^ 2 + (0.0197031757182) .* x2 .^ 1.*y2 .^ 3 + (-0.00631626007050606)
           .* x2 .^ 1.*y2 .^ 4 + (0.0082655676765256) .* x2 .^ 1.*y2 .^ 5 + (0.0215232833104674)
           .* x2 .^ 1.*y2 .^ 6 + (0.0105534402562103) .* x2 .^ 1.*y2 .^ 7 + (0.00138543647533724)
           .* x2 .^ 1.*y2 .^ 8);
        d := dewDensity(sat)*(1 - (p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
      end if;
    elseif p < 7377300 then
      if p > sat.psat then
        if p > fitSCrSC then
          //SC
          x2 := (p - 6580996.33416770)/2214553.60520798;
          y2 := (T - 267.837445960128)/20.0905008530052;
          d := 965.064886068137 + 111.097344509587*(0.146947556383107 + (0.116294045193668)
             .* x2 .^ 1 + (-0.00776505941118675) .* x2 .^ 2 + (0.000909338872673313)
             .* x2 .^ 3 + (1.21319825925124e-05) .* x2 .^ 4 + (8.97167217021812e-06)
             .* x2 .^ 5 + (-1.5308353581393e-05) .* x2 .^ 6 + (3.25771277715757e-06)
             .* x2 .^ 7 + (9.90491511851455e-07) .* x2 .^ 8 + (-5.33640713220979e-07)
             .* x2 .^ 9 + (-0.943249296676852) .* y2 .^ 1 + (-0.146272750957203)
             .* y2 .^ 2 + (-0.0570877777084003) .* y2 .^ 3 + (-0.0165198662527552)
             .* y2 .^ 4 + (0.00548909064326438) .* y2 .^ 5 + (-0.00353615752892107)
             .* y2 .^ 6 + (-0.00984303685396187) .* y2 .^ 7 + (-0.0033093738264456)
             .* y2 .^ 8 + (2.74502945704711e-06) .* x2 .^ 8.*y2 .^ 1 + (-3.61748982871047e-06)
             .* x2 .^ 7.*y2 .^ 1 + (-5.38064234037705e-06) .* x2 .^ 7.*y2 .^ 2
             + (-4.3048770725053e-05) .* x2 .^ 6.*y2 .^ 1 + (-2.41498361533748e-05)
             .* x2 .^ 6.*y2 .^ 2 + (-4.58516940835319e-06) .* x2 .^ 6.*y2 .^ 3
             + (0.000210275056813108) .* x2 .^ 5.*y2 .^ 1 + (0.000544157521874485)
             .* x2 .^ 5.*y2 .^ 2 + (0.000479178921972304) .* x2 .^ 5.*y2 .^ 3 +
            (0.00014173544041628) .* x2 .^ 5.*y2 .^ 4 + (-8.1659715995431e-05)
             .* x2 .^ 4.*y2 .^ 1 + (-0.00151824979097779) .* x2 .^ 4.*y2 .^ 2 +
            (-0.00329032034031329) .* x2 .^ 4.*y2 .^ 3 + (-0.00251687289333307)
             .* x2 .^ 4.*y2 .^ 4 + (-0.00064501646722513) .* x2 .^ 4.*y2 .^ 5 +
            (0.00081043050332391) .* x2 .^ 3.*y2 .^ 1 + (-0.00060579516562056)
             .* x2 .^ 3.*y2 .^ 2 + (0.00420529704478072) .* x2 .^ 3.*y2 .^ 3 +
            (0.0108011510380893) .* x2 .^ 3.*y2 .^ 4 + (0.00783557504988342) .*
            x2 .^ 3.*y2 .^ 5 + (0.00181838166402227) .* x2 .^ 3.*y2 .^ 6 + (-0.0126008967427799)
             .* x2 .^ 2.*y2 .^ 1 + (-0.00721185526704901) .* x2 .^ 2.*y2 .^ 2 +
            (0.0020952709802553) .* x2 .^ 2.*y2 .^ 3 + (-0.00737438124522966) .*
            x2 .^ 2.*y2 .^ 4 + (-0.0198586589754445) .* x2 .^ 2.*y2 .^ 5 + (-0.0130316521317318)
             .* x2 .^ 2.*y2 .^ 6 + (-0.00268476903693715) .* x2 .^ 2.*y2 .^ 7 +
            (0.0790651759889045) .* x2 .^ 1.*y2 .^ 1 + (0.0528486800895992) .*
            x2 .^ 1.*y2 .^ 2 + (0.0197031757182) .* x2 .^ 1.*y2 .^ 3 + (-0.00631626007050606)
             .* x2 .^ 1.*y2 .^ 4 + (0.0082655676765256) .* x2 .^ 1.*y2 .^ 5 +
            (0.0215232833104674) .* x2 .^ 1.*y2 .^ 6 + (0.0105534402562103) .*
            x2 .^ 1.*y2 .^ 7 + (0.00138543647533724) .* x2 .^ 1.*y2 .^ 8);
        else
          //Tra1
          x3 := (p - 6852709.62095200)/368334.615439319;
          y3 := (T - 299.418336363026)/2.21937025952538;
          d := 704.553008244752 + 36.8808678865484*(0.135845880999374 + (0.719363093970298)
             .* x3 .^ 1 + (-0.143832578521546) .* x3 .^ 2 + (-0.00677428020013625)
             .* x3 .^ 3 + (-0.109142075831824) .* x3 .^ 4 + (0.233529934336029)
             .* x3 .^ 5 + (-0.0740896896224486) .* x3 .^ 6 + (-0.0935289303414976)
             .* x3 .^ 7 + (0.0540217241160661) .* x3 .^ 8 + (-1.47039015151112)
             .* y3 .^ 1 + (-0.346423384032589) .* y3 .^ 2 + (-0.110733593564551)
             .* y3 .^ 3 + (-0.92303415230304) .* y3 .^ 4 + (-0.516879765074009)
             .* y3 .^ 5 + (1.59172469974569) .* y3 .^ 6 + (0.184986377272869) .*
            y3 .^ 7 + (-1.24718938847469) .* y3 .^ 8 + (-0.445670051500448) .*
            x3 .^ 7.*y3 .^ 1 + (0.958356384051139) .* x3 .^ 6.*y3 .^ 1 + (1.16228220696106)
             .* x3 .^ 6.*y3 .^ 2 + (-0.0289855154958683) .* x3 .^ 5.*y3 .^ 1 +
            (-3.58998939194579) .* x3 .^ 5.*y3 .^ 2 + (-0.129004399097506) .*
            x3 .^ 5.*y3 .^ 3 + (-1.34128011032576) .* x3 .^ 4.*y3 .^ 1 + (1.821389201622)
             .* x3 .^ 4.*y3 .^ 2 + (6.76812384148731) .* x3 .^ 4.*y3 .^ 3 + (-5.23306951084057)
             .* x3 .^ 4.*y3 .^ 4 + (0.864800512536852) .* x3 .^ 3.*y3 .^ 1 + (
            3.05418767658433) .* x3 .^ 3.*y3 .^ 2 + (-5.9718087978886) .* x3 .^
            3.*y3 .^ 3 + (-7.10506535963415) .* x3 .^ 3.*y3 .^ 4 + (11.6298156931156)
             .* x3 .^ 3.*y3 .^ 5 + (-0.071558371185499) .* x3 .^ 2.*y3 .^ 1 +
            (-2.22377895823628) .* x3 .^ 2.*y3 .^ 2 + (-3.50168825072889) .*
            x3 .^ 2.*y3 .^ 3 + (8.53277971454368) .* x3 .^ 2.*y3 .^ 4 + (4.21455824466763)
             .* x3 .^ 2.*y3 .^ 5 + (-11.8052993172531) .* x3 .^ 2.*y3 .^ 6 + (
            0.454694815193594) .* x3 .^ 1.*y3 .^ 1 + (0.192788001262791) .*
            x3 .^ 1.*y3 .^ 2 + (2.3828786960699) .* x3 .^ 1.*y3 .^ 3 + (2.0683975849947)
             .* x3 .^ 1.*y3 .^ 4 + (-5.86951993520384) .* x3 .^ 1.*y3 .^ 5 + (
            -1.33702583693465) .* x3 .^ 1.*y3 .^ 6 + (6.01402520105134) .* x3 .^
            1.*y3 .^ 7);
        end if;
      elseif p < sat.psat then
        if p < fitSCrSH then
          //SH
          x1 := (p - 5519495.79447002)/2567703.39184083;
          y1 := (T - 323.196143266723)/28.5422300266500;
          d := 132.091744019263 + 76.6522972242426*(-0.159545317255397 + (1.01926707118493)
             .* x1 .^ 1 + (0.232721507740677) .* x1 .^ 2 + (0.0637721470284816)
             .* x1 .^ 3 + (0.00697505645251303) .* x1 .^ 4 + (0.0171500109603422)
             .* x1 .^ 5 + (0.0174512144655053) .* x1 .^ 6 + (0.000495265054733816)
             .* x1 .^ 7 + (-0.00265011383145745) .* x1 .^ 8 + (-0.000186293075538892)
             .* x1 .^ 9 + (7.15487921614317e-05) .* x1 .^ 10 + (-0.348266420768099)
             .* y1 .^ 1 + (0.145751418029237) .* y1 .^ 2 + (-0.0626747233532592)
             .* y1 .^ 3 + (-0.0180496910371365) .* y1 .^ 4 + (0.00878813080312919)
             .* y1 .^ 5 + (0.0503931240863202) .* y1 .^ 6 + (-0.0445413553535566)
             .* y1 .^ 7 + (0.0105926422069889) .* y1 .^ 8 + (0.000158640337862594)
             .* x1 .^ 9.*y1 .^ 1 + (0.00417487913241615) .* x1 .^ 8.*y1 .^ 1 +
            (-0.001772613519994) .* x1 .^ 8.*y1 .^ 2 + (0.00824627937624933) .*
            x1 .^ 7.*y1 .^ 1 + (-0.0149332490903717) .* x1 .^ 7.*y1 .^ 2 + (0.00595637375150662)
             .* x1 .^ 7.*y1 .^ 3 + (-0.0490519008171776) .* x1 .^ 6.*y1 .^ 1 +
            (0.0547644631894267) .* x1 .^ 6.*y1 .^ 2 + (-0.0294054443156379) .*
            x1 .^ 6.*y1 .^ 3 + (0.00644113577382396) .* x1 .^ 6.*y1 .^ 4 + (-0.141050144830697)
             .* x1 .^ 5.*y1 .^ 1 + (0.331124788177358) .* x1 .^ 5.*y1 .^ 2 + (
            -0.361637858402444) .* x1 .^ 5.*y1 .^ 3 + (0.199845308894148) .*
            x1 .^ 5.*y1 .^ 4 + (-0.0445539243958295) .* x1 .^ 5.*y1 .^ 5 + (-0.0895191026576243)
             .* x1 .^ 4.*y1 .^ 1 + (0.435000419295625) .* x1 .^ 4.*y1 .^ 2 + (
            -0.855765252276763) .* x1 .^ 4.*y1 .^ 3 + (0.794279259209092) .*
            x1 .^ 4.*y1 .^ 4 + (-0.349305438078168) .* x1 .^ 4.*y1 .^ 5 + (0.0587289941449)
             .* x1 .^ 4.*y1 .^ 6 + (-0.0673246981760775) .* x1 .^ 3.*y1 .^ 1 +
            (0.152276713823781) .* x1 .^ 3.*y1 .^ 2 + (-0.658989014138355) .*
            x1 .^ 3.*y1 .^ 3 + (1.12099169078695) .* x1 .^ 3.*y1 .^ 4 + (-0.852220059293641)
             .* x1 .^ 3.*y1 .^ 5 + (0.284103442427349) .* x1 .^ 3.*y1 .^ 6 + (
            -0.030598075669132) .* x1 .^ 3.*y1 .^ 7 + (-0.274835535466439) .*
            x1 .^ 2.*y1 .^ 1 + (0.10521659327455) .* x1 .^ 2.*y1 .^ 2 + (-0.0817699019842939)
             .* x1 .^ 2.*y1 .^ 3 + (0.540205525921847) .* x1 .^ 2.*y1 .^ 4 + (
            -0.805704737418588) .* x1 .^ 2.*y1 .^ 5 + (0.473195595542273) .*
            x1 .^ 2.*y1 .^ 6 + (-0.10962351779232) .* x1 .^ 2.*y1 .^ 7 + (0.00553839782424903)
             .* x1 .^ 2.*y1 .^ 8 + (-0.456453407756215) .* x1 .^ 1.*y1 .^ 1 +
            (0.257424821666076) .* x1 .^ 1.*y1 .^ 2 + (-0.0207597004660533) .*
            x1 .^ 1.*y1 .^ 3 + (-0.00617607581669293) .* x1 .^ 1.*y1 .^ 4 + (-0.243348931432783)
             .* x1 .^ 1.*y1 .^ 5 + (0.301605652645551) .* x1 .^ 1.*y1 .^ 6 + (
            -0.124499607368792) .* x1 .^ 1.*y1 .^ 7 + (0.0155731352048423) .*
            x1 .^ 1.*y1 .^ 8);
        else
          //Tra2
          x4 := (p - 6861842.26287351)/347737.370667184;
          y4 := (T - 302.285863550535)/2.84807263925339;
          d := 257.726989037258 + 26.6787183136241*(-0.0742000467430081 + (2.22649996975207)
             .* x4 .^ 1 + (1.01975258967193) .* x4 .^ 2 + (0.681752653361671) .*
            x4 .^ 3 + (0.806681869840231) .* x4 .^ 4 + (1.34425793259501) .*
            x4 .^ 5 + (1.27563381891941) .* x4 .^ 6 + (1.05490116604965) .*
            x4 .^ 7 + (2.32643489453363) .* x4 .^ 8 + (-1.60187112581113) .*
            y4 .^ 1 + (0.857703105187753) .* y4 .^ 2 + (-0.519440286366421) .*
            y4 .^ 3 + (1.63459388173288) .* y4 .^ 4 + (-3.19700566121067) .*
            y4 .^ 5 + (-1.45763557058898) .* y4 .^ 6 + (2.85349024893583) .*
            y4 .^ 7 + (2.07427827128384) .* y4 .^ 8 + (-11.8920334966292) .*
            x4 .^ 7.*y4 .^ 1 + (-7.94604371709061) .* x4 .^ 6.*y4 .^ 1 + (21.3850074890077)
             .* x4 .^ 6.*y4 .^ 2 + (-8.19255600923722) .* x4 .^ 5.*y4 .^ 1 + (
            20.9408663247199) .* x4 .^ 5.*y4 .^ 2 + (-12.0832489291568) .* x4 .^
            5.*y4 .^ 3 + (-8.26459985905332) .* x4 .^ 4.*y4 .^ 1 + (19.5456217495361)
             .* x4 .^ 4.*y4 .^ 2 + (-22.2703898711861) .* x4 .^ 4.*y4 .^ 3 + (
            -7.0363400358898) .* x4 .^ 4.*y4 .^ 4 + (-3.80930033551582) .* x4 .^
            3.*y4 .^ 1 + (19.9983534650838) .* x4 .^ 3.*y4 .^ 2 + (-20.7750562890685)
             .* x4 .^ 3.*y4 .^ 3 + (1.98016683621984) .* x4 .^ 3.*y4 .^ 4 + (7.21891450978607)
             .* x4 .^ 3.*y4 .^ 5 + (-1.94317929696451) .* x4 .^ 2.*y4 .^ 1 + (
            6.79031350570749) .* x4 .^ 2.*y4 .^ 2 + (-23.80107516308) .* x4 .^
            2.*y4 .^ 3 + (7.84741270356864) .* x4 .^ 2.*y4 .^ 4 + (15.3453351868259)
             .* x4 .^ 2.*y4 .^ 5 + (5.22137734349163) .* x4 .^ 2.*y4 .^ 6 + (-1.92418534367314)
             .* x4 .^ 1.*y4 .^ 1 + (1.77417183954536) .* x4 .^ 1.*y4 .^ 2 + (-5.42171296492636)
             .* x4 .^ 1.*y4 .^ 3 + (13.9194740586787) .* x4 .^ 1.*y4 .^ 4 + (1.75632331127751)
             .* x4 .^ 1.*y4 .^ 5 + (-11.9582623667767) .* x4 .^ 1.*y4 .^ 6 + (
            -7.21436484271673) .* x4 .^ 1.*y4 .^ 7);
        end if;
      end if;
    elseif p < 7596000 then
      if p > fitSCrSC then
        //SC
        x2 := (p - 6580996.33416770)/2214553.60520798;
        y2 := (T - 267.837445960128)/20.0905008530052;
        d := 965.064886068137 + 111.097344509587*(0.146947556383107 + (0.116294045193668)
           .* x2 .^ 1 + (-0.00776505941118675) .* x2 .^ 2 + (0.000909338872673313)
           .* x2 .^ 3 + (1.21319825925124e-05) .* x2 .^ 4 + (8.97167217021812e-06)
           .* x2 .^ 5 + (-1.5308353581393e-05) .* x2 .^ 6 + (3.25771277715757e-06)
           .* x2 .^ 7 + (9.90491511851455e-07) .* x2 .^ 8 + (-5.33640713220979e-07)
           .* x2 .^ 9 + (-0.943249296676852) .* y2 .^ 1 + (-0.146272750957203)
           .* y2 .^ 2 + (-0.0570877777084003) .* y2 .^ 3 + (-0.0165198662527552)
           .* y2 .^ 4 + (0.00548909064326438) .* y2 .^ 5 + (-0.00353615752892107)
           .* y2 .^ 6 + (-0.00984303685396187) .* y2 .^ 7 + (-0.0033093738264456)
           .* y2 .^ 8 + (2.74502945704711e-06) .* x2 .^ 8.*y2 .^ 1 + (-3.61748982871047e-06)
           .* x2 .^ 7.*y2 .^ 1 + (-5.38064234037705e-06) .* x2 .^ 7.*y2 .^ 2 +
          (-4.3048770725053e-05) .* x2 .^ 6.*y2 .^ 1 + (-2.41498361533748e-05)
           .* x2 .^ 6.*y2 .^ 2 + (-4.58516940835319e-06) .* x2 .^ 6.*y2 .^ 3 +
          (0.000210275056813108) .* x2 .^ 5.*y2 .^ 1 + (0.000544157521874485) .*
          x2 .^ 5.*y2 .^ 2 + (0.000479178921972304) .* x2 .^ 5.*y2 .^ 3 + (0.00014173544041628)
           .* x2 .^ 5.*y2 .^ 4 + (-8.1659715995431e-05) .* x2 .^ 4.*y2 .^ 1 +
          (-0.00151824979097779) .* x2 .^ 4.*y2 .^ 2 + (-0.00329032034031329) .*
          x2 .^ 4.*y2 .^ 3 + (-0.00251687289333307) .* x2 .^ 4.*y2 .^ 4 + (-0.00064501646722513)
           .* x2 .^ 4.*y2 .^ 5 + (0.00081043050332391) .* x2 .^ 3.*y2 .^ 1 + (
          -0.00060579516562056) .* x2 .^ 3.*y2 .^ 2 + (0.00420529704478072) .*
          x2 .^ 3.*y2 .^ 3 + (0.0108011510380893) .* x2 .^ 3.*y2 .^ 4 + (0.00783557504988342)
           .* x2 .^ 3.*y2 .^ 5 + (0.00181838166402227) .* x2 .^ 3.*y2 .^ 6 + (
          -0.0126008967427799) .* x2 .^ 2.*y2 .^ 1 + (-0.00721185526704901) .*
          x2 .^ 2.*y2 .^ 2 + (0.0020952709802553) .* x2 .^ 2.*y2 .^ 3 + (-0.00737438124522966)
           .* x2 .^ 2.*y2 .^ 4 + (-0.0198586589754445) .* x2 .^ 2.*y2 .^ 5 + (
          -0.0130316521317318) .* x2 .^ 2.*y2 .^ 6 + (-0.00268476903693715) .*
          x2 .^ 2.*y2 .^ 7 + (0.0790651759889045) .* x2 .^ 1.*y2 .^ 1 + (0.0528486800895992)
           .* x2 .^ 1.*y2 .^ 2 + (0.0197031757182) .* x2 .^ 1.*y2 .^ 3 + (-0.00631626007050606)
           .* x2 .^ 1.*y2 .^ 4 + (0.0082655676765256) .* x2 .^ 1.*y2 .^ 5 + (0.0215232833104674)
           .* x2 .^ 1.*y2 .^ 6 + (0.0105534402562103) .* x2 .^ 1.*y2 .^ 7 + (0.00138543647533724)
           .* x2 .^ 1.*y2 .^ 8);
      elseif p > fitSCrSH then
        //SCr1
        x5 := (p - 7488199.23411845)/62889.7280539712;
        y5 := (T - 304.404980852962)/2.55548710649952;
        d := 502.791087299023 + 188.231268663898*(0.304013073549779 + (0.382682749064843)
           .* x5 .^ 1 + (-0.0750567550491341) .* x5 .^ 2 + (-0.000223893287424328)
           .* x5 .^ 3 + (-0.00723892174894502) .* x5 .^ 4 + (-0.00105687890148851)
           .* x5 .^ 5 + (-2.8196783717657) .* y5 .^ 1 + (-3.41417202599996) .*
          y5 .^ 2 + (5.17072673723431) .* y5 .^ 3 + (9.85914701294718) .* y5 .^
          4 + (-5.33332570627995) .* y5 .^ 5 + (-10.7619841720735) .* y5 .^ 6 +
          (-0.294534601533758) .* y5 .^ 7 + (0.8270214389675) .* y5 .^ 8 + (5.64427079559404)
           .* y5 .^ 9 + (8.39699311793481) .* y5 .^ 10 + (-5.28003080295355) .*
          y5 .^ 11 + (-8.01534032361643) .* y5 .^ 12 + (2.26477397092984) .*
          y5 .^ 13 + (3.42182835468905) .* y5 .^ 14 + (-0.478740266813957) .*
          y5 .^ 15 + (-0.729412055372201) .* y5 .^ 16 + (0.0402498048273301) .*
          y5 .^ 17 + (0.0659469270328488) .* y5 .^ 18 + (1.73816994693414e-05)
           .* y5 .^ 19 + (-0.000818109462178529) .* y5 .^ 20 + (-0.0239025875618387)
           .* y5 .^ 19.*x5 .^ 1 + (-0.0248343008319824) .* y5 .^ 18.*x5 .^ 1 +
          (0.0305228166295861) .* y5 .^ 18.*x5 .^ 2 + (0.2136957766027) .* y5 .^
          17.*x5 .^ 1 + (0.0347421699645147) .* y5 .^ 17.*x5 .^ 2 + (0.00893272176390704)
           .* y5 .^ 17.*x5 .^ 3 + (0.227531425062744) .* y5 .^ 16.*x5 .^ 1 + (
          -0.205605014972184) .* y5 .^ 16.*x5 .^ 2 + (-0.0312504060728272) .*
          y5 .^ 16.*x5 .^ 3 + (-0.0256046029848927) .* y5 .^ 16.*x5 .^ 4 + (-0.736131347013044)
           .* y5 .^ 15.*x5 .^ 1 + (-0.234933726127396) .* y5 .^ 15.*x5 .^ 2 +
          (-0.271377999899265) .* y5 .^ 15.*x5 .^ 3 + (0.014298111354649) .*
          y5 .^ 15.*x5 .^ 4 + (0.00701444241949667) .* y5 .^ 15.*x5 .^ 5 + (-0.774801202977496)
           .* y5 .^ 14.*x5 .^ 1 + (0.282465436357707) .* y5 .^ 14.*x5 .^ 2 + (
          0.177261013514976) .* y5 .^ 14.*x5 .^ 3 + (0.365550705913221) .* y5 .^
          14.*x5 .^ 4 + (-0.00107109438495431) .* y5 .^ 14.*x5 .^ 5 + (1.575018232509)
           .* y5 .^ 13.*x5 .^ 1 + (0.34174575120479) .* y5 .^ 13.*x5 .^ 2 + (1.9788141786499)
           .* y5 .^ 13.*x5 .^ 3 + (-0.0673602700761091) .* y5 .^ 13.*x5 .^ 4 +
          (-0.0822378521404984) .* y5 .^ 13.*x5 .^ 5 + (1.21666014254253) .*
          y5 .^ 12.*x5 .^ 1 + (0.927542830337458) .* y5 .^ 12.*x5 .^ 2 + (-0.132068917685318)
           .* y5 .^ 12.*x5 .^ 3 + (-1.93915329996032) .* y5 .^ 12.*x5 .^ 4 + (
          -0.00804555257078432) .* y5 .^ 12.*x5 .^ 5 + (-4.19589209577525) .*
          y5 .^ 11.*x5 .^ 1 + (1.0096820180987) .* y5 .^ 11.*x5 .^ 2 + (-6.44231807936063)
           .* y5 .^ 11.*x5 .^ 3 + (0.0209572814353714) .* y5 .^ 11.*x5 .^ 4 +
          (0.361364635947953) .* y5 .^ 11.*x5 .^ 5 + (-1.23313630320879) .*
          y5 .^ 10.*x5 .^ 1 + (-3.10023370075194) .* y5 .^ 10.*x5 .^ 2 + (-1.04676941730794)
           .* y5 .^ 10.*x5 .^ 3 + (5.11004587796162) .* y5 .^ 10.*x5 .^ 4 + (0.0792432987181176)
           .* y5 .^ 10.*x5 .^ 5 + (11.6861174882345) .* y5 .^ 9.*x5 .^ 1 + (-3.87239796148213)
           .* y5 .^ 9.*x5 .^ 2 + (10.9274847631813) .* y5 .^ 9.*x5 .^ 3 + (0.365516248648382)
           .* y5 .^ 9.*x5 .^ 4 + (-0.793258492917212) .* y5 .^ 9.*x5 .^ 5 + (2.43430754002441)
           .* y5 .^ 8.*x5 .^ 1 + (2.42389847805002) .* y5 .^ 8.*x5 .^ 2 + (2.86977312307346)
           .* y5 .^ 8.*x5 .^ 3 + (-7.27894300795405) .* y5 .^ 8.*x5 .^ 4 + (-0.209281771480703)
           .* y5 .^ 8.*x5 .^ 5 + (-19.8119932825305) .* y5 .^ 7.*x5 .^ 1 + (4.60782809076787)
           .* y5 .^ 7.*x5 .^ 2 + (-9.96178366405222) .* y5 .^ 7.*x5 .^ 3 + (-0.756621067273977)
           .* y5 .^ 7.*x5 .^ 4 + (0.965432496999922) .* y5 .^ 7.*x5 .^ 5 + (-4.91432521097021)
           .* y5 .^ 6.*x5 .^ 1 + (1.29511905647798) .* y5 .^ 6.*x5 .^ 2 + (-2.90724949919789)
           .* y5 .^ 6.*x5 .^ 3 + (5.57528840859557) .* y5 .^ 6.*x5 .^ 4 + (0.241149293198011)
           .* y5 .^ 6.*x5 .^ 5 + (17.6421086915984) .* y5 .^ 5.*x5 .^ 1 + (-1.99484644810224)
           .* y5 .^ 5.*x5 .^ 2 + (4.67455981856453) .* y5 .^ 5.*x5 .^ 3 + (0.591116013386306)
           .* y5 .^ 5.*x5 .^ 4 + (-0.669399393217854) .* y5 .^ 5.*x5 .^ 5 + (4.89206083764975)
           .* y5 .^ 4.*x5 .^ 1 + (-2.59565656168885) .* y5 .^ 4.*x5 .^ 2 + (1.22666540502198)
           .* y5 .^ 4.*x5 .^ 3 + (-2.09911501799096) .* y5 .^ 4.*x5 .^ 4 + (-0.127494532880646)
           .* y5 .^ 4.*x5 .^ 5 + (-7.49233157081911) .* y5 .^ 3.*x5 .^ 1 + (-0.0316179463436961)
           .* y5 .^ 3.*x5 .^ 2 + (-0.981586537819711) .* y5 .^ 3.*x5 .^ 3 + (-0.186803461740571)
           .* y5 .^ 3.*x5 .^ 4 + (0.243235539839399) .* y5 .^ 3.*x5 .^ 5 + (-2.15407355519074)
           .* y5 .^ 2.*x5 .^ 1 + (1.01411931124914) .* y5 .^ 2.*x5 .^ 2 + (-0.161725072484494)
           .* y5 .^ 2.*x5 .^ 3 + (0.303414854100221) .* y5 .^ 2.*x5 .^ 4 + (0.0269323343731469)
           .* y5 .^ 2.*x5 .^ 5 + (1.18489138901916) .* y5 .^ 1.*x5 .^ 1 + (0.148171677668715)
           .* y5 .^ 1.*x5 .^ 2 + (0.0591984575408013) .* y5 .^ 1.*x5 .^ 3 + (0.0181643295574899)
           .* y5 .^ 1.*x5 .^ 4 + (-0.0316155978449693) .* y5 .^ 1.*x5 .^ 5);
      else
        //SH
        x1 := (p - 5519495.79447002)/2567703.39184083;
        y1 := (T - 323.196143266723)/28.5422300266500;
        d := 132.091744019263 + 76.6522972242426*(-0.159545317255397 + (1.01926707118493)
           .* x1 .^ 1 + (0.232721507740677) .* x1 .^ 2 + (0.0637721470284816) .*
          x1 .^ 3 + (0.00697505645251303) .* x1 .^ 4 + (0.0171500109603422) .*
          x1 .^ 5 + (0.0174512144655053) .* x1 .^ 6 + (0.000495265054733816) .*
          x1 .^ 7 + (-0.00265011383145745) .* x1 .^ 8 + (-0.000186293075538892)
           .* x1 .^ 9 + (7.15487921614317e-05) .* x1 .^ 10 + (-0.348266420768099)
           .* y1 .^ 1 + (0.145751418029237) .* y1 .^ 2 + (-0.0626747233532592)
           .* y1 .^ 3 + (-0.0180496910371365) .* y1 .^ 4 + (0.00878813080312919)
           .* y1 .^ 5 + (0.0503931240863202) .* y1 .^ 6 + (-0.0445413553535566)
           .* y1 .^ 7 + (0.0105926422069889) .* y1 .^ 8 + (0.000158640337862594)
           .* x1 .^ 9.*y1 .^ 1 + (0.00417487913241615) .* x1 .^ 8.*y1 .^ 1 + (
          -0.001772613519994) .* x1 .^ 8.*y1 .^ 2 + (0.00824627937624933) .*
          x1 .^ 7.*y1 .^ 1 + (-0.0149332490903717) .* x1 .^ 7.*y1 .^ 2 + (0.00595637375150662)
           .* x1 .^ 7.*y1 .^ 3 + (-0.0490519008171776) .* x1 .^ 6.*y1 .^ 1 + (
          0.0547644631894267) .* x1 .^ 6.*y1 .^ 2 + (-0.0294054443156379) .*
          x1 .^ 6.*y1 .^ 3 + (0.00644113577382396) .* x1 .^ 6.*y1 .^ 4 + (-0.141050144830697)
           .* x1 .^ 5.*y1 .^ 1 + (0.331124788177358) .* x1 .^ 5.*y1 .^ 2 + (-0.361637858402444)
           .* x1 .^ 5.*y1 .^ 3 + (0.199845308894148) .* x1 .^ 5.*y1 .^ 4 + (-0.0445539243958295)
           .* x1 .^ 5.*y1 .^ 5 + (-0.0895191026576243) .* x1 .^ 4.*y1 .^ 1 + (
          0.435000419295625) .* x1 .^ 4.*y1 .^ 2 + (-0.855765252276763) .* x1 .^
          4.*y1 .^ 3 + (0.794279259209092) .* x1 .^ 4.*y1 .^ 4 + (-0.349305438078168)
           .* x1 .^ 4.*y1 .^ 5 + (0.0587289941449) .* x1 .^ 4.*y1 .^ 6 + (-0.0673246981760775)
           .* x1 .^ 3.*y1 .^ 1 + (0.152276713823781) .* x1 .^ 3.*y1 .^ 2 + (-0.658989014138355)
           .* x1 .^ 3.*y1 .^ 3 + (1.12099169078695) .* x1 .^ 3.*y1 .^ 4 + (-0.852220059293641)
           .* x1 .^ 3.*y1 .^ 5 + (0.284103442427349) .* x1 .^ 3.*y1 .^ 6 + (-0.030598075669132)
           .* x1 .^ 3.*y1 .^ 7 + (-0.274835535466439) .* x1 .^ 2.*y1 .^ 1 + (0.10521659327455)
           .* x1 .^ 2.*y1 .^ 2 + (-0.0817699019842939) .* x1 .^ 2.*y1 .^ 3 + (
          0.540205525921847) .* x1 .^ 2.*y1 .^ 4 + (-0.805704737418588) .* x1 .^
          2.*y1 .^ 5 + (0.473195595542273) .* x1 .^ 2.*y1 .^ 6 + (-0.10962351779232)
           .* x1 .^ 2.*y1 .^ 7 + (0.00553839782424903) .* x1 .^ 2.*y1 .^ 8 + (
          -0.456453407756215) .* x1 .^ 1.*y1 .^ 1 + (0.257424821666076) .* x1 .^
          1.*y1 .^ 2 + (-0.0207597004660533) .* x1 .^ 1.*y1 .^ 3 + (-0.00617607581669293)
           .* x1 .^ 1.*y1 .^ 4 + (-0.243348931432783) .* x1 .^ 1.*y1 .^ 5 + (0.301605652645551)
           .* x1 .^ 1.*y1 .^ 6 + (-0.124499607368792) .* x1 .^ 1.*y1 .^ 7 + (0.0155731352048423)
           .* x1 .^ 1.*y1 .^ 8);
      end if;
    elseif p > 7596000 then
      //SC or SCr2 or SH
      if p > fitSCrSC then
        //SC
        x2 := (p - 6580996.33416770)/2214553.60520798;
        y2 := (T - 267.837445960128)/20.0905008530052;
        d := 965.064886068137 + 111.097344509587*(0.146947556383107 + (0.116294045193668)
           .* x2 .^ 1 + (-0.00776505941118675) .* x2 .^ 2 + (0.000909338872673313)
           .* x2 .^ 3 + (1.21319825925124e-05) .* x2 .^ 4 + (8.97167217021812e-06)
           .* x2 .^ 5 + (-1.5308353581393e-05) .* x2 .^ 6 + (3.25771277715757e-06)
           .* x2 .^ 7 + (9.90491511851455e-07) .* x2 .^ 8 + (-5.33640713220979e-07)
           .* x2 .^ 9 + (-0.943249296676852) .* y2 .^ 1 + (-0.146272750957203)
           .* y2 .^ 2 + (-0.0570877777084003) .* y2 .^ 3 + (-0.0165198662527552)
           .* y2 .^ 4 + (0.00548909064326438) .* y2 .^ 5 + (-0.00353615752892107)
           .* y2 .^ 6 + (-0.00984303685396187) .* y2 .^ 7 + (-0.0033093738264456)
           .* y2 .^ 8 + (2.74502945704711e-06) .* x2 .^ 8.*y2 .^ 1 + (-3.61748982871047e-06)
           .* x2 .^ 7.*y2 .^ 1 + (-5.38064234037705e-06) .* x2 .^ 7.*y2 .^ 2 +
          (-4.3048770725053e-05) .* x2 .^ 6.*y2 .^ 1 + (-2.41498361533748e-05)
           .* x2 .^ 6.*y2 .^ 2 + (-4.58516940835319e-06) .* x2 .^ 6.*y2 .^ 3 +
          (0.000210275056813108) .* x2 .^ 5.*y2 .^ 1 + (0.000544157521874485) .*
          x2 .^ 5.*y2 .^ 2 + (0.000479178921972304) .* x2 .^ 5.*y2 .^ 3 + (0.00014173544041628)
           .* x2 .^ 5.*y2 .^ 4 + (-8.1659715995431e-05) .* x2 .^ 4.*y2 .^ 1 +
          (-0.00151824979097779) .* x2 .^ 4.*y2 .^ 2 + (-0.00329032034031329) .*
          x2 .^ 4.*y2 .^ 3 + (-0.00251687289333307) .* x2 .^ 4.*y2 .^ 4 + (-0.00064501646722513)
           .* x2 .^ 4.*y2 .^ 5 + (0.00081043050332391) .* x2 .^ 3.*y2 .^ 1 + (
          -0.00060579516562056) .* x2 .^ 3.*y2 .^ 2 + (0.00420529704478072) .*
          x2 .^ 3.*y2 .^ 3 + (0.0108011510380893) .* x2 .^ 3.*y2 .^ 4 + (0.00783557504988342)
           .* x2 .^ 3.*y2 .^ 5 + (0.00181838166402227) .* x2 .^ 3.*y2 .^ 6 + (
          -0.0126008967427799) .* x2 .^ 2.*y2 .^ 1 + (-0.00721185526704901) .*
          x2 .^ 2.*y2 .^ 2 + (0.0020952709802553) .* x2 .^ 2.*y2 .^ 3 + (-0.00737438124522966)
           .* x2 .^ 2.*y2 .^ 4 + (-0.0198586589754445) .* x2 .^ 2.*y2 .^ 5 + (
          -0.0130316521317318) .* x2 .^ 2.*y2 .^ 6 + (-0.00268476903693715) .*
          x2 .^ 2.*y2 .^ 7 + (0.0790651759889045) .* x2 .^ 1.*y2 .^ 1 + (0.0528486800895992)
           .* x2 .^ 1.*y2 .^ 2 + (0.0197031757182) .* x2 .^ 1.*y2 .^ 3 + (-0.00631626007050606)
           .* x2 .^ 1.*y2 .^ 4 + (0.0082655676765256) .* x2 .^ 1.*y2 .^ 5 + (0.0215232833104674)
           .* x2 .^ 1.*y2 .^ 6 + (0.0105534402562103) .* x2 .^ 1.*y2 .^ 7 + (0.00138543647533724)
           .* x2 .^ 1.*y2 .^ 8);
      elseif p > fitSCrSH then
        //SCr2
        x6 := (p - 8748123.91098647)/655717.790955289;
        y6 := (T - 311.141099137607)/5.06539198333898;
        d := 520.141191712727 + 132.771461173216*(0.0139611877532139 + (1.37348576442167)
           .* x6 .^ 1 + (-1.01704457103339) .* x6 .^ 2 + (0.175752018382295) .*
          x6 .^ 3 + (1.1725373853576) .* x6 .^ 4 + (-0.937244770015876) .* x6 .^
          5 + (-0.660869409286897) .* x6 .^ 6 + (0.689084577961732) .* x6 .^ 7
           + (0.137015588840619) .* x6 .^ 8 + (-0.157700659582568) .* x6 .^ 9 +
          (-2.12109458913731) .* y6 .^ 1 + (-0.496057269759184) .* y6 .^ 2 + (
          1.83013675295057) .* y6 .^ 3 + (0.60953744102314) .* y6 .^ 4 + (-1.25055432090773)
           .* y6 .^ 5 + (0.627207010277484) .* y6 .^ 6 + (-1.86393630103613) .*
          y6 .^ 7 + (-1.29920307304523) .* y6 .^ 8 + (4.5501940038945) .* y6 .^
          9 + (-0.0748785506661268) .* y6 .^ 10 + (-3.22187841503096) .* y6 .^
          11 + (0.847537393484354) .* y6 .^ 12 + (0.74784977119721) .* y6 .^ 13
           + (-0.298178012233055) .* y6 .^ 14 + (1.16803534940368) .* y6 .^ 13.
          *x6 .^ 1 + (-2.81913154341892) .* y6 .^ 12.*x6 .^ 1 + (-1.45567554833954)
           .* y6 .^ 12.*x6 .^ 2 + (-2.05116651593688) .* y6 .^ 11.*x6 .^ 1 + (
          2.92431738126174) .* y6 .^ 11.*x6 .^ 2 + (0.0212016834650578) .* y6 .^
          11.*x6 .^ 3 + (9.9141786997896) .* y6 .^ 10.*x6 .^ 1 + (0.290430870605899)
           .* y6 .^ 10.*x6 .^ 2 + (1.84204174205785) .* y6 .^ 10.*x6 .^ 3 + (1.2102371939289)
           .* y6 .^ 10.*x6 .^ 4 + (-3.09479174637471) .* y6 .^ 9.*x6 .^ 1 + (-7.69716462462876)
           .* y6 .^ 9.*x6 .^ 2 + (2.76788877452717) .* y6 .^ 9.*x6 .^ 3 + (-5.12275362933523)
           .* y6 .^ 9.*x6 .^ 4 + (-0.177511479328071) .* y6 .^ 9.*x6 .^ 5 + (-8.79851794598821)
           .* y6 .^ 8.*x6 .^ 1 + (9.02247377259854) .* y6 .^ 8.*x6 .^ 2 + (-5.39472655492837)
           .* y6 .^ 8.*x6 .^ 3 + (-1.02954630612805) .* y6 .^ 8.*x6 .^ 4 + (-0.0171595988573145)
           .* y6 .^ 8.*x6 .^ 5 + (-1.34439362630212) .* y6 .^ 8.*x6 .^ 6 + (5.18924490728675)
           .* y6 .^ 7.*x6 .^ 1 + (-1.05851644958068) .* y6 .^ 7.*x6 .^ 2 + (-7.34127944833216)
           .* y6 .^ 7.*x6 .^ 3 + (8.20950433571891) .* y6 .^ 7.*x6 .^ 4 + (-3.35935525540068)
           .* y6 .^ 7.*x6 .^ 5 + (7.52724517163994) .* y6 .^ 7.*x6 .^ 6 + (1.24058029448972)
           .* y6 .^ 7.*x6 .^ 7 + (-1.51000934887228) .* y6 .^ 6.*x6 .^ 1 + (-2.83198221818727)
           .* y6 .^ 6.*x6 .^ 2 + (11.2340232855916) .* y6 .^ 6.*x6 .^ 3 + (-2.03601598635689)
           .* y6 .^ 6.*x6 .^ 4 + (5.12492667983285) .* y6 .^ 6.*x6 .^ 5 + (3.75118458994685)
           .* y6 .^ 6.*x6 .^ 6 + (-8.24946254733588) .* y6 .^ 6.*x6 .^ 7 + (-0.382571152053025)
           .* y6 .^ 6.*x6 .^ 8 + (1.67824241809135) .* y6 .^ 5.*x6 .^ 1 + (9.17603160047254)
           .* y6 .^ 5.*x6 .^ 2 + (-9.19751576616594) .* y6 .^ 5.*x6 .^ 3 + (-1.4543669492043)
           .* y6 .^ 5.*x6 .^ 4 + (6.08562473730137) .* y6 .^ 5.*x6 .^ 5 + (-14.6494439545351)
           .* y6 .^ 5.*x6 .^ 6 + (-1.07829273027014) .* y6 .^ 5.*x6 .^ 7 + (3.91207074919363)
           .* y6 .^ 5.*x6 .^ 8 + (0.0158676162432742) .* y6 .^ 5.*x6 .^ 9 + (5.52339218082805)
           .* y6 .^ 4.*x6 .^ 1 + (-10.6595314290636) .* y6 .^ 4.*x6 .^ 2 + (-4.8074687849469)
           .* y6 .^ 4.*x6 .^ 3 + (15.4783630576435) .* y6 .^ 4.*x6 .^ 4 + (-12.9208249362613)
           .* y6 .^ 4.*x6 .^ 5 + (-2.68514348775898) .* y6 .^ 4.*x6 .^ 6 + (11.2826357473987)
           .* y6 .^ 4.*x6 .^ 7 + (-0.371767827147198) .* y6 .^ 4.*x6 .^ 8 + (-0.745510861965781)
           .* y6 .^ 4.*x6 .^ 9 + (-4.38544686982793) .* y6 .^ 3.*x6 .^ 1 + (-5.12291744036501)
           .* y6 .^ 3.*x6 .^ 2 + (15.7111663368957) .* y6 .^ 3.*x6 .^ 3 + (-6.28598799206508)
           .* y6 .^ 3.*x6 .^ 4 + (-9.88933800795835) .* y6 .^ 3.*x6 .^ 5 + (12.9949902203968)
           .* y6 .^ 3.*x6 .^ 6 + (-0.271657627960563) .* y6 .^ 3.*x6 .^ 7 + (-4.3849452671122)
           .* y6 .^ 3.*x6 .^ 8 + (0.264503945768068) .* y6 .^ 3.*x6 .^ 9 + (-3.17235241931712)
           .* y6 .^ 2.*x6 .^ 1 + (7.18430003854582) .* y6 .^ 2.*x6 .^ 2 + (-0.42825421641312)
           .* y6 .^ 2.*x6 .^ 3 + (-10.1711899596684) .* y6 .^ 2.*x6 .^ 4 + (7.74864183860309)
           .* y6 .^ 2.*x6 .^ 5 + (3.05561780651464) .* y6 .^ 2.*x6 .^ 6 + (-5.40265226218143)
           .* y6 .^ 2.*x6 .^ 7 + (0.448421804508581) .* y6 .^ 2.*x6 .^ 8 + (0.821094599023782)
           .* y6 .^ 2.*x6 .^ 9 + (1.69343393778883) .* y6 .^ 1.*x6 .^ 1 + (1.17919337426358)
           .* y6 .^ 1.*x6 .^ 2 + (-4.31300591444439) .* y6 .^ 1.*x6 .^ 3 + (2.30992667422972)
           .* y6 .^ 1.*x6 .^ 4 + (2.91186503856618) .* y6 .^ 1.*x6 .^ 5 + (-3.17735080554194)
           .* y6 .^ 1.*x6 .^ 6 + (-0.215034001696591) .* y6 .^ 1.*x6 .^ 7 + (1.00687697904626)
           .* y6 .^ 1.*x6 .^ 8 + (-0.216082822197661) .* y6 .^ 1.*x6 .^ 9);
      else
        //SH
        x1 := (p - 5519495.79447002)/2567703.39184083;
        y1 := (T - 323.196143266723)/28.5422300266500;
        d := 132.091744019263 + 76.6522972242426*(-0.159545317255397 + (1.01926707118493)
           .* x1 .^ 1 + (0.232721507740677) .* x1 .^ 2 + (0.0637721470284816) .*
          x1 .^ 3 + (0.00697505645251303) .* x1 .^ 4 + (0.0171500109603422) .*
          x1 .^ 5 + (0.0174512144655053) .* x1 .^ 6 + (0.000495265054733816) .*
          x1 .^ 7 + (-0.00265011383145745) .* x1 .^ 8 + (-0.000186293075538892)
           .* x1 .^ 9 + (7.15487921614317e-05) .* x1 .^ 10 + (-0.348266420768099)
           .* y1 .^ 1 + (0.145751418029237) .* y1 .^ 2 + (-0.0626747233532592)
           .* y1 .^ 3 + (-0.0180496910371365) .* y1 .^ 4 + (0.00878813080312919)
           .* y1 .^ 5 + (0.0503931240863202) .* y1 .^ 6 + (-0.0445413553535566)
           .* y1 .^ 7 + (0.0105926422069889) .* y1 .^ 8 + (0.000158640337862594)
           .* x1 .^ 9.*y1 .^ 1 + (0.00417487913241615) .* x1 .^ 8.*y1 .^ 1 + (
          -0.001772613519994) .* x1 .^ 8.*y1 .^ 2 + (0.00824627937624933) .*
          x1 .^ 7.*y1 .^ 1 + (-0.0149332490903717) .* x1 .^ 7.*y1 .^ 2 + (0.00595637375150662)
           .* x1 .^ 7.*y1 .^ 3 + (-0.0490519008171776) .* x1 .^ 6.*y1 .^ 1 + (
          0.0547644631894267) .* x1 .^ 6.*y1 .^ 2 + (-0.0294054443156379) .*
          x1 .^ 6.*y1 .^ 3 + (0.00644113577382396) .* x1 .^ 6.*y1 .^ 4 + (-0.141050144830697)
           .* x1 .^ 5.*y1 .^ 1 + (0.331124788177358) .* x1 .^ 5.*y1 .^ 2 + (-0.361637858402444)
           .* x1 .^ 5.*y1 .^ 3 + (0.199845308894148) .* x1 .^ 5.*y1 .^ 4 + (-0.0445539243958295)
           .* x1 .^ 5.*y1 .^ 5 + (-0.0895191026576243) .* x1 .^ 4.*y1 .^ 1 + (
          0.435000419295625) .* x1 .^ 4.*y1 .^ 2 + (-0.855765252276763) .* x1 .^
          4.*y1 .^ 3 + (0.794279259209092) .* x1 .^ 4.*y1 .^ 4 + (-0.349305438078168)
           .* x1 .^ 4.*y1 .^ 5 + (0.0587289941449) .* x1 .^ 4.*y1 .^ 6 + (-0.0673246981760775)
           .* x1 .^ 3.*y1 .^ 1 + (0.152276713823781) .* x1 .^ 3.*y1 .^ 2 + (-0.658989014138355)
           .* x1 .^ 3.*y1 .^ 3 + (1.12099169078695) .* x1 .^ 3.*y1 .^ 4 + (-0.852220059293641)
           .* x1 .^ 3.*y1 .^ 5 + (0.284103442427349) .* x1 .^ 3.*y1 .^ 6 + (-0.030598075669132)
           .* x1 .^ 3.*y1 .^ 7 + (-0.274835535466439) .* x1 .^ 2.*y1 .^ 1 + (0.10521659327455)
           .* x1 .^ 2.*y1 .^ 2 + (-0.0817699019842939) .* x1 .^ 2.*y1 .^ 3 + (
          0.540205525921847) .* x1 .^ 2.*y1 .^ 4 + (-0.805704737418588) .* x1 .^
          2.*y1 .^ 5 + (0.473195595542273) .* x1 .^ 2.*y1 .^ 6 + (-0.10962351779232)
           .* x1 .^ 2.*y1 .^ 7 + (0.00553839782424903) .* x1 .^ 2.*y1 .^ 8 + (
          -0.456453407756215) .* x1 .^ 1.*y1 .^ 1 + (0.257424821666076) .* x1 .^
          1.*y1 .^ 2 + (-0.0207597004660533) .* x1 .^ 1.*y1 .^ 3 + (-0.00617607581669293)
           .* x1 .^ 1.*y1 .^ 4 + (-0.243348931432783) .* x1 .^ 1.*y1 .^ 5 + (0.301605652645551)
           .* x1 .^ 1.*y1 .^ 6 + (-0.124499607368792) .* x1 .^ 1.*y1 .^ 7 + (0.0155731352048423)
           .* x1 .^ 1.*y1 .^ 8);
      end if;
    end if;
    annotation (Documentation(info="<html>
<p>Computes&nbsp;density&nbsp;as&nbsp;a&nbsp;function&nbsp;of&nbsp;pressure&nbsp;and&nbsp;temperature.</p>
</html>"));
  end density_pT;

  redeclare function extends dynamicViscosity
    "Calculates dynamic viscosity of refrigerant"

    /*The functional form of the dynamic viscosity is implented as presented in
  Huber et al. (2003), Model for the Viscosity and Thermal Conductivity of
  Refrigerants, Including a New Correlation for the Viscosity of R134a.
  Ind. Eng. Chem. Res(42)
  Afterwards, the coefficients are adapted to the HelmholtzMedia libary.
*/
protected
    SaturationProperties sat=setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real Tred=state.T/251.196 "Reduced temperature for lower density terms";
    Real omegaEta "Reduced effective collision cross section";
    Real etaZd "Dynamic viscosity for the limit of zero density";
    Real etaL
      "Dynamic viscosity for the limit of high density at bubble line";
    Real etaG "Dynamic viscosity for the limit of high density at dew line";
    Real etaExc "Dyanmic excess viscosity";
    Real etaExcL "Dyanmic excess viscosity for the limit of high density at 
      bubble line";
    Real etaExcG "Dyanmic excess viscosity for the limit of high density at 
      dew line";
  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
         then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    if (state.phase == 1 or phase_dT == 1) then

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred) < 1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.235156 - 0.491266*Tred + 0.05211155*Tred^2 + 0.05347906
        *Tred^3 - 0.1537102*Tred^4);
      etaZd := 1.00697*sqrt(state.T)/omegaEta;

      //Calculate excess viscosity
      etaExc := 0.4071119E-2*state.d + 0.7198037E-4*state.d^2 + 0.2411697E-16*
        state.d^6/Tred^3 + 0.2971072E-22*state.d^8 - 0.1627888E-22*state.d^8/
        Tred;

      //Calculate the final dynamic viscosity
      eta := (etaExc + etaZd)*1e-6;

    else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred) < 1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.235156 - 0.491266*Tred + 0.05211155*Tred^2 + 0.05347906
        *Tred^3 - 0.1537102*Tred^4);
      etaZd := 1.00697*sqrt(state.T)/omegaEta;

      //Calculate excess viscosity
      etaExcL := 0.4071119E-2*bubbleState.d + 0.7198037E-4*bubbleState.d^2 + 0.2411697E-16
        *bubbleState.d^6/Tred^3 + 0.2971072E-22*bubbleState.d^8 - 0.1627888E-22
        *bubbleState.d^8/Tred;
      etaExcG := 0.4071119E-2*dewState.d + 0.7198037E-4*dewState.d^2 + 0.2411697E-16
        *dewState.d^6/Tred^3 + 0.2971072E-22*dewState.d^8 - 0.1627888E-22*
        dewState.d^8/Tred;

      //Calculate the final dynamic viscosity
      etaL := (etaExcL + etaZd)*1e-6;
      etaG := (etaExcG + etaZd)*1e-6;

      // Calculate the final dynamic visocity
      eta := (quality/etaG + (1 - quality)/etaL)^(-1);
    end if;

    annotation (Documentation(info="<html>
<p>Calculates&nbsp;dynamic&nbsp;viscosity&nbsp;of&nbsp;refrigerant.</p>
</html>"));
  end dynamicViscosity;

  redeclare function extends thermalConductivity
    "Calculates thermal conductivity of refrigerant"
    /*The functional form of the thermal conductivity is implented as presented in
    G. Scalabrin et al (2006), A Reference Multiparameter Thermal Conductivity
    Equation for Carbon Dioxide with an Optimized Functional Form*/
protected
    SaturationProperties sat=setSat_T(state.T) "Saturation properties";
    Integer phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";
    Real delta "Reduced density";
    Real deltaG "Reduced density at dew line";
    Real deltaL "Reduced density at bubble line";
    Real tau "Reduced temperature";
    Real lambdaG "thermal conductivity at bubble dew line";
    Real lambdaL "thermal conductivity at bubble dew line";
    Real lambdaR "Reduced thermal conductivity";
    Real lambdaRCri "Reduced thermal conductivity in critical region";
    Real lambdaRNonCri "Reduced thermal conductivity without critical region";
    Real lambdaRG "Reduced thermal conductivity";
    Real lambdaRCriG "Reduced thermal conductivity in critical region";
    Real lambdaRNonCriG
      "Reduced thermal conductivity without critical region";
    Real lambdaRL "Reduced thermal conductivity";
    Real lambdaRCriL "Reduced thermal conductivity in critical region";
    Real lambdaRNonCriL
      "Reduced thermal conductivity without critical region";
    Real alpha "coefficient for the critical region term";
    Real small=Modelica.Constants.small "small";

     Real lambdaC=4.81384;
     Real n[11]={7.69857587,0.159885811,1.56918621,-6.73400790,16.3890156,
        3.69415242,22.3205514,66.1420950,-0.171779133,0.00433043347,0.775547504};
     Real g[10]={0,0,1.5,0,1,1.5,1.5,1.5,3.5,5.5};
     Integer h[10]={1,5,1,1,2,0,5,9,0,0};
     Real a[12]={3,6.70697,0.94604,0.3,0.3,0.39751,0.33791,0.77963,
        0.79857,0.90,0.02,0.20};

  algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT := if not ((state.d < bubbleDensity(sat) and state.d >
        dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
         then 1 else 2;
    else
      phase_dT := state.phase;
    end if;
    delta := state.d/467.6;
    tau := state.T/304.1282;
    if (state.phase == 1 or phase_dT == 1) then
      // Calculate properties

      alpha := 1 - a[10]*Modelica.Math.acosh(1 + a[11]*((1 - tau)^2)^a[12]);
      lambdaRNonCri := sum(n[i]*tau^g[i]*delta^h[i] for i in 1:3) + exp(-5*
        delta^2)*sum(n[i]*tau^g[i]*delta^h[i] for i in 4:10);
      //Calculate correction term for critical region
      lambdaRCri := (delta*exp(-delta^a[1]/a[1] - (a[2]*(tau - 1))^2 - (a[3]*(
        delta - 1))^2))/(((((1 - 1/tau) + a[4]*((delta - 1)^2)^(0.5/a[5]))^2)^
        a[6] + ((a[7]*(delta - alpha))^2)^a[8])^a[9]);
      lambdaR := lambdaRNonCri + n[11]*lambdaRCri;
      //Calculate the final thermal conductivity
      lambda := lambdaC*lambdaR;
    else
      // Calculate properties
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);
      deltaL := bubbleState.d/467.6;
      deltaG := dewState.d/467.6;

      alpha := 1 - a[10]*Modelica.Math.acosh(1 + a[11]*((1 - tau)^2)^a[12]);
      lambdaRNonCriG := sum(n[i]*tau^g[i]*deltaG^h[i] for i in 1:3) + exp(-5*
        deltaG^2)*sum(n[i]*tau^g[i]*deltaG^h[i] for i in 4:10);
      lambdaRNonCriL := sum(n[i]*tau^g[i]*deltaL^h[i] for i in 1:3) + exp(-5*
        deltaL^2)*sum(n[i]*tau^g[i]*deltaL^h[i] for i in 4:10);
      //Calculate correction term for critical region
      lambdaRCriL := (delta*exp(-deltaL^a[1]/a[1] - (a[2]*(tau - 1))^2 - (a[3]
        *(deltaL - 1))^2))/(((((1 - 1/tau) + a[4]*((deltaL - 1)^2)^(0.5/a[5]))
        ^2)^a[6] + ((a[7]*(deltaL - alpha))^2)^a[8])^a[9]);
      lambdaRCriG := (delta*exp(-deltaG^a[1]/a[1] - (a[2]*(tau - 1))^2 - (a[3]
        *(deltaG - 1))^2))/(((((1 - 1/tau) + a[4]*((deltaG - 1)^2)^(0.5/a[5]))
        ^2)^a[6] + ((a[7]*(deltaG - alpha))^2)^a[8])^a[9]);
      lambdaRG := lambdaRNonCriG + lambdaRCriG;
      lambdaRL := lambdaRNonCriL + lambdaRCriL;
      //Calculate the final thermal conductivity
      lambdaG := lambdaC*lambdaRG;
      lambdaL := lambdaC*lambdaRL;
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
  Mulero and Cachadiña (2012), Recommended Correlations for the Surface Tension
  of Common Fluids. Journal of Physical and Chemical Reference Data 41,
  */
  algorithm
    sigma := 0.07863*(1 - sat.Tsat/304.1282)^1.254;
    annotation (Documentation(info="<html>
<p>Surface&nbsp;tension&nbsp;in&nbsp;two&nbsp;phase&nbsp;region&nbsp;of&nbsp;refrigerant.</p>
</html>"));
  end surfaceTension;

  annotation (Documentation(info="<html>
<p>This package provides a refrigerant model for R744 using a hybrid approach developed by Sangi et al.. The hybrid approach is implemented in IBPSA.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium and the refrigerant model is implemented by complete the template IBPSA.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord . The fitting coefficients required in the template are saved in the package IBPSA.DataBase.Media.Refrigerants.R744 . </p>
</html>",
        revisions="<html>
<ul>
<li>December 10, 2018, by Stephan Goebel: First implementation (see <a href=\"https://github.com/RWTH-EBC/Aixlib/issues/665\">issue 665</a>)</li>
<li>July 16, 2019, by Christian Vering</li>
</ul>
</html>
"));
end R744_I0_P10_100_T233_373_Formula;
