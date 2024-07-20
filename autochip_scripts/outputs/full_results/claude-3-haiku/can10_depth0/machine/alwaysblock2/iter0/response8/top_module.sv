module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Combinational assignment
    assign out_assign = a ^ b;

    // Combinational always block
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Sequential always block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
