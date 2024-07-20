module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
	case ({x, y})
		2'b00x: begin
			Y <= 3'b000;
			z <= 1'b0;
		end
		2'b01x: begin
			Y <= 3'b001;
			z <= 1'b0;
		end
		2'b10x: begin
			Y <= 3'b010;
			z <= 1'b0;
		end
		2'b11x: begin
			Y <= 3'b001;
			z <= 1'b1;
		end
		2'b1xx: begin
			Y <= 3'b011;
			z <= 1'b1;
		end
	endcase
end

assign Y0 = Y[0];

endmodule
