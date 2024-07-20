module top_module(
    input a,
    input b,
    input c,
    output out
);

    // Define internal signal wire
    wire w1;

    // Implement logic for w1
    assign w1 = b & c;

    // Implement logic for out
    assign out = (~a & ~b & ~c) | (~a & b & c) | (a & b & c) | (a & ~b & c) | (a & b & ~c);

endmodule
