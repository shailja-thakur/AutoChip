module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;
	reg shift_ena;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 4'b1111;
			shift_ena <= 1'b1;
		end else if (count > 0) begin
			count <= count - 1;
			shift_ena <= 1'b1;
		end else begin
			shift_ena <= 1'b0;
		end
	end
endmodule
