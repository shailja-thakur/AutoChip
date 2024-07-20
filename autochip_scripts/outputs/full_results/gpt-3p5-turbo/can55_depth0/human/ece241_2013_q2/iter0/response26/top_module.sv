module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// create a 2-input AND gate for every input combination that results in logic-1
wire and1 = (a & b);
wire and2 = (b & c);
wire and3 = (a & c & d);

// create a 3-input OR gate to combine the outputs of the AND gates
wire or1 = (and1 | and2 | and3);

// output out_sop in minimum sum-of-products form
assign out_sop = ~or1;

// create a 2-input OR gate for every input combination that results in logic-0
wire or4 = (a | b);
wire or5 = (b | c);
wire or6 = (a | c | d);

// create a 3-input AND gate to combine the outputs of the OR gates
wire and4 = (or4 & or5 & or6);

// output out_pos in minimum product-of-sums form
assign out_pos = ~and4;

endmodule
