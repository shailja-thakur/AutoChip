module top_module(
    input a, 
    input b,
    input c,
    output out
);
    
    assign out = (a & b) | (a & c) | (b & c);  // Implementing the logic based on the Karnaugh map
    
endmodule
