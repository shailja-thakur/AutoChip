module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] in_shifted;

    // Shift input by one bit to the left
    assign in_shifted = in << 1;

    // Output both AND operation
    assign out_both = in[99:1] & in_shifted[98:0];

    // Output any OR operation
    assign out_any = in | in_shifted[99:0];

    // Output different XOR operation
    assign out_different = in ^ {in[98:0], in[99]};

endmodule
