within IBPSA.Utilities.IO.Files.BaseClasses;
function writeJSON
  "Write a vector of Real variables to a JSON file"
    input IBPSA.Utilities.IO.Files.BaseClasses.JSONWriterObject ID "JSON writer object id";
    input Real[:] varVals "Variable values";

    external "C" writeJSON(ID, varVals, size(varVals,1))
    annotation(Include=" #include \"jsonWriterInit.h\"",
    IncludeDirectory="modelica://IBPSA/Resources/C-Sources");

  annotation (Documentation(info="<html>
<p>
Function for writing data to a JSON file.
</p>
</html>", revisions="<html>
<ul>
<li>
April 15 2019, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end writeJSON;
