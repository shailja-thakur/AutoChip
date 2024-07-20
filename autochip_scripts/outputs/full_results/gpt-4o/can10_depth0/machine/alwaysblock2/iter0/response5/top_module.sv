module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of XOR operation to out_assign
    assign out_assign = a ^ b;

    // Assign the same value to out_always_comb using always_comb block
    always @* begin
        out_always_comb = out_assign;
    end

    // Assign the same value to out_always_ff using always_ff block
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
