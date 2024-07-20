module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal wires
	wire carry_in;
	wire [3:0] sum_bits;
	wire carry_out;

	// Instantiate full adders
	full_adder fa0(.a(x[0]), .b(y[0]), .cin(carry_in), .sum(sum_bits[0]), .cout(carry_out));
	full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry_out), .sum(sum_bits[1]), .cout(carry_out));
	full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry_out), .sum(sum_bits[2]), .cout(carry_out));
	full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry_out), .sum(sum_bits[3]), .cout(carry_out));

	// Assign sum and overflow
	assign sum = {carry_out, sum_bits};

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
    // Internal wires
    wire temp_carry;

    // XOR gates
    assign sum = a ^ b;

    // AND gates
    assign temp_carry = a & b;

    // OR gates
    assign cout = (cin & temp_carry) | (a & cin) | (b & cin);

endmodule
