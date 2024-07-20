module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);
    // Assign the result of a XOR b to out_assign
    assign out_assign = a ^ b;

    // Use combinational always block to assign the value to out_always_comb
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Use sequential always block to assign the value to out_always_ff
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end
endmodule
