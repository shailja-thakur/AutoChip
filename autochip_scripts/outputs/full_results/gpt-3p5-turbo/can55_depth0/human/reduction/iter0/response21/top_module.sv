module top_module (
    input [7:0] in,
    output parity
);

// Declare internal signals
wire [7:0] xor_result;
reg parity;

// Compute xor of all input bits
assign xor_result = ^in;

// Compute parity bit
assign parity = xor_result;

endmodule
