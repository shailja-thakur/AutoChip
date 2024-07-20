module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

wire [99:0] shifted_in;

// Shift the input signal by one bit
assign shifted_in = in >> 1;

// Generate the out_both signal by performing bit-wise AND operation
assign out_both = in[99:1] & shifted_in[98:0];

// Generate the out_any signal by performing bit-wise OR operation
assign out_any = in | shifted_in;

// Generate the out_different signal by performing bit-wise XOR operation
assign out_different = in ^ { shifted_in[98:0], in[99] };

endmodule
