module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire or_a_b, or_c_d;

    assign or_a_b = a | b;
    assign or_c_d = c | d;
    assign q = or_a_b & or_c_d;

endmodule
