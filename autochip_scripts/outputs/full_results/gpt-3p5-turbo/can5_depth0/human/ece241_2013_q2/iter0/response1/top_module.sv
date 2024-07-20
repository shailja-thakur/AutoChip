module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	
	// Define intermediate signals
	wire [3:0] inputs;
	
	// Assign intermediate signals
	assign inputs = {a, b, c, d};
	
	// Define output for SOP form
	assign out_sop = (inputs == 4'b0010) || (inputs == 4'b0111) || (inputs == 4'b1111) ? 1'b1 : 1'b0;
	
	// Define output for POS form
	assign out_pos = (inputs != 4'b0000) && (inputs != 4'b0001) && (inputs != 4'b0100) && (inputs != 4'b0101)
				&& (inputs != 4'b0110) && (inputs != 4'b1001) && (inputs != 4'b1010) && (inputs != 4'b1101)
				&& (inputs != 4'b1110) ? 1'b0 : 1'b1;
	
endmodule
