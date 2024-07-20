module top_module(
    input a, 
    input b,
    input c,
    output out
);
    // Intermediate wires
    wire w1, w2, w3;
    
    // Implement the required logic using gates
    assign w1 = ~(~b & a);
    assign w2 = c | w1;
    assign w3 = b | w2;
    assign out = ~(~c & w3);
    
endmodule
