module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] shift_count;

	always @(posedge clk) begin
		if (reset) begin
			shift_count <= 3'd4;
			shift_ena <= 1'b1;
		end else if (shift_count > 0) begin
			shift_count <= shift_count - 1;
			shift_ena <= 1'b1;
		end else begin
			shift_ena <= 1'b0;
		end
	end

endmodule
