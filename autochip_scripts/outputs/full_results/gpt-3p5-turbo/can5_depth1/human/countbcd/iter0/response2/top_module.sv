module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 16'b0000; // Reset to 0
		else begin
			if (ena[1])
				q[3:0] <= q[3:0] + 1; // Increment ones digit when ena[1] is high
			if (ena[2])
				q[7:4] <= q[7:4] + 1; // Increment tens digit when ena[2] is high
			if (ena[3])
				q[11:8] <= q[11:8] + 1; // Increment hundreds digit when ena[3] is high
			// No increment for thousands digit

			// Carry propagation
			if (q[3:0] == 10) begin
				q[3:0] <= 0;
				if(q[7:4] == 10) begin
					q[7:4] <= 0;
					if(q[11:8] == 10)
						q[11:8] <= 0;
				end
			end
		end
	end
endmodule
