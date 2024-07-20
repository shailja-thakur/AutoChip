module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Internal wires
	wire sum_wire;
	wire cout_wire;
	
	// Instantiate the half adder module
	half_adder HA_inst (
		.a(a),
		.b(b),
		.sum(sum_wire),
		.cout(cout_wire)
	);
	
	// Assign the internal wires to the output ports
	assign sum = sum_wire;
	assign cout = cout_wire;
	
	// Define the half adder module
	module half_adder (
		input a,
		input b,
		output sum,
		output cout
	);
		// XOR gate for sum
		assign sum = a ^ b;
		
		// AND gate for carry-out
		assign cout = a & b;
	endmodule
