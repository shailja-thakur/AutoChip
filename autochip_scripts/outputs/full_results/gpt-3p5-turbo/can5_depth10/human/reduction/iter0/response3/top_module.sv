module top_module (
    input [7:0] in,
    output parity
);

wire [7:0] xor_result;
wire even_parity;

// XOR all input bits
xor #(
    .N(8)
) u_xor (
    .in(in),
    .out(xor_result)
);

// Compute even parity bit
assign even_parity = ^xor_result;

// Extend the input byte with the even parity bit
assign parity = {in, even_parity};

endmodule
