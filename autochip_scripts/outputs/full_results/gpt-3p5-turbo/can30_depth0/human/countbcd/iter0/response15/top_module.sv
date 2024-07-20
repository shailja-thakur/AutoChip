module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal signals
	reg [3:0] q0;
	reg [3:0] q1;
	reg [3:0] q2;
	reg [3:0] q3;

	// Output signals
	assign q = {q3, q2, q1, q0};

	// Counter logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q0 <= 4'b0000;
			q1 <= 4'b0000;
			q2 <= 4'b0000;
			q3 <= 4'b0000;
		end else if (ena[0]) begin
			q0 <= q0 + 1;
			if (q0 == 10) begin
				q0 <= 4'b0000;
				q1 <= q1 + 1;
				if (q1 == 10) begin
					q1 <= 4'b0000;
					q2 <= q2 + 1;
					if (q2 == 10) begin
						q2 <= 4'b0000;
						q3 <= q3 + 1;
						if (q3 == 10) begin
							q3 <= 4'b0000;
						end
					end
				end
			end
		end
	end

	// Enable signals
	assign ena[0] = 1;
	assign ena[1] = q0 == 10;
	assign ena[2] = q1 == 10;

endmodule
