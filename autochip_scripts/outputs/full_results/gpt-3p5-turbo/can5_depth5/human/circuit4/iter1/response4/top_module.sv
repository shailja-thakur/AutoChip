module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

    // Intermediate signals
    wire w1, w2, w3;
    
    // Logic gates
    xor_gate gate1 (w1, a, b);
    and_gate gate2 (w2, c, d);
    and_gate gate3 (w3, a, b);
    or_gate gate4 (q, w1, w2, w3);
  
endmodule
module xor_gate(
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule
module and_gate(
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or_gate(
    input a,
    input b,
    input c,
    output y
);
    assign y = a | b | c;
endmodule
