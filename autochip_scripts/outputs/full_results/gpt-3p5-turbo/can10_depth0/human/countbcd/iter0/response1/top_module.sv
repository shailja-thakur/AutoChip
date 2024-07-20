module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	// Internal wires and registers
	reg [3:0] q0, q1, q2, q3; // Four decimal digits
	
	// Reset logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			if (ena[1])
				q0 <= q0 + 1;
			if (ena[2])
				q1 <= q1 + 1;
			if (ena[3])
				q2 <= q2 + 1;
			q3 <= q3 + 1;
		end
	end
	
	// Assign outputs
	assign q = {q3, q2, q1, q0};

endmodule
