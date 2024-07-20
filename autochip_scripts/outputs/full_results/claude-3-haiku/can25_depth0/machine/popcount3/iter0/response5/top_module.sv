module top_module (
    input [2:0] in,
    output [1:0] out
);

    assign out[0] = in[0] ^ in[1] ^ in[2]; // Least significant bit of the sum
    assign out[1] = (in[0] & in[1]) | (in[1] & in[2]) | (in[0] & in[2]); // Most significant bit of the sum

endmodule
