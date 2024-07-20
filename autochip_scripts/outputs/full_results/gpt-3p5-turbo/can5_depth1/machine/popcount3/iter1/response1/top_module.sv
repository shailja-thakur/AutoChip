module top_module (
    input [2:0] in,
    output reg [1:0] out
);

    always @* begin
        out[1] = in[2] & in[1];    // Bitwise AND of input bits 2 and 1
        out[0] = in[0] ^ in[1];    // Bitwise XOR of input bits 0 and 1
    end

endmodule
