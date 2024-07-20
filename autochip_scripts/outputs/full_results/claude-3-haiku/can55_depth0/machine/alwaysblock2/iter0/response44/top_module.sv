module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the XOR of a and b to out_assign
    assign out_assign = a ^ b;

    // Use an always_comb block to assign out_always_comb
    always_comb begin
        out_always_comb = a ^ b;
    end

    // Use an always_ff block to assign out_always_ff
    always_ff @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
