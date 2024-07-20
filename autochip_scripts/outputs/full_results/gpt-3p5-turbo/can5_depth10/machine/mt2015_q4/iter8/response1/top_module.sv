module top_module(
    input x,
    input y,
    output reg z
);

    always @(x or y) begin
        z <= (x & ~y) ^ (~x & y);  // XOR gate to calculate z
    end

endmodule
