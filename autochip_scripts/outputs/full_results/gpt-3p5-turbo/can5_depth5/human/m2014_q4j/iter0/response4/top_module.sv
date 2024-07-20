module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] s;

// Full Adder
// A full adder has three inputs: A, B, and C_in
// The sum output is (A XOR B) XOR C_in
// The carry output is A*B + (A XOR B) * C_in

// First Full Adder
full_adder fa1 (.A(x[0]), .B(y[0]), .C_in(1'b0), .S(s[0]), .C_out(carry[0]));

// Second Full Adder
full_adder fa2 (.A(x[1]), .B(y[1]), .C_in(carry[0]), .S(s[1]), .C_out(carry[1]));

// Third Full Adder
full_adder fa3 (.A(x[2]), .B(y[2]), .C_in(carry[1]), .S(s[2]), .C_out(carry[2]));

// Fourth Full Adder
full_adder fa4 (.A(x[3]), .B(y[3]), .C_in(carry[2]), .S(s[3]), .C_out(carry[3]));

// Define sum and overflow
assign sum = {carry[3], s}; // Concatenating carry[3] and s to get 5-bit sum

endmodule
