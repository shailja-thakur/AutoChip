module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out_sop,
	output reg out_pos
);

always @* begin
	if ((a == 2'b10) || (a == 2'b011) || (a == 4'b1111))
		out_sop = 1;
	else
		out_sop = 0;
	
	if ((a == 2'b10) || (a == 2'b011) || (a == 4'b1111))
		out_pos = 1;
	else
		out_pos = 0;
end

endmodule
