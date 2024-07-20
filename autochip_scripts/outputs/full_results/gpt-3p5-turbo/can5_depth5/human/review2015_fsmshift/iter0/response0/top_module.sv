module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;

	always @(posedge clk) begin
		if (reset)
			count <= 4'b0;
		else if (count < 4'b0101)
			count <= count + 1;
		else
			count <= 4'b0;
	end

	assign shift_ena = (count == 4'b0101);

endmodule
