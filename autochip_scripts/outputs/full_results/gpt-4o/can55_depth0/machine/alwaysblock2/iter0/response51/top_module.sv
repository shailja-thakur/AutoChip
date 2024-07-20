module top_module(
    input wire clk,
    input wire a, 
    input wire b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the XOR of a and b to out_assign
    assign out_assign = a ^ b;

    // Combinational always block to assign out_always_comb
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential always block to assign out_always_ff
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
