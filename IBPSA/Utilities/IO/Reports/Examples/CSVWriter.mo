within IBPSA.Utilities.IO.Reports.Examples;
model CSVWriter "Example of csv writer use"
  extends Modelica.Icons.Example;
  IBPSA.Utilities.IO.Reports.CSVWriter csvWri(
    nin=2,
    samplePeriod=1,
    fileName="test.csv") "Model that writes two inputs to csv file"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.Cosine cos(freqHz=0.345) "Cosine"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Step step(startTime=5) "Step function"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  IBPSA.Utilities.IO.Reports.CSVWriter csvWri2(
    samplePeriod=1,
    delimiter="    ",
    writeHeader=false,
    nin=2)
    "Duplicate to test for conflicts when instantiating multiple csv writers"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(cos.y, csvWri.u[1]) annotation (Line(points={{-59,30},{-40,30},{-40,1},
          {-21,1}}, color={0,0,127}));
  connect(step.y, csvWri.u[2]) annotation (Line(points={{-59,-30},{-40,-30},{
          -40,-1},{-21,-1}}, color={0,0,127}));
  connect(csvWri2.u[1], cos.y) annotation (Line(points={{-21,-29},{-32,-29},{
          -32,30},{-59,30}}, color={0,0,127}));
  connect(csvWri2.u[2], step.y) annotation (Line(points={{-21,-31},{-54,-31},{
          -54,-30},{-59,-30}}, color={0,0,127}));
  annotation (experiment(StartTime=-1.2, StopTime=10),
                                       Documentation(revisions="<html>
<ul>
<li>
May 10, 2018 by Filip Jorissen:<br/>
First implementation.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/924\">#924</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model demonstrates the use of the csv file writer.
</p>
</html>"));
end CSVWriter;
