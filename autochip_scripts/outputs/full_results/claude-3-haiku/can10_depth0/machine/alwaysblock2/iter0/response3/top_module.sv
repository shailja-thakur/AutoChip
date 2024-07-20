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

    // Assign the same value as out_assign to out_always_comb
    // using an always block, which is triggered whenever
    // the values of a and b change
    always @(a, b) begin
        out_always_comb = out_assign;
    end

    // Assign the same value as out_assign to out_always_ff
    // using an always block that is triggered on the rising
    // edge of the clk port, ensuring that out_always_ff is
    // updated synchronously with the clock
    always @(posedge clk) begin
        out_always_ff <= out_assign;
    end

endmodule
