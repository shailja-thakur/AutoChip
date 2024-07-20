module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out_sop,
	output reg out_pos
);

always @* begin
	if (a == 2'b10 || a == 2'b011 || a == 2'b1111)
		out_sop = 1;
	else if (a == 2'b00 || a == 2'b01 || a == 2'b0100 || a == 2'b0101 || a == 2'b0110 || a == 2'b1001 || a == 2'b1010 || a == 2'b1101 || a == 2'b1110)
		out_sop = 0;
	
	if (a == 2'b10 || a == 2'b011 || a == 2'b1111)
		out_pos = 1;
	else if (a == 2'b00 || a == 2'b01 || a == 2'b0100 || a == 2'b0101 || a == 2'b0110 || a == 2'b1001 || a == 2'b1010 || a == 2'b1101 || a == 2'b1110)
		out_pos = 0;
end

endmodule
