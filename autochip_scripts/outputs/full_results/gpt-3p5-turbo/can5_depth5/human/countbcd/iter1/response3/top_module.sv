module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			// Increment ones digit
			if (ena[1])
				q[3:0] <= q[3:0] + 1;

			// Increment tens digit
			if (ena[2])
				q[7:4] <= q[7:4] + 1;
			
			// Increment hundreds digit
			if (ena[3])
				q[11:8] <= q[11:8] + 1;
			
			// Increment thousands digit
			q[15:12] <= q[15:12] + 1;
		end
	end
	
	// Set initial values for ena and q
	initial begin
		ena <= 0;
		q <= 0;
	end

endmodule
