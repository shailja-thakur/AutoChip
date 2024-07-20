module top_module(
	input x,
	input y,
	output z);

	// Declare internal wire and reg variables
	wire x_delay_25ns;
	wire x_delay_55ns;
	wire y_delay_55ns;
	reg z_delay_55ns;
	
	// Delay declarations
	// Delay x by 25ns
	DelayXBy25ns delay_x_25ns(
		.x(x),
		.x_delay(x_delay_25ns)
	);
	// Delay x and y by 55ns
	DelayXYBy55ns delay_xy_55ns(
		.x(x),
		.y(y),
		.x_delay(x_delay_55ns),
		.y_delay(y_delay_55ns)
	);
	// Delay z by 55ns
	DelayZBy55ns delay_z_55ns(
		.z(z),
		.z_delay(z_delay_55ns)
	);
	
	// Output assignment
	assign z = z_delay_55ns;
	
	// Module instantiations for delay elements
	// DelayXBy25ns module definition
	module DelayXBy25ns(
		input x,
		output x_delay);
		
		reg x_reg;
		
		always @(posedge clk) begin
			x_reg <= x;
		end
		
		assign x_delay = x_reg;
			
	endmodule
module DelayXYBy55ns(
		input x,
		input y,
		output x_delay,
		output y_delay);
	
		reg x_reg;
		reg y_reg;
	
		always @(posedge clk) begin
			x_reg <= x;
			y_reg <= y;
		end
	
		assign x_delay = x_reg;
		assign y_delay = y_reg;
	
	endmodule
module DelayZBy55ns(
		input z,
		output z_delay);
	
		reg z_reg;
	
		always @(posedge clk) begin
			z_reg <= z;
		end
	
		assign z_delay = z_reg;
	
	endmodule
