module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always @(y or w)
	begin
		case (y)
			6'b000001: Y1 = w;
			6'b000010: Y1 = 1'b0;
			6'b000100: Y1 = w;
			6'b001000: Y1 = 1'b0;
			6'b010000: Y1 = w;
			6'b100000: Y1 = 1'b0;
			default: Y1 = 1'b0;
		endcase
		
		case (y)
			6'b000001: Y3 = 1'b0;
			6'b000010: Y3 = w;
			6'b000100: Y3 = 1'b0;
			6'b001000: Y3 = w;
			6'b010000: Y3 = 1'b0;
			6'b100000: Y3 = w;
			default: Y3 = 1'b0;
		endcase
	end
endmodule
