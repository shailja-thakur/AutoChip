module top_module (
    input [7:0] in,
    output parity
);

    reg[7:0] xor_result;
    reg final_xor_result;

    always @(in) begin
        xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
        final_xor_result = xor_result;
    end

    assign parity = final_xor_result;

endmodule
