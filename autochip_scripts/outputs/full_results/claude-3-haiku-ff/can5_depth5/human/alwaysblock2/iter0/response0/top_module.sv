module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // 1. XOR using assign statement
    assign out_assign = a ^ b;

    // 2. XOR using combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // 3. XOR using clocked always block (with flip-flop)
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
