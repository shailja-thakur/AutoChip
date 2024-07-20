module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the XOR result to out_assign using continuous assignment
    assign out_assign = a ^ b;

    // Assign the same result to out_always_comb using always_comb block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Assign the same result to out_always_ff using always_ff block, synchronized with clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
