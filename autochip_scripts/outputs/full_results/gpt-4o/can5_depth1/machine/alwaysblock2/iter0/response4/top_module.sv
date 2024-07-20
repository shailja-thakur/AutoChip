module top_module(
    input wire clk,
    input wire a, 
    input wire b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign XOR result directly to out_assign
    assign out_assign = a ^ b;

    // Combinational always block for out_always_comb
    always @(*) begin
        out_always_comb = out_assign;
    end

    // Sequential always block for out_always_ff
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end

endmodule
