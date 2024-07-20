module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	// Internal wires and registers
	reg [3:0] q0, q1, q2, q3;
	
	// Output assignment
	assign ena = {reset, q3[0], q2[0]};
	assign q = {q3, q2, q1, q0};
	
	// Counter logic
	always@(posedge clk or posedge reset) begin
		if (reset) begin
			q0 <= 4'b0000;
			q1 <= 4'b0000;
			q2 <= 4'b0000;
			q3 <= 4'b0001;
		end else begin
			if (ena[0])
				q0 <= q0 + 1;
			if (ena[1])
				q1 <= q1 + 1;
			if (ena[2])
				q2 <= q2 + 1;
			if (q0 == 4'b1010) begin
				q0 <= 4'b0000;
				if (q1 == 4'b1001) begin
					q1 <= 4'b0000;
					if (q2 == 4'b1001)
						q2 <= 4'b0000;
					else
						q2 <= q2 + 1;
				end else
					q1 <= q1 + 1;
			end else
				q0 <= q0 + 1;
		end
	end
endmodule
