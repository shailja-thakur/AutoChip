module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);
// Assign statement method
assign out_assign = a ^ b;

// Combinational always block method
always @*
    out_always_comb = a ^ b;

// Clocked always block method
always @(posedge clk)
    out_always_ff <= a ^ b;

endmodule
