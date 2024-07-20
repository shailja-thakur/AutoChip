module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

// Logical XOR operation
assign out_assign = a ^ b;

// Assignment using always block triggered on value change
always @(a, b)
    out_always_comb <= out_assign;

// Assignment using always block triggered on rising edge of clk
always @(posedge clk)
    out_always_ff <= out_assign;

endmodule
