module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
// This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

// Define internal wires
wire w1, w2, w3, w4;

// Combinational logic
assign w1 = b & c;
assign w2 = a & ~w1;
assign w3 = ~d;
assign w4 = w2 | w3;
assign q = ~(w4 & c);

endmodule
