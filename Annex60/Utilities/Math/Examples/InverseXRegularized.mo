within Annex60.Utilities.Math.Examples;
model InverseXRegularized "Test model for inverseXRegularized function "
  import Annex60;
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp x1(duration=1,
    height=2,
    offset=-1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}},rotation=0)));
  Annex60.Utilities.Math.InverseXRegularized inverseXRegularized(delta=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(x1.y, inverseXRegularized.u) annotation (Line(
      points={{-39,0},{-12,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Documentation(info="<html>
<p>
This model tests the implementation of 
<a href=\"modelica://Annex60.Utilities.Math.InverseXRegularized\">
Annex60.Utilities.Math.InverseXRegularized</a>.
</p>
</html>", revisions="<html>
<p><ul>
<li>November 28, 2013, by Marcus Fuchs:<br/>Implementation based on Functions.inverseXRegularized. </li>
</ul></p>
</html>"));
end InverseXRegularized;
