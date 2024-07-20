module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	// Define internal signals and variables
	reg [3:0] q_ones;
	reg [3:0] q_tens;
	reg [3:0] q_hundreds;
	reg [3:1] ena_internal;
	
	// Synchronous logic for counting
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_ones <= 4'b0000;
			q_tens <= 4'b0000;
			q_hundreds <= 4'b0000;
		end else begin
			if (ena_internal[1]) begin
				if (q_ones == 4'b1001)
					q_ones <= 4'b0000;
				else
					q_ones <= q_ones + 1;
			end

			if (ena_internal[2]) begin
				if (q_tens == 4'b1001)
					q_tens <= 4'b0000;
				else
					q_tens <= q_tens + 1;
			end

			if (ena_internal[3]) begin
				if (q_hundreds == 4'b1001)
					q_hundreds <= 4'b0000;
				else
					q_hundreds <= q_hundreds + 1;
			end
		end
	end
	
	// Assign values to output signals
	assign ena = ena_internal;
	assign q[3:0] = q_ones;
	assign q[7:4] = q_tens;
	assign q[11:8] = q_hundreds;
endmodule
