module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

always @(posedge clk) begin
	case (y)
		3'b000: begin
			if (x == 0)
				Y0 <= 0; // Y[2:0] = 000
			else
				Y0 <= 1; // Y[2:0] = 001
			z <= 0;
		end
		3'b001: begin
			if (x == 0)
				Y0 <= 1; // Y[2:0] = 001
			else
				Y0 <= 0; // Y[2:0] = 100
			z <= 0;
		end
		3'b010: begin
			if (x == 0)
				Y0 <= 2; // Y[2:0] = 010
			else
				Y0 <= 1; // Y[2:0] = 001
			z <= 0;
		end
		3'b011: begin
			if (x == 0)
				Y0 <= 1; // Y[2:0] = 001
			else
				Y0 <= 2; // Y[2:0] = 010
			z <= 1;
		end
		3'b100: begin
			if (x == 0)
				Y0 <= 3; // Y[2:0] = 011
			else
				Y0 <= 4; // Y[2:0] = 100
			z <= 1;
		end
		default: begin
			Y0 <= 0;
			z <= 0;
		end
	endcase
end

endmodule
