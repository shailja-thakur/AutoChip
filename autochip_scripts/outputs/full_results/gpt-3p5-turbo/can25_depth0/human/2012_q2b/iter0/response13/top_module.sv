module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always @(y) begin
	// Y1
	case(y[5:0])
		6'b000001: Y1 = y[1];
		6'b000010: Y1 = y[1];
		6'b000100: Y1 = y[3];
		6'b001000: Y1 = y[3];
		6'b010000: Y1 = y[1];
		6'b100000: Y1 = y[3];
		default: Y1 = 0;
	endcase
	
	// Y3
	case(y[5:0])
		6'b000001: Y3 = y[3];
		6'b000010: Y3 = y[1];
		6'b000100: Y3 = y[3];
		6'b001000: Y3 = y[1];
		6'b010000: Y3 = y[3];
		6'b100000: Y3 = y[3];
		default: Y3 = 0;
	endcase
end

endmodule
