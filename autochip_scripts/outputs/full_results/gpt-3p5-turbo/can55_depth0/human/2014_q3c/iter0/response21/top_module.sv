module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// Present state y[2:0] | Next state Y[2:0] x=0, Next state Y[2:0] x=1 | Output z
// 000 | 000, 001 | 0
// 001 | 001, 100 | 0
// 010 | 010, 001 | 0
// 011 | 001, 010 | 1
// 100 | 011, 100 | 1

always @(posedge clk) begin
	case({x, y})
		2'b00: begin
			Y0 <= 0;
			z <= 0;
		end
		2'b01: begin
			Y0 <= x;
			z <= 0;
		end
		2'b10: begin
			Y0 <= ~x;
			z <= 0;
		end
		2'b11: begin
			Y0 <= x;
			z <= 1;
		end
	endcase
end

endmodule
