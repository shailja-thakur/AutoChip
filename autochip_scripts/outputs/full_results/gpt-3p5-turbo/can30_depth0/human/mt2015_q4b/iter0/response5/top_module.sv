module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	reg z_reg;

	// Assign output z to z_reg
	assign z = z_reg;

	// Create always block for sequential logic
	always @(x, y) begin
		// Define the logic for z_reg
		case({x, y})
			2'b01: z_reg <= 1'b0;
			2'b10: z_reg <= 1'b0;
			default: z_reg <= 1'b1;
		endcase
	end

endmodule
