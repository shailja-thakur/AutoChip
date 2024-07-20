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
		2'b00_000: begin
			Y <= 3'b00_000;
			z <= 1'b0;
		end
		2'b00_001, 2'b01_001: begin
			Y <= 3'b00_001;
			z <= 1'b0;
		end
		2'b00_010: begin
			Y <= 3'b00_010;
			z <= 1'b0;
		end
		2'b00_011, 2'b01_011: begin
			Y <= 3'b00_001;
			z <= 1'b1;
		end
		2'b00_100: begin
			Y <= 3'b00_011;
			z <= 1'b1;
		end
		default: begin
			Y <= 3'bxxx; // Handle invalid states
			z <= 1'bx; // Handle invalid output
		end
	endcase
end

assign Y0 = Y[0];

endmodule
