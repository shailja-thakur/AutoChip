module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

	assign out_both = in[98:0] & in[99:1];  // Perform a bit-wise AND operation between the two input signals

	assign out_any = in;  // Perform a bit-wise OR operation between the two input signals

	assign out_different = {in[0] ^ in[99], in[99:1] ^ in[98:0]};  // Perform a bit-wise XOR operation between the two input signals, considering the special case for the first bit of out_different

endmodule
