module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

always @(posedge clk) begin
	case({x, y})
		2'b00_000:
			Y0 <= 1'b0;
			z <= 1'b0;
		2'b00_001:
		2'b01_001:
		2'b10_001:
			Y0 <= 1'b0;
			z <= 1'b0;
		2'b00_010:
		2'b11_010:
			Y0 <= 1'b1;
			z <= 1'b0;
		2'b10_011:
		2'b11_011:
			Y0 <= 1'b1;
			z <= 1'b1;
		default:
			Y0 <= 1'b0;
			z <= 1'b0;
	endcase
end

endmodule
