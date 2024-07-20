module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
	
	//  Implement OR gates for 4 inputs
	wire or_ab, or_cd;
	
	assign or_ab = a | b;
	assign or_cd = c | d;
	
	//  Implement AND gate for the outputs of OR gates
	assign q = or_ab & or_cd;

endmodule
