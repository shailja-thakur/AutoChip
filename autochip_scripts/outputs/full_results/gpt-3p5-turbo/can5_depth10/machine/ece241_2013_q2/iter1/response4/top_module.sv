module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// Intermediate wires
	wire sop0, sop1, pos0, pos1;
	
	// Generate the SOP output
	assign sop0 = c & d;
	assign sop1 = (~a & ~b & c);
	assign out_sop = sop0 | sop1;
	
	// Generate the POS outputs
	assign pos0 = c & (~b | d) & (~a | b);
	assign pos1 = c & (~a | d);
	
	// Check for equality of pos0 and pos1
	wire equal;
	assign equal = (pos0 === pos1);
	
	// Assign out_pos based on the result of the equality check
	assign out_pos = equal ? pos0 : 1'bx;
endmodule
