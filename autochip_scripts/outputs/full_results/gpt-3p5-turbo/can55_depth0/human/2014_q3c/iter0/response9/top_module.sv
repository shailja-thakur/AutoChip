module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

always @(posedge clk)
begin
	case({y, x})
		3'b0000: begin
			Y0 <= 1'b0;
			z <= 1'b0;
		end
		3'b0001: begin
			Y0 <= 1'b0;
			z <= 1'b0;
		end
		3'b0010: begin
			Y0 <= 1'b0;
			z <= 1'b0;
		end
		3'b0011: begin
			Y0 <= 1'b0;
			z <= 1'b1;
		end
		3'b0100: begin
			Y0 <= 1'b1;
			z <= 1'b1;
		end
		default: begin
			Y0 <= 1'b0;
			z <= 1'b0;
		end
	endcase
end

endmodule
