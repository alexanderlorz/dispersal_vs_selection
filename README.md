
<div class="wrap">
	<div id="primary" class="content-area">
		<main id="main" class="site-main" role="main">

			
<article id="post-440" class="post-440 page type-page status-publish hentry">
	<header class="entry-header">
		<h1 class="entry-title">Dispersal homogenizes communities via immigration even at low rates in a synthetic bacterial metacommunity</h1>			</header><!-- .entry-header -->
	<div class="entry-content">
		<p>This folder contains the MATLAB code together with a representative output for the paper “Dispersal homogenizes communities via immigration even at low rates in a synthetic bacterial metacommunity” by Stilianos Fodelianakis, Alexander Lorz, Adriana Valenzuela-Cuevas, Alan Barozzi, Jenny Marie Booth and Daniele Daffonchio.</p>
<p>The folder consists of the following MATLAB functions:</p>
<ol>
<li><strong>cells.m</strong>: represents the ordinary differential equation for the time dynamics of the strains as described in the Supplementary Material; it uses the growth rates computed in the function <strong>growth_r.m</strong> and the fraction of the vessel volume being transported per second, computed in the function <strong>frac_s.m</strong>.</li>
<li><strong>frac_s.m</strong>: computes the fraction of the vessel volume being transported per second at time t.</li>
<li><strong>growth_r.m</strong>: computes the growth rate of each of the three strains at time t.</li>
<li><strong>main.m</strong>: loops over all dispersal speeds and calculates for each dispersal speed the growth-over-migration ratio averaged across strains, vessels and time.</li>
<li><strong>plottin.m</strong>: plots the results.</li>
<li><strong>sum_grow_over_immi.m</strong>: sums the growth-over-immigration ratio.</li>
<li><strong>temperatur.m</strong>: calculates the temperature in each of the three vessels as a function of time t.</li>
</ol>
<p>In addition, there is the MATLAB data file <strong>KKX0.mat</strong> containing the length of the lag phase and the exponential growth rate, both fitted from the experimental data.</p>
<p>Running the MATLAB function <strong>main.m</strong> produces the following output:</p>
<ol>
<li style="list-style-type: none;">
<ol>
<li><strong>growth_over_immigration_speed_pump__3.25to3.85ul_per_s.csv</strong>: contains two rows; the first one with the dispersal speeds (in m^3/s) and the second one with the growth-over-immigration ratio.</li>
<li><strong>growth_over_immigration_speed_pump__3.25to3.85ul_per_s.jpg</strong>: shows the graph growth-over-immigration ratio as a function of dispersal speed.</li>
<li><strong>nnn_speed_pump__3.25to3.85ul_per_s.csv</strong>: contains 73 rows.Each column contains in this order:
<ol>
<li>the dispersal speed,</li>
<li>the population densities of strain B42 in vessel 25 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain B42 in vessel 37 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain B42 in vessel 42 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain E310 in vessel 25 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain E310 in vessel 37 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain E310 in vessel 42 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain E111 in vessel 25 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain E111 in vessel 37 at (30,60,90,120,150,180,210,240) minutes,</li>
<li>the population densities of strain E111 in vessel 42 at (30,60,90,120,150,180,210,240) minutes.</li>
</ol>
</li>
</ol>
<p>In each column, we have 1 dispersal speed, 3 strains, 3 vessels and 8 time points.  This gives 1 + 3*3*8 = 73 rows.</li>
</ol>
<p>The range of dispersal speeds in the first row of <strong>nnn_speed_pump__3.25to3.85ul_per_s.csv</strong> can be modified as follows.</p>
<p>In <strong>main.m</strong>, lines 71 &#8211; 84, we find the following code:</p>
<pre>% large
upper = speed_pump_arr(5);
lower = speed_pump_arr(5)/25;
stepsize=upper/50;

% small
upper = speed_pump_arr(5)/25;
lower = 0;
stepsize=upper/50;

% medium
upper = 3.85e-9;
lower = 3.25e-9;
stepsize=.3e-9;</pre>
<p>These are predefined ranges for the dispersal speeds consisting of upper bound, lower bound and step size. Commenting out the medium range selects the small range. Additionally, commenting out the small range selects the large range. Of course, a new range can also be defined, e.g. by overwriting the variables <em>upper, lower, stepsize</em> after the code defining the medium range in <strong>main.m</strong>.</p>
<p>&nbsp;</p>
<h4><strong><em>Two additional scenarios can be tested by changing the code:</em></strong></h4>
<p><em><strong>1) Scenario without heat coupling:</strong></em></p>
<p>Change the file <strong>temperatur.m</strong> in the following way, while keeping everything else the same:</p>
<p>at the end of the script, replace:</p>
<pre>dydt = f_tube.*[tem1-y(1); tem2-y(2);  tem3-y(3)]... %heat exchange
 +(t_delay&lt;t)*(speed_pump*density/m)*([t_a;t_a;t_a]+...
  [ylag(3)-t_a;ylag(1)-t_a;ylag(2)-t_a]*f_exp-[y(1);y(2);y(3)]); %mixing</pre>
<p>with</p>
<pre>dydt = [0; 0; 0];</pre>
<p><em><strong>2) Scenario without immigration:</strong></em></p>
<p>Change the file <strong>cells.m</strong> in the following way, while keeping everything else the same:</p>
<p>at the end of the script, replace</p>
<pre>dndt = growth_rates'.*[n(1); n(2); n(3) ]...
    +(frac_speed)*[n(3)-n(1);n(1)-n(2);n(2)-n(3)];</pre>
<p>with</p>
<pre>dndt = growth_rates'.*[n(1); n(2); n(3) ]%...
   % +(frac_speed)*[n(3)-n(1);n(1)-n(2);n(2)-n(3)];</pre>
	</div><!-- .entry-content -->
</article><!-- #post-## -->

		