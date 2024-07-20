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
			Y[2:0] <= 3'b00_000;
			Y0 <= Y[0];
			z <= 1'b0;
		end
		2'b00_001: begin
			Y[2:0] <= 3'b00_001;
			Y0 <= Y[0];
			z <= 1'b0;
		end
		2'b01_010: begin
			Y[2:0] <= 3'b01_010;
			Y0 <= Y[0];
			z <= 1'b0;
		end
		2'b01_001: begin
			Y[2:0] <= 3'b01_001;
			Y0 <= Y[0];
			z <= 1'b1;
		end
		2'b10_100: begin
			Y[2:0] <= 3'b10_100;
			Y0 <= Y[0];
			z <= 1'b1;
		end
		default: begin
			Y[2:0] <= 3'b00_000;
			Y0 <= Y[0];
			z <= 1'b0;
		end
	endcase
end

endmodule
