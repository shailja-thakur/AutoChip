module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	reg z_internal;

	// Assignments
	always @(x, y) begin
		// Your logic here
		case(x)
			1'b0: z_internal = 1'b1;
			1'b1: z_internal = y;
		endcase
	end

	// Output assignment
	assign z = z_internal;

endmodule
