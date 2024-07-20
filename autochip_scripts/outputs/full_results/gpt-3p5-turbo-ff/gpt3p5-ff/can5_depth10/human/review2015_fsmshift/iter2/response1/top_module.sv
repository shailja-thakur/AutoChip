module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;
	reg reset_shift_ena;

	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
			reset_shift_ena <= 1;
		end else if (reset_shift_ena) begin
			count <= count + 1;
			if (count == 3) begin
				reset_shift_ena <= 0;
			end
		end
		
		if (reset_shift_ena) begin
			shift_ena <= 1;
		end else begin
			shift_ena <= 0;
		end
	end

endmodule
