module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Declare intermediate signals
    wire [2:0] ones;

    // Count the number of '1's in the input vector
    assign ones[0] = in[0];
    assign ones[1] = in[1] ^ ones[0];
    assign ones[2] = in[2] ^ ones[1];

    // Assign the output based on the number of '1's
    assign out = ones[2:1];

endmodule
