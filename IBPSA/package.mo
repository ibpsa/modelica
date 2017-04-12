within ;
package IBPSA "Library with models for building energy and control systems"
  extends Modelica.Icons.Package;


package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;
  class Conventions "Conventions"
    extends Modelica.Icons.Information;
    annotation (preferredView="info",
    Documentation(info="<html>
<p>
This library follows the conventions of the
<a href=\"modelica://Modelica.UsersGuide.Conventions\">Modelica Standard Library</a>, which are as follows:
</p>

<p>
Note, in the html documentation of any Modelica library,
the headings \"h1, h2, h3\" should not be used,
because they are utilized from the automatically generated documentation/headings.
Additional headings in the html documentation should start with \"h4\".
</p>

<p>
In the Modelica package the following conventions are used:
</p>

<ol>
<li> Class and instance names are written in upper and lower case
  letters, e.g., \"ElectricCurrent\", and may contain numbers.
  An underscore is only used
  at the end of a name to characterize a lower or upper index,
  e.g., \"pin_a\".</li>

<li> <b>Class names</b> start always with an upper case letter.</li>

<li> <b>Instance names</b>, i.e., names of component instances and
  of variables (with the exception of constants),
  start usually with a lower case letter with only
  a few exceptions if this is common sense
  (such as \"T\" for a temperature variable).</li>

<li> <b>Constant names</b>, i.e., names of variables declared with the
  \"constant\" prefix, follow the usual naming conventions
  (= upper and lower case letters) and start usually with an
  upper case letter, e.g. UniformGravity, SteadyState,
  with only few exceptions such as \"pi\" and \"h_fg\".</li>
<li> The two connectors of a domain that have identical declarations
  and different icons are usually distinguished by \"_a\", \"_b\"
  or \"_p\", \"_n\", e.g., Flange_a/Flange_b, HeatPort_a, HeatPort_b.</li>

<li> The <b>instance name</b> of a component is always displayed in its icon
  (= text string \"%name\") in <b>blue color</b>. A connector class has the instance
  name definition in the diagram layer and not in the icon layer.
  If displayed, <b>parameter</b> values, e.g., resistance, mass, gear ratio, are displayed
  in the icon in <b>black color</b> in a smaller font size as the instance name.
 </li>

<li>Packages have usually the following subpackages:
  <ul>
  <li><b>UsersGuide</b> containing an overall description of the library
   and how to use it.</li>
  <li><b>Examples</b> containing models demonstrating the
   usage of the library.</li>
  <li><b>Interfaces</b> containing connectors and partial
   models.</li>
  <li><b>Types</b> containing type, enumeration and choice
   definitions.</li>
  </ul>
  </li>
</ol>

<p>
The <code>IBPSA</code> library uses the following conventions
in addition to the ones of the Modelica Standard Library:
</p>

<ol>
<li>
  The nomenclature used in the package
  <a href=\"modelica://IBPSA.Utilities.Psychrometrics\">
  IBPSA.Utilities.Psychrometrics</a>
   is as follows,
  <ul>
    <li>
      Uppercase <code>X</code> denotes mass fraction per total mass.
    </li>
    <li>
      Lowercase <code>x</code> denotes mass fraction per mass of dry air.
    </li>
    <li>
      The notation <code>z_xy</code> denotes that the function or block has output
      <code>z</code> and inputs <code>x</code> and <code>y</code>.
      </li>
    <li>
      The symbol <code>pW</code> denotes water vapor pressure, <code>TDewPoi</code>
      denotes dew point temperature, <code>TWetBul</code> denotes wet bulb temperature,
      and <code>TDryBul</code> (or simply <code>T</code>) denotes dry bulb temperature.
    </li>
  </ul>
</li>
<li>
  Names of models, blocks and packages should start with an upper-case letter and be a
  noun or a noun with a combination of adjectives and nouns.
  Use camel-case notation to combine multiple words, such as <code>HeatTransfer</code>.
</li>
<li>
  Parameter and variables names are usually a character, such as <code>T</code>
  for temperature and <code>p</code> for pressure, or a combination of the first three
  characters of a word, such as <code>higPreSetPoi</code> for high pressure set point.
</li>
<li>
  Comments should be added to each class (package, model, function etc.).
  The first character should be upper case.
  For one-line comments of parameters, variables and classes, no period should be used at the end of the comment.
</li>
<li>
All variables that have a physical correspondence, including physical ratios, must have a unit.
Use (derived) SI units.
Non-SI units are to be kept at an absolute minimum, and they must be declared as <code>protected</code>.
</li>
<li>
  To indicate that a class (i.e., a package, model, block etc.) has not been extensively tested or validated,
  its class name ends with the string <code>Beta</code>.
</li>
</ol>
</html>"));
  end Conventions;

  package ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;

  class Version_1_0_0 "Version 1.0.0"
    extends Modelica.Icons.ReleaseNotes;
      annotation (preferredView="info", Documentation(info="<html>
<p>
First official release of the Annex 60 library.
Future development will continue on
<a href=\"https://github.com/ibpsa/modelica\">https://github.com/ibpsa/modelica</a>.
</p>
</html>"));
  end Version_1_0_0;

    annotation (preferredView="info",
    Documentation(info="<html>
<p>
This section summarizes the changes that have been performed
on the <code>IBPSA</code> library.
</p>
<ul>
<li>
<a href=\"modelica://IBPSA.UsersGuide.ReleaseNotes.Version_1_0_0\">Version 1.0.0</a>(January 17, 2017)
</li>
</ul>

</html>"));
  end ReleaseNotes;

  class Contact "Contact"
    extends Modelica.Icons.Contact;
    annotation (preferredView="info",
    Documentation(info="<html>
<h4><font color=\"#008000\" size=\"5\">Contact</font></h4>
<p>
The development of the IBPSA library is organized through the
<a href=\"https://ibpsa.github.io/project1\">IBPSA Project 1</a>
of the International Building Performance Simulation Association (IBPSA).
From 2012 to 2017, the development was organized through the
<a href=\"http://www.iea-annex60.org\">Annex 60 project</a>
of the Energy in Buildings and Communities Programme of the International Energy Agency (IEA EBC).
</p>
<p>
Library point of contact<br/>
<a href=\"http://simulationresearch.lbl.gov/wetter\">Michael Wetter</a><br/>
    Lawrence Berkeley National Laboratory (LBNL)<br/>
    One Cyclotron Road<br/>
    Bldg. 90-3147<br/>
    Berkeley, CA 94720<br/>
    USA<br/>
    email: <a href=\"mailto:MWetter@lbl.gov\">MWetter@lbl.gov</a><br/>
</p>
</html>"));
  end Contact;

  class Acknowledgements "Acknowledgements"
    extends Modelica.Icons.Information;
    annotation (preferredView="info",
    Documentation(info="<html>
<h4><font color=\"#008000\" size=\"5\">Acknowledgements</font></h4>
<p>
The following grants supported the development of the <code>IBPSA</code> library:
</p>
<ul>
<li>
LBNL
was supported for the development of this library
by the Assistant Secretary for
Energy Efficiency and Renewable Energy, Office of Building
Technologies of the U.S. Department of Energy, under
contract No. DE-AC02-05CH11231.
</li>
<li>
The authors acknowledge the financial support by the Agency for
Innovation by Science and Technology in Flanders (IWT) and WTCB
in the frame of the IWT-VIS Traject SMART GEOTHERM focusing
on integration of thermal energy storage and thermal inertia
in geothermal concepts for smart heating and cooling of (medium) large buildings.
The authors also acknowledge the financial support by IWT for the PhD work of
F. Jorissen (contract number 131012).
The work of Bram van der Heijde is funded through the
project \"Towards a Sustainable Energy Supply in Cities\" by the European Union,
the European Regional Development Fund ERDF, Flanders Innovation &amp; Entrepreneurship
and the Province of Limburg.
</li>
<li>
 RWTH Aachen University
 was supported for the development of this library
 by the German Federal Ministry for Economic Affairs and Energy (BMWi),
 promotional reference no. 03ET1177A, 03ET1211B.
</li>
<li>
 UdK Berlin
 was supported for the development of this library
 by the German Federal Ministry for Economic Affairs and Energy (BMWi),
 promotional reference no. 03ET1177D, 03ESP409C.
</li>
<li>
 Aalborg University
 was supported for the development of this library
 by the Danish Energy Agency, under the Energy Technology Development and
 Demonstration Program (EUDP), journal no. 64013-0566.
</li>
</ul>


<p>
The following people have directly contributed to the implementation of
the <code>IBPSA</code> library
(many others have contributed by other means than model implementation):
</p>
<ul>
<li>
Marcus Fuchs, RWTH Aachen University, Germany
</li>
<li>
Filip Jorissen, KU Leuven, Belgium
</li>
<li>
Moritz Lauster, RWTH Aachen University, Germany
</li>
<li>
Alessandro Maccarini, Aalborg University, Denmark
</li>
<li>
Philipp Mehrfeld, RWTH Aachen University, Germany
</li>
<li>
Jens Moeckel, UdK Berlin, Germany
</li>
<li>
Thierry S. Nouidui, Lawrence Berkeley National Laboratory, Berkeley, CA, USA
</li>
<li>
Christoph Nytsch-Geusen, UdK Berlin, Germany
</li>
<li>
Damien Picard, KU Leuven, Belgium
</li>
<li>
Matthis Thorade, UdK Berlin, Germany
</li>
<li>
Carles Ribas Tugores, UdK Berlin, Germany
</li>
<li>
Bram van der Heijde, KU Leuven, Belgium
</li>
<li>
Michael Wetter, Lawrence Berkeley National Laboratory, Berkeley, CA, USA
</li>
</ul>
</html>"));
  end Acknowledgements;

  class License "Modelica License 2"
    extends Modelica.Icons.Information;
    annotation (preferredView="info",
    Documentation(info="<html>
<h4><font color=\"#008000\" size=\"5\">The Modelica License 2</font></h4>
<p>
<strong>Preamble.</strong> The goal of this license is that Modelica related model libraries, software, images, documents, data files etc. can be used freely in the original or a modified form, in open source and in commercial environments (as long as the license conditions below are fulfilled, in particular sections 2c) and 2d). The Original Work is provided free of charge and the use is completely at your own risk. Developers of free Modelica packages are encouraged to utilize this license for their work.
</p>
<p>
The Modelica License applies to any Original Work that contains the following licensing notice adjacent to the copyright notice(s) for this Original Work:
</p>
<p>
<strong>Note.</strong> This is the standard Modelica License 2, except for the following changes: the parenthetical in paragraph 7., paragraph 5., and the addition of paragraph 15.d).
</p>
<p>
<strong>Licensed by the International Building Performance Simulation Association (IBPSA) under the Modelica License 2 </strong>
</p>

<h4>1. Definitions</h4>
<ol type=\"a\"><li>
\"License\" is this Modelica License.
</li><li>
\"Original Work\" is any work of authorship, including software, images, documents, data files, that contains the above licensing notice or that is packed together with a licensing notice referencing it.
</li><li>
\"Licensor\" is the provider of the Original Work who has placed this licensing notice adjacent to the copyright notice(s) for the Original Work. The Original Work is either directly provided by the owner of the Original Work, or by a licensee of the owner.
</li><li>
\"Derivative Work\" is any modification of the Original Work which represents, as a whole, an original work of authorship. For the matter of clarity and as examples:
<ol type=\"A\">
<li>
Derivative Work shall not include work that remains separable from the Original Work, as well as merely extracting a part of the Original Work without modifying it.
</li><li>
Derivative Work shall not include (a) fixing of errors and/or (b) adding vendor specific Modelica annotations and/or (c) using a subset of the classes of a Modelica package, and/or (d) using a different representation, e.g., a binary representation.
</li><li>
Derivative Work shall include classes that are copied from the Original Work where declarations, equations or the documentation are modified.
</li><li>
Derivative Work shall include executables to simulate the models that are generated by a Modelica translator based on the Original Work (of a Modelica package). </li>
</ol>
</li>
<li>
\"Modified Work\" is any modification of the Original Work with the following exceptions: (a) fixing of errors and/or (b) adding vendor specific Modelica annotations and/or (c) using a subset of the classes of a Modelica package, and/or (d) using a different representation, e.g., a binary representation.
</li><li>
\"Source Code\" means the preferred form of the Original Work for making modifications to it and all available documentation describing how to modify the Original Work.
</li><li>
\"You\" means an individual or a legal entity exercising rights under, and complying with all of the terms of, this License.
</li><li>
\"Modelica package\" means any Modelica library that is defined with the
 <b>package</b> &lt;Name&gt; ... <b>end</b> &lt;Name&gt;<b>;</b> Modelica language element.
</li>
</ol>

<h4>2. Grant of Copyright License</h4>
<p>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license, for the duration of the copyright, to do the following:
</p>
<ol type=\"a\">
<li>
To reproduce the Original Work in copies, either alone or as part of a collection.
</li><li>
To create Derivative Works according to Section 1d) of this License.
</li><li>
To distribute or communicate to the public copies of the <u>Original Work</u> or a <u>Derivative Work</u> under <u>this License</u>. No fee, neither as a copyright-license fee, nor as a selling fee for the copy as such may be charged under this License. Furthermore, a verbatim copy of this License must be included in any copy of the Original Work or a Derivative Work under this License.
<br/>
For the matter of clarity, it is permitted A) to distribute or communicate such copies as part of a (possible commercial) collection where other parts are provided under different licenses and a license fee is charged for the other parts only and B) to charge for mere printing and shipping costs.
</li><li>
To distribute or communicate to the public copies of a <u>Derivative Work</u>, alternatively to Section 2c), under <u>any other license</u> of your choice, especially also under a license for commercial/proprietary software, as long as You comply with Sections 3, 4 and 8 below.
<br/>
For the matter of clarity, no restrictions regarding fees, either as to a copyright-license fee or as to a selling fee for the copy as such apply.
</li><li>
To perform the Original Work publicly.
</li><li>
To display the Original Work publicly.
</li></ol>

<h4>3. Acceptance</h4>
<p>
Any use of the Original Work or a Derivative Work, or any action according to either Section 2a) to 2f) above constitutes Your acceptance of this License.
</p>

<h4>4. Designation of Derivative Works and of Modified Works</h4>
<p>
The identifying designation of Derivative Work and of Modified Work must be different to the corresponding identifying designation of the Original Work. This means especially that the (root-level) name of a Modelica package under this license must be changed if the package is modified (besides fixing of errors, adding vendor specific Modelica annotations, using a subset of the classes of a Modelica package, or using another representation, e.g. a binary representation).
</p>

<h4>5. [reserved]</h4>
<h4>6. Provision of Source Code</h4>
<p>
Licensor agrees to provide You with a copy of the Source Code of the Original Work but reserves the right to decide freely on the manner of how the Original Work is provided. For the matter of clarity, Licensor might provide only a binary representation of the Original Work. In that case, You may (a) either reproduce the Source Code from the binary representation if this is possible (e.g., by performing a copy of an encrypted Modelica package, if encryption allows the copy operation) or (b) request the Source Code from the Licensor who will provide it to You.
</p>

<h4>7. Exclusions from License Grant</h4>
<p>
Neither the names of Licensor including, but not limited to, the International Building Performance Simulation Association (IBPSA), nor the names of any contributors to the Original Work, nor any of their trademarks or service marks, may be used to endorse or promote products derived from this Original Work without express prior permission of the Licensor. Except as otherwise expressly stated in this License and in particular in Sections 2 and 5, nothing in this License grants any license to Licensor's trademarks, copyrights, patents, trade secrets or any other intellectual property, and no patent license is granted to make, use, sell, offer for sale, have made, or import embodiments of any patent claims.
No license is granted to the trademarks of Licensor even if such trademarks are included in the Original Work, except as expressly stated in this License. Nothing in this License shall be interpreted to prohibit Licensor from licensing under terms different from this License any Original Work that Licensor otherwise would have a right to license.
</p>

<h4>8. Attribution Rights</h4>
<p>
You must retain in the Source Code of the Original Work and of any Derivative Works that You create, all author, copyright, patent, or trademark notices, as well as any descriptive text identified therein as an \"Attribution Notice\". The same applies to the licensing notice of this License in the Original Work. For the matter of clarity, \"author notice\" means the notice that identifies the original author(s).
</p>
<p>
You must cause the Source Code for any Derivative Works that You create to carry a prominent Attribution Notice reasonably calculated to inform recipients that You have modified the Original Work.
</p>
<p>
In case the Original Work or Derivative Work is not provided in Source Code, the Attribution Notices shall be appropriately displayed, e.g., in the documentation of the Derivative Work.
</p>

<h4>9. Disclaimer of Warranty</h4>
<p>
<u><strong>The Original Work is provided under this License on an \"as is\" basis and without warranty, either express or implied, including, without limitation, the warranties of non-infringement, merchantability or fitness for a particular purpose. The entire risk as to the quality of the Original Work is with You.</strong></u> This disclaimer of warranty constitutes an essential part of this License. No license to the Original Work is granted by this License except under this disclaimer.
</p>

<h4>10. Limitation of Liability</h4>
<p>
Under no circumstances and under no legal theory, whether in tort (including negligence), contract, or otherwise, shall the Licensor, the owner or a licensee of the Original Work be liable to anyone for any direct, indirect, general, special, incidental, or consequential damages of any character arising as a result of this License or the use of the Original Work including, without limitation, damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses. This limitation of liability shall not apply to the extent applicable law prohibits such limitation.
</p>

<h4>11. Termination</h4>
<p>
This License conditions your rights to undertake the activities listed in Section 2 and 5, including your right to create Derivative Works based upon the Original Work, and doing so without observing these terms and conditions is prohibited by copyright law and international treaty. Nothing in this License is intended to affect copyright exceptions and limitations. This License shall terminate immediately and You may no longer exercise any of the rights granted to You by this License upon your failure to observe the conditions of this license.
</p>

<h4>12. Termination for Patent Action</h4>
<p>
This License shall terminate automatically and You may no longer exercise any of the rights granted to You by this License as of the date You commence an action, including a cross-claim or counterclaim, against Licensor, any owners of the Original Work or any licensee alleging that the Original Work infringes a patent. This termination provision shall not apply for an action alleging patent infringement through combinations of the Original Work under combination with other software or hardware.
</p>

<h4>13. Jurisdiction</h4>
<p>
Any action or suit relating to this License may be brought only in the courts of a jurisdiction wherein the Licensor resides and under the laws of that jurisdiction excluding its conflict-of-law provisions. The application of the United Nations Convention on Contracts for the International Sale of Goods is expressly excluded. Any use of the Original Work outside the scope of this License or after its termination shall be subject to the requirements and penalties of copyright or patent law in the appropriate jurisdiction. This section shall survive the termination of this License.
</p>

<h4>14. Attorneys' Fees</h4>
<p>
In any action to enforce the terms of this License or seeking damages relating thereto, the prevailing party shall be entitled to recover its costs and expenses, including, without limitation, reasonable attorneys' fees and costs incurred in connection with such action, including any appeal of such action. This section shall survive the termination of this License.
</p>

<h4>15. Miscellaneous</h4>
<ol type=\"a\">
<li>If any provision of this License is held to be unenforceable, such provision shall be reformed only to the extent necessary to make it enforceable.
</li><li>
No verbal ancillary agreements have been made. Changes and additions to this License must appear in writing to be valid. This also applies to changing the clause pertaining to written form.
</li><li>
You may use the Original Work in all ways not otherwise restricted or conditioned by this License or by law, and Licensor promises not to interfere with or be responsible for such uses by You.
</li><li>
You are under no obligation whatsoever to provide any bug fixes, patches, or upgrades to the features, functionality or performance of the source code (\"Enhancements\") to anyone; however, if you choose to make your Enhancements available either publicly, or directly to Lawrence Berkeley National Laboratory, without imposing a separate written license agreement for such Enhancements, then you hereby grant the following license: a non-exclusive, royalty-free perpetual license to install, use, modify, prepare derivative works, incorporate into other computer software, distribute, and sublicense such enhancements or derivative works thereof, in binary and source code form.
</li></ol>

<h4>How to Apply the Modelica License 2</h4>
<p>
At the top level of your Modelica package and at every important subpackage, add the following notices in the info layer of the package:
</p>
<ul><li style=\"list-style-type:none\">
Licensed by the International Building Performance Simulation Association (IBPSA) under the Modelica License 2 Copyright (c) 2017.
</li>
<li style=\"list-style-type:none\"><i>
This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica license 2, see the license conditions (including the disclaimer of warranty) here or at <a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html\">http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html</a>.
</i></li></ul>

<p>
Include a copy of the Modelica License 2 under <strong>&lt;library&gt;.UsersGuide.ModelicaLicense2</strong>
(use <a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.mo\">
http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.mo</a>)
Furthermore, add the list of authors and contributors under
<strong>&lt;library&gt;.UsersGuide.Contributors</strong> or <strong>&lt;library&gt;.UsersGuide.Contact</strong>
</p>
<p>
For example, sublibrary Modelica.Blocks of the Modelica Standard Library may have the following notices:</p>
<ul><li style=\"list-style-type:none\">
Licensed by Modelica Association under the Modelica License 2 Copyright (c) 1998-2008, Modelica Association.
</li>
<li style=\"list-style-type:none\"><i>
This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica license 2, see the license conditions (including the disclaimer of warranty) here or at
<a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html\">http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html</a>.
</i>
</li></ul>

<p>For C-source code and documents, add similar notices in the corresponding file.</p>
<p>
For images, add a \"readme.txt\" file to the directories where the images are stored and include a similar notice in this file.
</p>

<p>
In these cases, save a copy of the Modelica License 2 in one directory of the distribution, e.g.,
<a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2-standalone.html\">http://www.modelica.org/modelica-legal-documents/ModelicaLicense2-standalone.html</a> in directory <strong>&lt;library&gt;/help/documentation/ModelicaLicense2.html</strong>.
</p>

</html>"));
  end License;

  class Copyright "Copyright"
    extends Modelica.Icons.Information;
    annotation (preferredView="info",
    Documentation(info="<html>
<h4><font color=\"#008000\" size=\"5\">Copyright</font></h4>
<p>
Copyright (c) 2017, International Building Performance Simulation Association (IBPSA). All rights reserved.
</p>
</html>"));
  end Copyright;
  annotation (preferredView="info",
  Documentation(info="<html>
<p>
The Modelica <code>IBPSA</code> library is a free open-source library
with classes (models, functions, etc.) that
codify and demonstrate best practices for the implementation of models for
building and community energy and control systems.
</p>
<p>
The development of the IBPSA library is organized through the
<a href=\"https://ibpsa.github.io/project1\">IBPSA Project 1</a>
of the International Building Performance Simulation Association (IBPSA).
From 2012 to 2017, the development was organized through the
<a href=\"http://www.iea-annex60.org\">Annex 60 project</a>
of the Energy in Buildings and Communities Programme of the International Energy Agency (IEA EBC).
</p>
<p>
Many models are based on models from the package
<a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a> and use
the same ports to ensure compatibility with models from that library.
However, a design change is that models from the <code>IBPSA</code>
library do not require the use of
<a href=\"modelica://Modelica.Fluid.System\">Modelica.Fluid.System</a>
as applications in buildings often have multiple fluids with largely varying
flow rates, and therefore a global declaration is impractical.
</p>
<p>
The development page for this library is
<a href=\"https://github.com/ibpsa/modelica\">
https://github.com/ibpsa/modelica</a>.
We welcome contributions from different users to further advance this library,
whether it is through collaborative model development, through model use and testing
or through requirements definition or by providing feedback regarding the model applicability
to solve specific problems.
</p>
<p>
The library has the following <i>User's Guides</i>:
</p>
<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.UsersGuide\">Fluid</a>
   </td>
   <td valign=\"top\">Package for one-dimensional fluid in piping networks with heat exchangers, valves, etc.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Actuators.UsersGuide\">Fluid.Actuators</a>
   </td>
   <td valign=\"top\">Package with valves and air dampers.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Movers.UsersGuide\">Fluid.Movers</a>
   </td>
   <td valign=\"top\">Package with fans and pumps.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Sensors.UsersGuide\">Fluid.Sensors</a>
   </td>
   <td valign=\"top\">Package with sensors.</td>
</tr>
<tr><td valign=\"top\"><a href=\"modelica://IBPSA.Fluid.Interfaces.UsersGuide\">Fluid.Interfaces</a>
   </td>
   <td valign=\"top\">Base models that can be used by developers to implement new models.</td>
</tr>
</table>
</html>"));
end UsersGuide;


annotation (
version="1.0.0",
versionDate="2017-01-17",
dateModified = "2017-01-17",
uses(Modelica(version="3.2.2")),
preferredView="info",
Documentation(info="<html>
<p>
<img
align=\"right\"
alt=\"Logo of IBPSA\"
src=\"modelica://IBPSA/Resources/Images/IBPSA-logo-text.png\" border=\"1\"/>
The <code>IBPSA</code> library is a free library
that provides more than 300 classes (models, functions, etc.) for the development of
Modelica libraries for building and community energy and control systems.
The library is compatible with models from the Modelica Standard Library,
in particular with models from
<a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a>
and
<a href=\"modelica://Modelica.Media\">Modelica.Media</a>.
</p>
<p>
The development of the IBPSA library is organized through the
<a href=\"https://ibpsa.github.io/project1\">IBPSA Project 1</a>
of the International Building Performance Simulation Association (IBPSA).
From 2012 to 2017, the development was organized through the
<a href=\"http://www.iea-annex60.org\">Annex 60 project</a>
of the Energy in Buildings and Communities Programme of the International Energy Agency (IEA EBC).
</p>
<p>
The intent of the library is that it will be extended by
implementations of Modelica libraries that are targeted to end-users.
Major goals are
</p>
<ul>
<li>to codify best practice and to provide a solid foundation onto which
other libraries for building and community energy systems can be built, and
</li>
<li>
to avoid a fragmentation of libraries that serve similar purpose but
that cannot share models among each others, thereby duplicating efforts
for model development and validation.
</li>
</ul>
<p>
Hence, this library is typically not used directly by end-users,
but rather by developers of libraries that will be distributed to end-users.
Libraries that are using the <code>IBPSA</code> library as their core, or
that are working on using the <code>IBPSA</code> as their core, include, in
alphabetic order:
</p>
<ul>
<li>
The <code>AixLib</code> library from RWTH Aachen, Germany, available at
<a href=\"https://github.com/RWTH-EBC/AixLib\">https://github.com/RWTH-EBC/AixLib</a>
</li>
<li>
The <code>Buildings</code> library from Lawrence Berkeley National Laboratory, Berkeley, CA, available at
<a href=\"http://simulationresearch.lbl.gov/modelica\">http://simulationresearch.lbl.gov/modelica/</a>.
</li>
<li>
The <code>BuildingSystems</code> library from
Universit&auml;t der K&uuml;nste Berlin, Germany,
available at
<a href=\"http://www.modelica-buildingsystems.de/\">http://www.modelica-buildingsystems.de/</a>.
</li>
<li>
The <code>IDEAS</code> library from KU Leuven, Belgium, available at
<a href=\"https://github.com/open-ideas/IDEAS\">https://github.com/open-ideas/IDEAS</a>.
</li>
</ul>
<p>
The library also contains more than 300 example and validation models. For Dymola,
each of these example and validation models contains a script that simulates it and
plots certain variables of interest.
</p>
<p>
The web page for this library is
<a href=\"https://github.com/ibpsa/modelica\">https://github.com/ibpsa/modelica</a>.
Contributions to further advance the library are welcomed.
Contributions may not only be in the form of model development, but also
through model use, model testing and validation,
requirements definition or providing feedback regarding the model applicability
to solve specific problems.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Bitmap(extent={{-90,-90},{90,90}},
        fileName="modelica://IBPSA/Resources/Images/IBPSA-logo.png")}));
end IBPSA;
