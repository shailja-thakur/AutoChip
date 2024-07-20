module top_module (
    input [31:0] in,
    output [31:0] out
);

// Declare a temporary wire for each 8-bit chunk
wire [7:0] tmp0, tmp1, tmp2, tmp3;

// Assign the first 8 bits of the input to tmp0
assign tmp0 = in[7:0];

// Assign the second 8 bits of the input to tmp1
assign tmp1 = in[15:8];

// Assign the third 8 bits of the input to tmp2
assign tmp2 = in[23:16];

// Assign the fourth 8 bits of the input to tmp3
assign tmp3 = in[31:24];

// Concatenate the temporary wires to form the output
assign out = {tmp3, tmp2, tmp1, tmp0};

endmodule
