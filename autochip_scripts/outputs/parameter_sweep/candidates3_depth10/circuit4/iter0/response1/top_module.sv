module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Define intermediate signals
    wire w1, w2, w3, w4, w5, w6;
    
    // Implement the circuit
    assign w1 = (~d & c);
    assign w2 = (b & ~c);
    assign w3 = (~a & ~b);
    assign w4 = (d & a);
    assign w5 = (w3 | w4);
    assign w6 = (w5 & w2);
    assign q = (w6 | w1);
    
endmodule
