within Annex60.BoundaryConditions.SolarGeometry.BaseClasses.Examples;
model IncidenceAngle "Test model for incidence angle"
  extends Modelica.Icons.Example;
  Annex60.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng
    "Declination angle"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Annex60.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle
    solHouAng "Solar hour angle"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Annex60.BoundaryConditions.SolarGeometry.BaseClasses.IncidenceAngle incAng(
    azi=Annex60.Types.Azimuth.S,
    til=Annex60.Types.Tilt.Wall,
    lat=0.73268921998722) "Incidence angle"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Annex60.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam="modelica://Annex60/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    "Weather data"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Annex60.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
equation
  connect(decAng.decAng, incAng.decAng) annotation (Line(
      points={{21,30},{30,30},{30,5.4},{37.8,5.4}},
      color={0,0,127}));
  connect(solHouAng.solHouAng, incAng.solHouAng) annotation (Line(
      points={{21,-30},{28,-30},{28,-4.8},{38,-4.8}},
      color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-60,5.82867e-16},{-54,5.82867e-16},{-54,1.13798e-15},{-48,
          1.13798e-15},{-48,5.55112e-16},{-36,5.55112e-16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.cloTim, decAng.nDay) annotation (Line(
      points={{-36,5.55112e-16},{-20,5.55112e-16},{-20,30},{-2,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.solTim, solHouAng.solTim) annotation (Line(
      points={{-36,5.55112e-16},{-20,5.55112e-16},{-20,-30},{-2,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (
  Documentation(info="<html>
<p>
This example computes the solar incidence angle on a tilted surface.
This model is also part of more extensive tests that run the
model for different orientations. These tests are at
<a href=\"modelica://Annex60.BoundaryConditions.SolarGeometry.Examples.IncidenceAngle\">
Annex60.BoundaryConditions.SolarGeometry.Examples.IncidenceAngle</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 24, 2015, by Michael Wetter:<br/>
Assigned azimuth and tilt using the types from
<a href=\"modelica://Annex60.Types.Tilt\">
Annex60.Types.Tilt</a>.
</li>
<li>
May 19, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
  experiment(StopTime=86400),
__Dymola_Commands(file="modelica://Annex60/Resources/Scripts/Dymola/BoundaryConditions/SolarGeometry/BaseClasses/Examples/IncidenceAngle.mos"
        "Simulate and plot"));
end IncidenceAngle;
