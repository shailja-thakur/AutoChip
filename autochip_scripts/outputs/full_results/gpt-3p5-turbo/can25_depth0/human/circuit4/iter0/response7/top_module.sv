module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
	
    wire w1, w2, w3, w4, w5, w6, w7, w8;
    
    // AND gates
    and gate1(w1, a, d);
    and gate2(w2, b, c);
    and gate3(w3, b, d);
    and gate4(w4, c, d);
    and gate5(w5, a, b, c);
    and gate6(w6, a, b, d);
    and gate7(w7, a, c, d);
    
    // OR gates
    or gate8(w8, w1, w2, w3, w4, w5, w6, w7);
    
    // assign the output
    assign q = w8;

endmodule
