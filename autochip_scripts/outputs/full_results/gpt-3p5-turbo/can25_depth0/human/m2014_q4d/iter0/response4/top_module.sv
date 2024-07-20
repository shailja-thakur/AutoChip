module top_module (
    input clk,
    input in,
    output reg out
);

reg xor_output;
reg flop_input;

always @(posedge clk)
    flop_input <= xor_output;

assign out = flop_input;

// XOR gate implementation
always @*
    xor_output = in ^ out;

endmodule
