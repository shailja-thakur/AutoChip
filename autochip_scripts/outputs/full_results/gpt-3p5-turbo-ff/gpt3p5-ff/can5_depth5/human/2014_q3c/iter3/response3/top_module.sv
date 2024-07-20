module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg [2:0] Y,
	output reg Y0,
	output reg z
);

always @(posedge clk) begin
	case(y)
		3'b000:
			if (x == 0) begin
				Y <= 3'b000;
			end else begin
				Y <= 3'b001;
			end
			Y0 <= Y[0];
			z <= 0;
		3'b001:
			if (x == 0) begin
				Y <= 3'b001;
			end else begin
				Y <= 3'b100;
			end
			Y0 <= Y[0];
			z <= 0;
		3'b010:
			if (x == 0) begin
				Y <= 3'b010;
			end else begin
				Y <= 3'b001;
			end
			Y0 <= Y[0];
			z <= 0;
		3'b011:
			if (x == 0) begin
				Y <= 3'b001;
			end else begin
				Y <= 3'b010;
			end
			Y0 <= Y[0];
			z <= 1;
		3'b100:
			if (x == 0) begin
				Y <= 3'b011;
			end else begin
				Y <= 3'b100;
			end
			Y0 <= Y[0];
			z <= 1;
	endcase
end

endmodule
