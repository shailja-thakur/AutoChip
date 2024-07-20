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
		
		if (pos0 === pos1)
			out_pos = pos0;
		else
			out_pos = 1'bx;
	end
	
	initial begin
		// Testbench stimulus
		#10 a = 0; b = 0; c = 0; d = 0;
		#10 a = 1; b = 0; c = 0; d = 0;
		#10 a = 0; b = 1; c = 0; d = 0;
		#10 a = 1; b = 1; c = 0; d = 0;
		#10 a = 0; b = 0; c = 1; d = 0;
		#10 a = 1; b = 0; c = 1; d = 0;
		#10 a = 0; b = 1; c = 1; d = 0;
		#10 a = 1; b = 1; c = 1; d = 0;
		#10 a = 0; b = 0; c = 0; d = 1;
		#10 a = 1; b = 0; c = 0; d = 1;
		#10 a = 0; b = 1; c = 0; d = 1;
		#10 a = 1; b = 1; c = 0; d = 1;
		#10 a = 0; b = 0; c = 1; d = 1;
		#10 a = 1; b = 0; c = 1; d = 1;
		#10 a = 0; b = 1; c = 1; d = 1;
		#10 a = 1; b = 1; c = 1; d = 1;
		#10 $finish;
	end
	
endmodule
