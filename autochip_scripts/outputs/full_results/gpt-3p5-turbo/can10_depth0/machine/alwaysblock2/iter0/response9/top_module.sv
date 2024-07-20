module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the logical XOR of a and b to out_assign
    assign out_assign = a ^ b;

    // Assign out_assign to out_always_comb using an always block triggered by the change in values of a and b
    always @(a or b)
    begin
        out_always_comb = out_assign;
    end

    // Assign out_assign to out_always_ff using an always block triggered on the rising edge of clk
    always @(posedge clk)
    begin
        out_always_ff <= out_assign;
    end

endmodule
