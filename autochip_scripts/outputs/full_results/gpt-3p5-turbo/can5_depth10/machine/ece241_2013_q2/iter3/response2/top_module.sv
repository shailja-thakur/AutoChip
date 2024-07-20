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
		out_sop = (c & d) | ((~a & ~b & c));
	end
	
  // Remove 'reg' keyword for pos0 and pos1
	wire pos0, pos1;
	
  // Use continuous assignment for pos0 and pos1
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = (~a | d) & c;
	
	// Use always @* for the assignment of out_pos
	always @* begin
		if (pos0 === pos1)
			out_pos = pos0;
		else
			out_pos = 1'bx;
	end
	
endmodule
