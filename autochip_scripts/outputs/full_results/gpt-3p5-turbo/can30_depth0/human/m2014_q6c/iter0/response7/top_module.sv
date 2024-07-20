module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

// State assignment
parameter A = 6'b000001;
parameter B = 6'b000010;
parameter C = 6'b000100;
parameter D = 6'b001000;
parameter E = 6'b010000;
parameter F = 6'b100000;

// Next-state logic for Y2
always @(*)
begin
	case(y)
		A: Y2 = 1'b1;
		B: Y2 = 1'b0;
		C: Y2 = 1'b0;
		D: Y2 = 1'b1;
		E: Y2 = 1'b1;
		F: Y2 = 1'b0;
	endcase
end

// Next-state logic for Y4
always @(*)
begin
	case(y)
		A: Y4 = 1'b1;
		B: Y4 = 1'b0;
		C: Y4 = 1'b1;
		D: Y4 = 1'b1;
		E: Y4 = 1'b1;
		F: Y4 = 1'b0;
	endcase
end

endmodule
