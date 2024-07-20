module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create internal wires
wire internal1, internal2, internal3;

// implement full adder logic
// First half adder
and gate1(internal1, a, b);
xor gate2(sum, a, b);

// Second half adder
and gate3(internal2, internal1, cin);
xor gate4(sum, sum, cin);

// OR gate for the carry-out
or gate5(cout, internal2, internal3);

endmodule
