module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Directly assign the result of a XOR b to out_assign
    assign out_assign = a ^ b;

    // Use an always_comb block to assign the same result to out_always_comb
    always @(*) begin
        out_always_comb = out_assign;
    end

    // Use an always_ff block to assign the same result to out_always_ff
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
