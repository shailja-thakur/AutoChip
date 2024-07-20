module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // XOR operation on a and b, assign to out_assign
    assign out_assign = a ^ b;

    // Assign the same value as out_assign using an always block triggered by changes in a and b
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Assign the same value as out_assign using an always block triggered by the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
