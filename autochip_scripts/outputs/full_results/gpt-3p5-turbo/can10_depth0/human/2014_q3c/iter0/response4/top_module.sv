module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
	case ({y, x})
		3'b000, 1'b0: begin
			Y <= 3'b000;
			Y0 <= Y[0];
			z <= 1'b0;
		end
		3'b001, 1'b0: begin
			Y <= 3'b001;
			Y0 <= Y[0];
			z <= 1'b0;
		end
		3'b010, 1'b0: begin
			Y <= 3'b010;
			Y0 <= Y[0];
			z <= 1'b0;
		end
		3'b011, 1'b0: begin
			Y <= 3'b001;
			Y0 <= Y[0];
			z <= 1'b1;
		end
		3'b100, 1'b0: begin
			Y <= 3'b011;
			Y0 <= Y[0];
			z <= 1'b1;
		end
		default: begin
			Y <= 3'bxxx;
			Y0 <= Y[0];
			z <= 1'b0;
		end
	endcase
end

endmodule
