within Annex60.Fluid.MixingVolumes.Validation;
model MoistureMixingConservation
  "This test checks if mass and energy is conserved when mixing fluid streams"
  extends
    Annex60.Fluid.MixingVolumes.Validation.BaseClasses.MoistureMixingConservation(
    mWatFloSol(k=0),
    mFloSol(k=sou1.m_flow + sou2.m_flow),
    hSol(k=Medium.h_default*(sou1.m_flow + sou2.m_flow)));

equation
  connect(assMasFra.u2, senMasFra.X) annotation (Line(
      points={{82.6,-24.8},{68,-24.8},{68,19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(assMasFlo.u2, senMasFlo.m_flow) annotation (Line(
      points={{82.6,-54.8},{44,-54.8},{44,19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(assSpeEnt.u2, senSpeEnt.H_flow) annotation (Line(
      points={{82.6,-86.8},{20,-86.8},{20,19}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (                   Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics),
    experiment(Tolerance=1e-08),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>
This test checks if water vapour mass is conserved. 
Two air streams with different mass flow rate are humidified 
by a mixing volume with two different vapor mass flow rates. 
These flows are then mixed. 
Afterwards the added moisture is removed. 
The final moisture concentration, mass flow rate and enthalpy 
flow rate should then be equal to the initial values.
</p>
</html>", revisions="<html>
<ul>
<li>
May 22 2015 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/MixingVolumes/Validation/MoistureMixingConservation.mos"
        "Simulate and plot"));
end MoistureMixingConservation;
