module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out_sop,
	output reg out_pos
);

	// Generate the SOP output
	always @* begin
		out_sop = (c & d) | ((~a & ~b) & c);
	end
	
	// Generate the POS outputs
	reg pos0, pos1;
	
	always @* begin
		pos0 = c & (~b | d) & (~a | b);
		pos1 = (~a | d) & c;
		
		if (pos0 == pos1)
			out_pos = pos0;
		else
			out_pos = 1'bx;
	end
	
endmodule
