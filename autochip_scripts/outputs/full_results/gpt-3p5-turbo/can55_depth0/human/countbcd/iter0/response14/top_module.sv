module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:0] ones_digit;
	reg [3:0] tens_digit;
	reg [3:0] hundreds_digit;
	reg [3:0] thousands_digit;

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			ones_digit <= 0;
			tens_digit <= 0;
			hundreds_digit <= 0;
			thousands_digit <= 0;
		end else begin
			if(ena[3]) begin
				if(ones_digit == 9)
					ones_digit <= 0;
				else
					ones_digit <= ones_digit + 1;
			end

			if(ena[2]) begin
				if(tens_digit == 9)
					tens_digit <= 0;
				else
					tens_digit <= tens_digit + 1;
			end

			if(ena[1]) begin
				if(hundreds_digit == 9)
					hundreds_digit <= 0;
				else
					hundreds_digit <= hundreds_digit + 1;
			end

			if(ena[0]) begin
				if(thousands_digit == 9)
					thousands_digit <= 0;
				else
					thousands_digit <= thousands_digit + 1;
			end
		end
	end

	assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};

endmodule
