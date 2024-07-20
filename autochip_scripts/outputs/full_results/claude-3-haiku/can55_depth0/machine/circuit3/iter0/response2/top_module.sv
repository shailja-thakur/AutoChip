module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Implement the logic gate
    wire ab = a | b;
    wire cd = c | d;
    assign q = ab & cd;

endmodule
