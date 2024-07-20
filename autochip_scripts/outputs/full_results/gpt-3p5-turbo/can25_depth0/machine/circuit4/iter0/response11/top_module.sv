module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Define internal wires for the OR operation
wire q_wire;

// Perform OR operation using inputs b and c
assign q_wire = b | c;

// Output q is the result of the OR operation
assign q = q_wire;

endmodule
