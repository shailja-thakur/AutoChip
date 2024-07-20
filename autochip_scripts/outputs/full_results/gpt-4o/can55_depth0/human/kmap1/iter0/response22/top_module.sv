module top_module(
    input a, 
    input b, 
    input c, 
    output out
);

    assign out = a | (~a & b);  // Simplified boolean expression from the Karnaugh map

endmodule
