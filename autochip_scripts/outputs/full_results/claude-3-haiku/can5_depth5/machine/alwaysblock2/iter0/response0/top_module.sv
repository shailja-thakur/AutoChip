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

    // Assign the same value to out_always_comb, triggered by any change in a or b
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Assign the same value to out_always_ff, triggered by the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
