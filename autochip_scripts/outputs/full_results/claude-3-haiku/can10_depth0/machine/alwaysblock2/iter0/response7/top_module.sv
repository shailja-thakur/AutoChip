module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of the logical XOR operation on a and b to out_assign
    assign out_assign = a ^ b;

    // Always block triggered by changes in a and b, assign the same value as out_assign to out_always_comb
    always @(a, b) begin
        out_always_comb = out_assign;
    end

    // Always block triggered on the rising edge of clk, assign the same value as out_assign to out_always_ff
    always @(posedge clk) begin
        out_always_ff <= out_assign;
    end

endmodule
