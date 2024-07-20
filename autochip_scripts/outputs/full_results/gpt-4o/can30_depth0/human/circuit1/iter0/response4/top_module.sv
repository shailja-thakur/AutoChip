module top_module (
    input a,
    input b,
    output q
);

// The output q is only high (1) when both a and b are high (1)
assign q = a & b;

endmodule
