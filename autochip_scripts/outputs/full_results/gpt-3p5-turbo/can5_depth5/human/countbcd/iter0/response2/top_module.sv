module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal wire declarations
	wire [3:0] q_ones;    // ones digit
	wire [3:0] q_tens;    // tens digit
	wire [3:0] q_hundreds;    // hundreds digit
	wire [3:0] q_thousands;    // thousands digit

	// Internal reg declarations
	reg [3:0] count_ones;    // ones digit count
	reg [3:0] count_tens;    // tens digit count
	reg [3:0] count_hundreds;    // hundreds digit count
	reg [3:0] count_thousands;    // thousands digit count

	// Counter logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count_ones <= 4'b0000;
			count_tens <= 4'b0000;
			count_hundreds <= 4'b0000;
			count_thousands <= 4'b0000;
		end else begin
			if (ena[0]) begin
				if (count_ones == 4'b1001)
					count_ones <= 4'b0000;
				else
					count_ones <= count_ones + 1;
			end

			if (ena[1]) begin
				if (count_tens == 4'b1001)
					count_tens <= 4'b0000;
				else
					count_tens <= count_tens + 1;
			end

			if (ena[2]) begin
				if (count_hundreds == 4'b1001)
					count_hundreds <= 4'b0000;
				else
					count_hundreds <= count_hundreds + 1;
			end

			if (ena[3]) begin
				if (count_thousands == 4'b1001)
					count_thousands <= 4'b0000;
				else
					count_thousands <= count_thousands + 1;
			end
		end
	end

	// Output logic
	assign q_ones = count_ones;
	assign q_tens = count_tens;
	assign q_hundreds = count_hundreds;
	assign q_thousands = count_thousands;

	assign q = {q_ones, q_tens, q_hundreds, q_thousands};

endmodule
