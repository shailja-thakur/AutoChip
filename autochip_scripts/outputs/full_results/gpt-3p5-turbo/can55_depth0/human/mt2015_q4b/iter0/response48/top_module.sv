module top_module(
	input x,
	input y,
	output z);
	
	// Define internal signals
	reg z_reg;
	
	// Sequential logic for z_reg
	always @(posedge clk) begin
		if (reset) begin
			z_reg <= 0;
		end else begin
			if (x && y) begin
				z_reg <= 1;
			end else begin
				z_reg <= 0;
			end
		end
	end
	
	// Assign the output signal z
	assign z = z_reg;
	
endmodule
