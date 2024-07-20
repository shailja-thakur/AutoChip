module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Perform OR operation on inputs b and c
    assign q = b | c;

endmodule
