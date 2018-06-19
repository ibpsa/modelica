within IBPSA.Utilities.IO.RESTClient.Examples;
model Sampler
  import IBPSA;
 extends Modelica.Icons.Example;
   inner IBPSA.Utilities.IO.RESTClient.Configuration
                                          Config(samplePeriod=0.5, activation=
        IBPSA.Utilities.IO.RESTClient.Types.GlobalActivation.use_input)
    annotation (Placement(transformation(extent={{60,58},{80,80}})));
  IBPSA.Utilities.IO.RESTClient.Sampler
                             sampler(numVar=2,
    samplePeriod=1)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));

  Modelica.Blocks.Sources.Sine sine(amplitude=2, freqHz=1/60)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine sine1(freqHz=1/30)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
equation
  connect(sine.y, sampler.u[1]) annotation (Line(points={{-59,-40},{-60,-40},{-20,-40},{-20,-1},
          {-2,-1}},
                color={0,0,127}));
  connect(sine1.y, sampler.u[2])
    annotation (Line(points={{-59,20},{-20,20},{-20,1},{-2,1}}, color={0,0,127}));
  connect(booleanExpression.y, Config.activate) annotation (Line(points={{1,80},
          {30,80},{30,77.8},{58,77.8}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
   experiment(Tolerance=1e-6, StartTime=0, StopTime=120),
__Dymola_Commands(file="modelica://IBPSA/Resources/Scripts/Dymola/Utilities/IO/RESTClient/Examples/Sampler.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>This example demonstrates the use of a sampler that sends time series to a remoted server. Please start the socket server (see Server.py in IBPSA/Resources/src/SocketServer) before starting this example. </p>
</html>"));
end Sampler;
