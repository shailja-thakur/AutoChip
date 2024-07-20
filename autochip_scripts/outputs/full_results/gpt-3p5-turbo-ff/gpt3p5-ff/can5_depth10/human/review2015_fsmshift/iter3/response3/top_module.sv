module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
			shift_ena <= 0; // Set shift_ena to 0 on reset
		end else begin
			if (count < 4) begin
				count <= count + 1;
				shift_ena <= 1;
			end else begin
				shift_ena <= 0;
			end
		end
	end

endmodule
