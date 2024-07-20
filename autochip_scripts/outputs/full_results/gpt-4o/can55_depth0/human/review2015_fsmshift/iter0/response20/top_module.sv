module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 3'd4;
			shift_ena <= 1'b1;
		end else if (count != 3'd0) begin
			count <= count - 1;
			shift_ena <= (count != 3'd1);
		end else begin
			shift_ena <= 1'b0;
		end
	end

endmodule
