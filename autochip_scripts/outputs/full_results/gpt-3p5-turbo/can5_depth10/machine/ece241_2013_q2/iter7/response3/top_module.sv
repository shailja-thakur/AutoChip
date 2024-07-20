module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out_sop,
	output reg out_pos
);

	// Generate the SOP output
	assign out_sop = (c & d) | ((~a & ~b) & c);
	
	// Generate the POS outputs
	wire pos0, pos1;
	
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = (~a | d) & c;
		
	always @(posedge pos0, pos1) begin
		if (pos0 === pos1)
			out_pos <= pos0;
		else
			out_pos <= 1'bx;
	end
	
endmodule
