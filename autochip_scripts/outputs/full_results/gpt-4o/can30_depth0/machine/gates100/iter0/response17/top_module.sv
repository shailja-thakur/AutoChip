module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

always @(*) begin
    out_and = &in; // AND operation on all bits
    out_or = |in;  // OR operation on all bits
    out_xor = ^in; // XOR operation on all bits
end

endmodule
