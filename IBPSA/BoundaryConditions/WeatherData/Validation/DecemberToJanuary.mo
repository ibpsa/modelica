within IBPSA.BoundaryConditions.WeatherData.Validation;
model DecemberToJanuary
  "Validation model for a data reader that has data spanning only some hours in December to January"
  extends Modelica.Icons.Example;
  IBPSA.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam="modelica://IBPSA/Resources/weatherdata/DecemberToJanuary.mos")
    "Weather data reader with data file going from December to January"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  annotation (experiment(
      StartTime=30992400,
      StopTime=31860000,
      Tolerance=1e-06),
__Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/Validation/DecemberToJanuary.mos"
        "Simulate and plot"),
      Documentation(info="<html>
<p>
This is a validation case for a data file that has a few incomplete days in December and goes into
a few days into January. The data does not start and does not end at midnight.
</p>
</html>", revisions="<html>
<ul>
<li>
October 26, 2017, by Michael Wetter:<br/>
First implementation for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/842\">issue 842</a>.
</li>
</ul>
</html>"));

end DecemberToJanuary;
