module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    
    // Implement the logic function using an assign statement
    assign out = !(!c && !b) || (!d && !a) || (a && c && d) || (b && c && d);
    
endmodule
