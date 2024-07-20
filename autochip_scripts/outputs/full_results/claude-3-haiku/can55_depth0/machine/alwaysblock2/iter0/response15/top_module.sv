module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the XOR of a and b to out_assign port
    assign out_assign = a ^ b;

    // Always block triggered by changes in a and b
    always @(a, b) begin
        // Assign the same value as out_assign to out_always_comb
        out_always_comb = out_assign;
    end

    // Always block triggered by the rising edge of the clock
    always @(posedge clk) begin
        // Assign the same value as out_assign to out_always_ff
        out_always_ff = out_assign;
    end

endmodule
