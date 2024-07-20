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
			3'b000, x==0: Y <= 3'b000;
			3'b000, x==1: Y <= 3'b001;
			3'b001, x==0: Y <= 3'b001;
			3'b001, x==1: Y <= 3'b100;
			3'b010, x==0: Y <= 3'b010;
			3'b010, x==1: Y <= 3'b001;
			3'b011, x==0: Y <= 3'b001;
			3'b011, x==1: Y <= 3'b010;
			3'b100, x==0: Y <= 3'b011;
			3'b100, x==1: Y <= 3'b100;
		endcase
	end
	
	always @(posedge clk) begin
		case(Y)
			3'b011, 3'b100: z <= 1;
			default: z <= 0;
		endcase
	end
	
	assign Y0 = Y[0];
	
endmodule
