module top_module (
    input a, 
    input b, 
    input c, 
    input d, 
    output q
);

    // The output q is '1' when:
    // b is '1', irrespective of the values of a, c, and d
    // c is '1' and not all inputs are '0'
    assign q = b | c & (a | b | d);

endmodule
