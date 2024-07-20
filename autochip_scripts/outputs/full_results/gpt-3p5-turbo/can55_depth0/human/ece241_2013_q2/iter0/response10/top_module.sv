module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

reg out_sop;
reg out_pos;

always @(*) begin
	if (a == 2'b00 && b == 2'b00 && c == 2'b00 && d == 2'b00)
		out_sop = 1'b0;
	else if (a == 2'b00 && b == 2'b00 && c == 2'b00 && d == 2'b01)
		out_sop = 1'b0;
	else if (a == 2'b00 && b == 2'b00 && c == 2'b01 && d == 2'b00)
		out_sop = 1'b0;
	else if (a == 2'b00 && b == 2'b00 && c == 2'b01 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b00 && b == 2'b01 && c == 2'b00 && d == 2'b00)
		out_sop = 1'b0;
	else if (a == 2'b00 && b == 2'b01 && c == 2'b00 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b00 && b == 2'b01 && c == 2'b01 && d == 2'b00)
		out_sop = 1'b1;
	else if (a == 2'b00 && b == 2'b01 && c == 2'b01 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b00 && b == 2'b10 && c == 2'b00 && d == 2'b00)
		out_sop = 1'b0;
	else if (a == 2'b00 && b == 2'b10 && c == 2'b00 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b00 && b == 2'b10 && c == 2'b01 && d == 2'b00)
		out_sop = 1'b1;
	else if (a == 2'b00 && b == 2'b10 && c == 2'b01 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b10 && b == 2'b00 && c == 2'b00 && d == 2'b00)
		out_sop = 1'b0;
	else if (a == 2'b10 && b == 2'b00 && c == 2'b00 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b10 && b == 2'b00 && c == 2'b01 && d == 2'b00)
		out_sop = 1'b1;
	else if (a == 2'b10 && b == 2'b00 && c == 2'b01 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b10 && b == 2'b01 && c == 2'b00 && d == 2'b00)
		out_sop = 1'b1;
	else if (a == 2'b10 && b == 2'b01 && c == 2'b00 && d == 2'b01)
		out_sop = 1'b1;
	else if (a == 2'b10 && b == 2'b01 && c == 2'b01 && d == 2'b00)
		out_sop = 1'b1;
	else if (a == 2'b10 && b == 2'b01 && c == 2'b01 && d == 2'b01)
		out_sop = 1'b1;
	else
		out_sop = 1'b0;
end

always @(*) begin
	if (a == 2'b00 || b == 2'b00 || c == 2'b00 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b00 || c == 2'b00 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b00 || c == 2'b01 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b00 || c == 2'b01 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b01 || c == 2'b00 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b01 || c == 2'b00 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b01 || c == 2'b01 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b01 || c == 2'b01 || d == 2'b01)
		out_pos = 1'b1;
	else if (a == 2'b00 || b == 2'b10 || c == 2'b00 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b10 || c == 2'b00 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b10 || c == 2'b01 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b00 || b == 2'b10 || c == 2'b01 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b00 || c == 2'b00 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b00 || c == 2'b00 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b00 || c == 2'b01 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b00 || c == 2'b01 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b01 || c == 2'b00 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b01 || c == 2'b00 || d == 2'b01)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b01 || c == 2'b01 || d == 2'b00)
		out_pos = 1'b0;
	else if (a == 2'b10 || b == 2'b01 || c == 2'b01 || d == 2'b01)
		out_pos = 1'b1;
	else
		out_pos = 1'b0;
end

endmodule
