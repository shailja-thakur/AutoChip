module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Combinational logic to assign the output
    assign out_assign = a ^ b;

    // Combinational always block to assign out_always_comb
    always @(a, b) begin
        out_always_comb = a ^ b;
    end

    // Sequential always block to assign out_always_ff
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule
