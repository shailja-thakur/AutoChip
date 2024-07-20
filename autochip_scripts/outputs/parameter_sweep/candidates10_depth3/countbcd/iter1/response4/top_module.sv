module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] ones;
	reg [3:0] tens;
	reg [3:0] hundreds;
	reg [3:0] thousands;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			ones <= 4'b0000;
			tens <= 4'b0000;
			hundreds <= 4'b0000;
			thousands <= 4'b0000;
			q <= {thousands, hundreds, tens, ones};
		end else if (ena[1]) begin
			ones <= ones + 1;
			if (ones > 9) begin
				ones <= 4'b0000;
				tens <= tens + 1;
				if (tens > 9) begin
					tens <= 4'b0000;
					hundreds <= hundreds + 1;
					if (hundreds > 9) begin
						hundreds <= 4'b0000;
						thousands <= thousands + 1;
						if (thousands > 9)
							thousands <= 4'b0000;
					end
				end
			end
			q <= {thousands, hundreds, tens, ones};
		end
	end
endmodule
