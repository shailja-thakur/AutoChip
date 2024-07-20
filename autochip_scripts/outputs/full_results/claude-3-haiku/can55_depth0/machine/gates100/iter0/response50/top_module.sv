module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

always @(*) begin
    // AND operation
    out_and = 1'b1;
    for (int i = 0; i < 100; i++) begin
        out_and &= in[i];
    end

    // OR operation
    out_or = 1'b0;
    for (int i = 0; i < 100; i++) begin
        out_or |= in[i];
    end

    // XOR operation
    out_xor = 1'b0;
    for (int i = 0; i < 100; i++) begin
        out_xor ^= in[i];
    end
end

endmodule
