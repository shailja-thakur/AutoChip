module top_module(
    input a, 
    input b,
    input c,
    output out
);
    
    assign out = (~a & ~b & ~c) 
                | (~a & b & c) 
                | (~b & c) 
                | (a & b & ~c);  // Implementing the correct logic based on the Karnaugh map
    
endmodule
