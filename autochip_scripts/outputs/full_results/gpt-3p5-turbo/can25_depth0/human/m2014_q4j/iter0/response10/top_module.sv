module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry; // Carry bit from each full adder

// Instantiating four full adders
full_adder fa0(.a(x[0]), .b(y[0]), .cin(0), .sum(sum[0]), .cout(carry[0]));
full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

assign sum[4] = carry[3]; // Overflow bit
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	
	wire s1, s2;

	xor x1(.a(a), .b(b), .y(s1)); // XOR gate for sum bit
	xor x2(.a(s1), .b(cin), .y(sum)); // XOR gate for sum bit with carry-in

	and a1(.a(a), .b(b), .y(s2)); // AND gate for carry-out bit
	and a2(.a(s1), .b(cin), .y(cout)); // AND gate for carry-out bit
	
	or o1(.a(s2), .b(cin), .y(cout)); // OR gate for carry-out bit
endmodule
