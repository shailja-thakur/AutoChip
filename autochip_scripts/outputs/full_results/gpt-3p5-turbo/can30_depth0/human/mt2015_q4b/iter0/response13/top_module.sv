module top_module(
	input x,
	input y,
	output z);
	// Define internal signals
	reg z_internal;

	// Assign internal signals to output
	assign z = z_internal;

	// Always block to update z_internal
	always @(x, y)
	begin
		case({x, y})
			2'b00: z_internal = 1;
			2'b10: z_internal = 0;
			2'b11: z_internal = 1;
			default: z_internal = 0;
		endcase
	end
endmodule
