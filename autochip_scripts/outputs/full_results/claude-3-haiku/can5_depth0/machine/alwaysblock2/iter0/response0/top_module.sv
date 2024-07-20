module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Logical XOR operation on a and b
    assign out_assign = a ^ b;

    // Assign the same value as out_assign using an always block
    always @(a, b) begin
        out_always_comb = out_assign;
    end

    // Assign the same value as out_assign using an always_ff block
    always_ff @(posedge clk) begin
        out_always_ff <= out_assign;
    end

endmodule
