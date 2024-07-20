module top_module(
    input clk,
    input a,
    input b,
    output reg out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the XOR of a and b to out_assign
    always @(*) begin
        out_assign = a ^ b;
    end

    // Assign the same value as out_assign to out_always_comb using an always block
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Assign the same value as out_assign to out_always_ff using a synchronous always block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
