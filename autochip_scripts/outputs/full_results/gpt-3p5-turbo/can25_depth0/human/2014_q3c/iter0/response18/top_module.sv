module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

reg [2:0] Y;

always @(posedge clk) begin
	if (x == 0) begin
		case(y)
			3'b000: Y <= 3'b000;
			3'b001: Y <= 3'b001;
			3'b010: Y <= 3'b010;
			3'b011: Y <= 3'b001;
			3'b100: Y <= 3'b011;
		endcase
	else begin
		case(y)
			3'b000: Y <= 3'b001;
			3'b001: Y <= 3'b100;
			3'b010: Y <= 3'b001;
			3'b011: Y <= 3'b010;
			3'b100: Y <= 3'b100;
		endcase
	end
end

always @(posedge clk) begin
	case(Y[0])
		1'b0: z <= 1'b0;
		1'b1: z <= 1'b1;
	endcase
end

assign Y0 = Y[0];

endmodule
