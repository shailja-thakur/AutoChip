module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg Y2;
reg Y4;

always @(y or w)
begin
	case (y)
		6'b000001: {Y2, Y4} = 2'b00;
		6'b000010: {Y2, Y4} = 2'b10;
		6'b000100: {Y2, Y4} = 2'b11;
		6'b001000: {Y2, Y4} = 2'b11;
		6'b010000: {Y2, Y4} = 2'b11;
		6'b100000: {Y2, Y4} = 2'b11;
		default: {Y2, Y4} = 2'b00;
	endcase
end

endmodule
