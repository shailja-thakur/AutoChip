module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create internal signals
wire w1;
wire w2;

// Create internal gates
and gate1(w1,a,b);
xor gate2(sum,w1,cin);
and gate3(w2,a,cin);
and gate4(w3,b,cin);
or gate5(cout,w2,w3);
 
endmodule
