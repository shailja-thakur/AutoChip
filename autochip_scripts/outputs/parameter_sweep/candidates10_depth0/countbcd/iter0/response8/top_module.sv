module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Define internal signals
	reg [3:0] q0;
	reg [3:0] q1;
	reg [3:0] q2;
	reg [3:0] q3;
	reg [2:0] count;

	// Synchronous counter
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q0 <= 4'b0000;
			q1 <= 4'b0000;
			q2 <= 4'b0000;
			q3 <= 4'b0000;
			count <= 3'b000;
		end else if (ena[0]) begin
			q0 <= q0 + 1;
		end else if (ena[1]) begin
			q1 <= q1 + 1;
			if (q1 == 10) begin
				q1 <= 4'b0000;
				count <= count + 1;
			end
		end else if (ena[2]) begin
			q2 <= q2 + 1;
			if (q2 == 10) begin
				q2 <= 4'b0000;
				count <= count + 1;
			end
		end else if (count[2]) begin
			q3 <= q3 + 1;
			if (q3 == 10) begin
				q3 <= 4'b0000;
			end
		end
	end

	// Output assignment
	assign ena = count;
	assign q = {q3, q2, q1, q0};

endmodule
