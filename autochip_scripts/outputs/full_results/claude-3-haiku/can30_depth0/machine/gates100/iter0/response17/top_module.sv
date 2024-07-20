module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

always @(*) begin
    // Perform AND operation on all bits of the input vector
    out_and = &in;

    // Perform OR operation on all bits of the input vector
    out_or = |in;

    // Perform XOR operation on all bits of the input vector
    out_xor = ^in;
end

endmodule
