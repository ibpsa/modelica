within IBPSA.Media.Refrigerants.Validation.RefrigerantsFittedFormulas;
model RefrigerantsFittedFormulasR290
  "Model that checks the fitted formulas of R290"
  extends RefrigerantsFittedFormulasR134a(
    redeclare package MediumInt =
      IBPSA.Media.Refrigerants.R290.R290_IIR_P05_30_T263_343_Horner,
    extProp(fileName=Modelica.Utilities.Files.loadResource(
      "modelica://WorkingVersion/Resources/Media/Refrigerants/ValidationFittedFormulasR290.txt")),
    h_min = 180e3,
    h_max = 550e3,
    s_min = 1.0e3,
    s_max = 1.8e3,
    d_min = 2.0,
    d_max = 525,
    p_min = 1e5,
    p_max = 30e5,
    T_min = 263.15,
    T_max = 343.15);

  annotation (experiment(StopTime=6400, Tolerance=1e-006),
Documentation(revisions="<html>
<ul>
<li>August 13, 2017, by Mirko Engelpracht:<br>First implementation (see <a href=\"https://github.com/RWTH-EBC/Aixlib/issues/408\">issue 408</a>). </li>
<li>July 16, 2019, by Christian Vering</li>
</ul>
</html>", info="<html>
<p>This example model checks the implementation of the<b> refrigerant&apos;s fitted formulas</b> depending on the independent variables density and temperature. Therefore, the user has first to introduce some information about the refrigerant and afterwards the fitted formulas are calculated. The following <b>refrigerant&apos;s information</b> is required: </p>
<ol>
<li>The <i>refrigerant package</i> that shall be tested.</li>
<li>The <i>refrigerant&apos;s fluid limits</i> that are determined by the fitting procedure.</li>
</ol>
<p>The following <b>refrigerant&apos;s fitted formulas </b>are calculated and checked: </p>
<ol>
<li>Calculation of the Helmholtz equation of state.</li>
<li>Calculation of the saturation properties.</li>
<li>Calculation of further state propeties like the density depending on pressure and temperature.</li>
</ol>
<p>Additionally, the fitted formulas are also calculated with an external media libary (i.e. <a href=\"https://github.com/thorade/HelmholtzMedia\">HelmholtzMedia</a>). Therefore, the parameters are not allowed to change (except for the medium package). </p>
</html>"));
end RefrigerantsFittedFormulasR290;
