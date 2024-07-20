module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Define internal signals
	reg [3:0] q_ones;
	reg [3:0] q_tens;
	reg [3:0] q_hundreds;
	reg [3:0] q_thousands;

	// Assign outputs
	assign q = {q_thousands, q_hundreds, q_tens, q_ones};
	assign ena = {reset, q_thousands, q_hundreds, q_tens}; // Enable signals for upper three digits

	// Counter logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_ones <= 4'b0000;
			q_tens <= 4'b0000;
			q_hundreds <= 4'b0000;
			q_thousands <= 4'b0000;
		end
		else begin
			if (ena[0]) begin
				if (q_ones == 4'b1001) begin
					q_ones <= 4'b0000;
					if (ena[1]) begin
						if (q_tens == 4'b1001) begin
							q_tens <= 4'b0000;
							if (ena[2]) begin
								if (q_hundreds == 4'b1001) begin
									q_hundreds <= 4'b0000;
									if (q_thousands != 4'b1001)
										q_thousands <= q_thousands + 4'b0001;
								end
								else
									q_hundreds <= q_hundreds + 4'b0001;
							end
						end
						else
							q_tens <= q_tens + 4'b0001;
					end
				end
				else
					q_ones <= q_ones + 4'b0001;
			end
		end
	end
	
endmodule
