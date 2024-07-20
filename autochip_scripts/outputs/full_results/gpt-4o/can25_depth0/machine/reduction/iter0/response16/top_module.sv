module top_module (
    input [7:0] in,
    output parity
);

    // Calculate the parity by XOR-ing all bits of the input
    assign parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

endmodule
