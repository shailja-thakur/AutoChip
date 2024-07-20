module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg shift_ena;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 1'b1;
		end else if (shift_ena == 1'b1) begin
			shift_ena <= 1'b0;
		end
	end

endmodule
