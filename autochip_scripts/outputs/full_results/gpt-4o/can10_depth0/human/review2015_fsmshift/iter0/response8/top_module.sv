module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] count;
	reg detected;  // This flag indicates when the pattern is detected

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1;
			count <= 2'b00;
			detected <= 0;
		end else if (shift_ena) begin
			if (count == 2'b11) begin
				shift_ena <= 0;
			end else begin
				count <= count + 1;
			end
		end
	end
endmodule
