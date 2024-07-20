module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg [2:0] Y,
	output reg z
);

always @(posedge clk) begin
	case (y)
		3'b000: begin
			Y <= x ? 3'b001 : 3'b000;
			z <= 0;
		end
		3'b001: begin
			Y <= x ? 3'b100 : 3'b001;
			z <= 0;
		end
		3'b010: begin
			Y <= x ? 3'b001 : 3'b010;
			z <= 0;
		end
		3'b011: begin
			Y <= x ? 3'b010 : 3'b001;
			z <= 1;
		end
		3'b100: begin
			Y <= x ? 3'b100 : 3'b011;
			z <= 1;
		end
		default: begin
			Y <= 3'b000;
			z <= 0;
		end
	endcase
end

always @(posedge clk) begin
	Y0 <= Y[0];
end

endmodule
