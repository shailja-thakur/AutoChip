module top_module (
   input in1,
   input in2,
   output logic out
);
	
   and gate1 (and1_out, in1, in2); // Connects the inputs to the AND gate
   
   assign out = and1_out; // Connects the output of the AND gate to 'out'
endmodule
module and(
	input a,
	input b,
	output logic y
);
	assign y = a & b;
endmodule
