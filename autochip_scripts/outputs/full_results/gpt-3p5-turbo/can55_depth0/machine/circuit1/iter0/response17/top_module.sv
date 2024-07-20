module top_module (
	input a, 
	input b, 
	output q
);
	// defining internal wires
	wire q_wire;
	// instantiating AND gate
	and gate1 (
		.a(a),
		.b(b),
		.q(q_wire)
	);
	// assigning output wire to output port
	assign q = q_wire;
endmodule
