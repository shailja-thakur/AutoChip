module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;
	reg ena;

	always @(posedge clk) begin
		ena <= reset ? 1'b1 : 1'b0;
		if (ena)
			count <= 4'b1111;
		else if (count > 4'b0000)
			count <= count - 4'b0001;
		end
	end

	assign shift_ena = count > 4'b0000;

endmodule
