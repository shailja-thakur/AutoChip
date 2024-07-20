module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	reg x_reg;
	reg y_reg;
	reg z_reg;

	// Assign inputs to internal signals
	always @(x) begin
		x_reg <= x;
	end
	
	always @(y) begin
		y_reg <= y;
	end
	
	// Define combinational logic for the output
	always @(x_reg, y_reg) begin
		if (x_reg && y_reg) begin
			z_reg <= 1;
		end else begin
			z_reg <= 0;
		end
	end
	
	// Assign the internal signal to the output
	assign z = z_reg;
	
endmodule
