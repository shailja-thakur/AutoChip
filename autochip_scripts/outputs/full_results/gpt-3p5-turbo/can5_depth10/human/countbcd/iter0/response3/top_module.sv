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
		if (reset)
			begin
				ones <= 4'b0000;
				tens <= 4'b0000;
				hundreds <= 4'b0000;
				thousands <= 4'b0000;
			end
		else
			begin
				if (ena[1])
					begin
						ones <= ones + 1;
						if (ones > 9)
							ones <= 4'b0000;
					end
				if (ena[2])
					begin
						tens <= tens + 1;
						if (tens > 9)
							tens <= 4'b0000;
					end
				if (ena[3])
					begin
						hundreds <= hundreds + 1;
						if (hundreds > 9)
							hundreds <= 4'b0000;
					end
				thousands <= thousands + 1;
				if (thousands > 9)
					thousands <= 4'b0000;
			end
	end
	
	assign q = {thousands, hundreds, tens, ones};
	
endmodule
