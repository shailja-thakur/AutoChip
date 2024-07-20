module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	reg [4:0] sum_reg;

	always @ (x or y) begin
		sum_reg = x + y;
	end

	assign sum = sum_reg;

endmodule
