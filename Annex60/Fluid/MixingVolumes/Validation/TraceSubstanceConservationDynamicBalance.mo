within Annex60.Fluid.MixingVolumes.Validation;
model TraceSubstanceConservationDynamicBalance
  "This test checks if trace substance mass flow rates are conserved when a dynamic balance is used"
  extends
    Annex60.Fluid.MixingVolumes.Validation.BaseClasses.TraceSubstanceConservation(
     vol(massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      C_nominal=zeros(Medium.nC)));

  Modelica.Blocks.Continuous.Integrator intTraSubIn(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-30})));
  Modelica.Blocks.Continuous.Integrator intTraSubOut(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-30})));
  Modelica.Blocks.Sources.RealExpression reaExp(y=vol.dynBal.m*vol.dynBal.C[1])
    "Mixing volume total species mass"
    annotation (Placement(transformation(extent={{-38,-58},{0,-78}})));
  Utilities.Diagnostics.AssertEquality assZer(threShold=1E-10)
    "Assert conservation of mass"
    annotation (Placement(transformation(extent={{80,-88},{100,-68}})));
  Modelica.Blocks.Math.Add3 add3(
    k1=-1,
    k2=+1,
    k3=-1) "Conservation of mass"
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Modelica.Blocks.Sources.Constant zero(k=0) "Zero input"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
equation
  connect(intTraSubIn.u, senTraSubIn.C) annotation (Line(
      points={{-50,-18},{-50,-11}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intTraSubOut.u, senTraSubOut.C) annotation (Line(
      points={{30,-18},{30,-11}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(reaExp.y, add3.u3) annotation (Line(
      points={{1.9,-68},{38,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intTraSubIn.y, add3.u2) annotation (Line(
      points={{-50,-41},{-50,-60},{38,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intTraSubOut.y, add3.u1) annotation (Line(
      points={{30,-41},{30,-52},{38,-52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add3.y, assZer.u1) annotation (Line(
      points={{61,-60},{70,-60},{70,-72},{78,-72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(zero.y, assZer.u2) annotation (Line(
      points={{61,-90},{70,-90},{70,-84},{78,-84}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (                   Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics),
    experiment(Tolerance=1e-08),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>
This test checks if the trace substance flow rate is 
conserved when adding moisture to a mixing volume that is configured to steady state.
</p>
</html>", revisions="<html>
<ul>
<li>
May 22 2015 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end TraceSubstanceConservationDynamicBalance;
