module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	// Define internal signals
	reg [3:0] ones_digit;
	reg [3:0] tens_digit;
	reg [3:0] hundreds_digit;
	reg [3:0] thousands_digit;
	
	// Assign ones digit
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			ones_digit <= 4'b0000;
		end else begin
			if (ena[1]) begin
				if (ones_digit == 4'b1001) begin
					ones_digit <= 4'b0000;
				end else begin
					ones_digit <= ones_digit + 1;
				end
			end
		end
	end
	
	// Assign tens digit
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			tens_digit <= 4'b0000;
		end else begin
			if (ena[2]) begin
				if (tens_digit == 4'b1001) begin
					tens_digit <= 4'b0000;
				end else begin
					tens_digit <= tens_digit + 1;
				end
			end
		end
	end
	
	// Assign hundreds digit
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			hundreds_digit <= 4'b0000;
		end else begin
			if (ena[3]) begin
				if (hundreds_digit == 4'b1001) begin
					hundreds_digit <= 4'b0000;
				end else begin
					hundreds_digit <= hundreds_digit + 1;
				end
			end
		end
	end
	
	// Assign thousands digit
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			thousands_digit <= 4'b0000;
		end else begin
			if (q[15] == 1) begin
				if (thousands_digit == 4'b1001) begin
					thousands_digit <= 4'b0000;
				end else begin
					thousands_digit <= thousands_digit + 1;
				end
			end
		end
	end
	
	// Concatenate all digits to form the 4-digit BCD value
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000_0000_0000_0000;
		end else begin
			q <= {thousands_digit, hundreds_digit, tens_digit, ones_digit};
		end
	end
endmodule
