module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal signal to keep track of individual BCD digits
	reg [3:0] ones, tens, hundreds, thousands;

	// Enable signals for incrementing each digit
	assign ena[1] = (ones == 4'd9);
	assign ena[2] = (ena[1] && (tens == 4'd9));
	assign ena[3] = (ena[2] && (hundreds == 4'd9));

	always @(posedge clk) begin
		if (reset) begin
			ones <= 4'd0;
			tens <= 4'd0;
			hundreds <= 4'd0;
			thousands <= 4'd0;
		end
		else begin
			if (ones == 4'd9) begin
				ones <= 4'd0;
				if (tens == 4'd9) begin
					tens <= 4'd0;
					if (hundreds == 4'd9) begin
						hundreds <= 4'd0;
						if (thousands == 4'd9) begin
							thousands <= 4'd0;
						end
						else begin
							thousands <= thousands + 1;
						end
					end
					else begin
						hundreds <= hundreds + 1;
					end
				end
				else begin
					tens <= tens + 1;
				end
			end
			else begin
				ones <= ones + 1;
			end
		end
	end

	// Combine the digits back into the output registers
	always @(posedge clk) begin
		if (reset) begin
			q <= 16'd0;
		end
		else begin
			q[3:0] <= ones;
			q[7:4] <= tens;
			q[11:8] <= hundreds;
			q[15:12] <= thousands;
		end
	end
endmodule
