module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of the XOR operation on a and b to out_assign
    assign out_assign = a ^ b;

    // Assign the result of the XOR operation on a and b to out_always_comb
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Assign the result of the XOR operation on a and b to out_always_ff
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
