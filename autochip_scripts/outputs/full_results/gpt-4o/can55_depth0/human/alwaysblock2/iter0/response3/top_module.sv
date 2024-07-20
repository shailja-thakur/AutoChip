module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // First implementation using assign statement
    assign out_assign = a ^ b;

    // Second implementation using combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Third implementation using clocked always block
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
