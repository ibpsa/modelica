within IBPSA.Media.Refrigerants;
package R410A "Package with models for refrigerant R410A"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
This package contains different refrigerant models for the refrigerant R410A.
The medium models are developed using the approaches provided in
<a href=\"modelica://IBPSA.Media.Refrigerants.Interfaces\">
IBPSA.Media.Refrigerants.Interfaces</a>.
</p>
<p>
The <b>naming of the models</b> follows the guidline presented below:
</p>
<p style=\"margin-left: 30px;\">
<i>Refrigerant</i> _ <i>Reference Point</i> _ <i>Range of validity for
pressure</i> _ <i>Range of validity for temperature</i> _ <i>Approach of
calculating fitted formulas</i>
</p>
</html>",
        revisions="<html>
<ul>
<li>June 11, 2017, by Mirko Engelpracht:<br>First implementation (see <a href=\"https://github.com/RWTH-EBC/Aixlib/issues/408\">issue 408</a>). </li>
<li>May 13, 2019, by Bijan Seyed Sadjjadi</li>
<li>July 15, 2019, by Christian Vering</li>
</ul>
</html>"));
end R410A;
