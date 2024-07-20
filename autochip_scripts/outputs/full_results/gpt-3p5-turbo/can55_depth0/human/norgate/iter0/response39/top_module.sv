module top_module(
    input a, 
    input b,
    output out
);
    
    // Implement a NOR gate using the 'out' output
    assign out = ~(a | b);
    
endmodule
