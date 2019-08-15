within IBPSA.Media.Refrigerants.DataBase.Refrigerants.R744;
record EoS_I0_P10_100_T233_373 "Records with Coeffizients for EoS"
  extends
    IBPSA.Media.Refrigerants.DataBase.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from Span,Wagner 'A New Equation of State for Carbon Dioxide Covering the Fluid Region from the Triple-
      Point Temperature to 1100 K at Pressures up to 800 MPa'",
    f_IdgNl=1,
    f_IdgL1={2.5},
    f_IdgL2={1},
    f_IdgNp=2,
    f_IdgP1={8.37304456,-3.70454304},
    f_IdgP2={0,1},
    f_IdgNe=5,
    f_IdgE1={1.99427042,0.62105248,0.41195293,1.04028922,0.08327678},
    f_IdgE2={3.15163,6.11190,6.77708,11.32384,27.08792},
    f_ResNp=7,
    f_ResP1={0.38856823203161,0.29385475942740E+01,-0.55867188534934E+01,-0.76753199592477E+00,
        0.31729005580416E+00,0.54803315897737E+00,0.12279411220335E+00},
    f_ResP2={1,1,1,1,2,2,3},
    f_ResP3={0,0.75,1,2,0.75,2,0.75},
    f_ResNb=27,
    f_ResB1={0.21658961543220E+01,0.15841735109724E+01,-0.23132705405503E+00,0.58116916431436E-01,
        -0.55369137205382E+00,0.48946615909422E+00,-0.24275739843501E-01,0.62494790501678E-01,
        -0.12175860225246E+00,-0.37055685270086E+00,-0.16775879700426E-01,-0.11960736637987E+00,
        -0.45619362508778E-01,0.35612789270346E-01,-0.74427727132052E-02,-0.17395704902432E-02,
        -0.21810121289527E-01,0.24332166559236E-01,-0.37440133423463E-01,0.14338715756878E+00,
        -0.13491969083286E+00,-0.23151225053480E-01,0.12363125492901E-01,0.21058321972940E-02,
        -0.33958519026368E-03,0.55993651771592E-02,-0.30335118055646E-03},
    f_ResB2={1,2,4,5,5,5,6,6,6,1,1,4,4,4,7,8,2,3,3,5,5,6,7,8,10,4,8},
    f_ResB3={1.5,1.5,2.5,0,1.5,2,0,1,2,3,6,3,6,8,6,0,7,12,16,22,24,16,24,8,2,28,
        14},
    f_ResB4={1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,4,4,4,4,4,4,5,6},
    f_ResNG=5,
    f_ResG1={-0.21365488688320E+03,0.26641569149272E+05,-0.24027212204557E+05,
        -0.28341603423999E+03,0.21247284400179E+03},
    f_ResG2={2,2,2,3,3},
    f_ResG3={1,0,1,3,3},
    f_ResG4={25,25,25,15,20},
    f_ResG5={1,1,1,1,1},
    f_ResG6={325,300,300,275,275},
    f_ResG7={1.16,1.19,1.19,1.25,1.22},
    f_ResNNa=3,
    f_ResNa1={-0.66642276540751E+00,0.72608632349897E+00,0.550686686128E-01},
    f_ResNa2={0.875,0.925,0.875},
    f_ResNa3={10,10,12.5},
    f_ResNa4={275,275,275},
    f_ResNa5={0.7,0.7,0.7},
    f_ResNa6={0.3,0.3,0.3},
    f_ResNa7={0.3,0.3,1},
    f_ResNa8={3.5,3.5,3});

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>December 10, 2018, by Stephan Goebel:</li>
<li>First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/665\">issue 665</a>). </li>
<li>July 15, 2019, by Christian Vering</li>
</ul>
</html>"));

end EoS_I0_P10_100_T233_373;
