module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // assign q = a & b & (c | d);  // original code

    assign q = a && b && (c || d); // corrected code
    
endmodule
