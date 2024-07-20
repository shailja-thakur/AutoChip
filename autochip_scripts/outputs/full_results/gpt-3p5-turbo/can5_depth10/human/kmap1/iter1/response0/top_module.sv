module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Adding a wire to reduce complexity
    wire ab;
    
    assign ab = a & b;
    assign out = ab & c;
    
endmodule
