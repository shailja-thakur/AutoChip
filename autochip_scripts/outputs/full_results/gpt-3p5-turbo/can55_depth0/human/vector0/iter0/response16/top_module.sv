module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);
   assign {o2, o1, o0} = vec; // Assigning the bits of the input vector to individual output ports
   assign outv = vec; // Assigning the input vector to the output vector
endmodule
