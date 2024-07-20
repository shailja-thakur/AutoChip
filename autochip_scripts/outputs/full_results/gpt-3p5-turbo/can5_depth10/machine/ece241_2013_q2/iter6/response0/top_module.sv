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
	reg [1:0] pos;
	
	always @* begin
		pos[0] = c & (~b | d) & (~a | b);
		pos[1] = (~a & d) | (c & (~a | b));
		
		if (pos[0] === pos[1])
			out_pos = pos[0];
		else
			out_pos = 1'bx;
	end
	
endmodule
