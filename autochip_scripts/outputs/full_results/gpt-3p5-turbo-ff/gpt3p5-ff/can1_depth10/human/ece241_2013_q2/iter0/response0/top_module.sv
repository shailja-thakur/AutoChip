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

always @(a or b or c or d) begin
	if ((a & b & ~c & d) || (~a & b & c & d) || (a & ~b & c & d) || (~a & ~b & c & d) || (~a & ~b & ~c & ~d))
		out_sop = 1;
	else
		out_sop = 0;
	
	if (~(a | b | c | d) && ~(a | ~b | ~c | d) && (~a | b | ~c | ~d) && (~a | b | ~c | d) && (~a | ~b | c | d) && (a | ~b | c | d) && (a | b | ~c | d) && (~a | ~b | ~c | d) && (~a | ~b | c | ~d))
		out_pos = 0;
	else
		out_pos = 1;
end

endmodule
