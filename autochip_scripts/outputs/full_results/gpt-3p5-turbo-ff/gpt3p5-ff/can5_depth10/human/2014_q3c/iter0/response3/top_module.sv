module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	reg [2:0] Y;
	
	always @(posedge clk) begin
		case({y, x})
			3'b000_0: Y <= 3'b000;
			3'b000_1: Y <= 3'b001;
			3'b001_0: Y <= 3'b001;
			3'b001_1: Y <= 3'b100;
			3'b010_0: Y <= 3'b010;
			3'b010_1: Y <= 3'b001;
			3'b011_0: Y <= 3'b001;
			3'b011_1: Y <= 3'b010;
			3'b100_0: Y <= 3'b011;
			3'b100_1: Y <= 3'b100;
			default: Y <= 3'b0;
		endcase
	end
	
	always @(posedge clk) begin
		case(Y)
			3'b011: z <= 1'b1;
			3'b100: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end
	
	assign Y0 = Y[0];
endmodule
