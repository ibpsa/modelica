within Annex60.Utilities.Psychrometrics.Functions.Examples;
model phi_pTX "Model to test phi_pTX"
  extends Modelica.Icons.Example;

  parameter SI.Pressure p = 101325 "Pressure of the medium";
  SI.Temperature T "Temperature";
  SI.MassFraction X_w "Mass fraction";
  Real phi "Relative humidity";
  constant Real convT(unit="1/s") = 0.999 "Conversion factor";
  constant Real convX(unit="1/s") = 0.02 "Conversion factor";
equation
  if time < 0.5 then
    X_w = convX*time;
    T = 293.15;
  else
    X_w = 0.5*convX;
    T = 293.15+convT*(time-0.5)*10;
  end if;
  phi = Annex60.Utilities.Psychrometrics.Functions.phi_pTX(p=p, T=T, X_w=X_w);
  annotation (
experiment(StopTime=1.0),
__Dymola_Commands(file="modelica://Annex60/Resources/Scripts/Dymola/Utilities/Psychrometrics/Functions/Examples/phi_pTX.mos"
        "Simulate and plot"));
end phi_pTX;
