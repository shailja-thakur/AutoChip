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
	always @* begin
		reg pos0, pos1;
		if (c && (!b || d) && (!a || b))
			pos0 = 1'b1;
		else
			pos0 = 1'b0;
			
		if ((!a || d) && c)
			pos1 = 1'b1;
		else
			pos1 = 1'b0;
		
		if (pos0 === pos1)
			out_pos = pos0;
		else
			out_pos = 1'bx;
	end
	
endmodule
