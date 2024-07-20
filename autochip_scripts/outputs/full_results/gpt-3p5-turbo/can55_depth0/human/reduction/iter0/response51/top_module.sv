module top_module (
    input [7:0] in,
    output parity
);

// Declare signal for holding the result
reg parity_bit;

// Compute the XOR of all input bits to get the parity bit
assign parity = parity_bit;

// Generate the parity bit using XOR of all input bits
always @(*) begin
    parity_bit = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
end

endmodule
