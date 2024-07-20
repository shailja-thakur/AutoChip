module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

// Wire Declarations
wire [24:0] temp_out;

// Bitwise Comparisons
assign temp_out[24] = ~a ^ a;
assign temp_out[23] = ~a ^ b;
assign temp_out[22] = ~a ^ c;
assign temp_out[21] = ~a ^ d;
assign temp_out[20] = ~a ^ e;
assign temp_out[19] = ~b ^ a;
assign temp_out[18] = ~b ^ b;
assign temp_out[17] = ~b ^ c;
assign temp_out[16] = ~b ^ d;
assign temp_out[15] = ~b ^ e;
assign temp_out[14] = ~c ^ a;
assign temp_out[13] = ~c ^ b;
assign temp_out[12] = ~c ^ c;
assign temp_out[11] = ~c ^ d;
assign temp_out[10] = ~c ^ e;
assign temp_out[9] = ~d ^ a;
assign temp_out[8] = ~d ^ b;
assign temp_out[7] = ~d ^ c;
assign temp_out[6] = ~d ^ d;
assign temp_out[5] = ~d ^ e;
assign temp_out[4] = ~e ^ a;
assign temp_out[3] = ~e ^ b;
assign temp_out[2] = ~e ^ c;
assign temp_out[1] = ~e ^ d;
assign temp_out[0] = ~e ^ e;

// Assign temp_out to out
assign out = temp_out;

endmodule
