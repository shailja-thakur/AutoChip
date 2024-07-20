module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

// Bitwise AND operation
assign out_both = in[99:1] & in[98:0];

// Bitwise OR operation
assign out_any = in;

// Bitwise XOR operation
assign out_different = {in[0] ^ in[99], in[99:1] ^ in[98:0]};

endmodule
