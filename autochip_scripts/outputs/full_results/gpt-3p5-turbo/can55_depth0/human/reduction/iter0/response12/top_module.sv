module top_module (
    input [7:0] in,
    output parity
);

reg [7:0] in_reg;
reg parity_reg;

assign in_reg = in;

always @(in_reg) begin
    parity_reg = in_reg[0] ^ in_reg[1] ^ in_reg[2] ^ in_reg[3] ^ in_reg[4] ^ in_reg[5] ^ in_reg[6] ^ in_reg[7];
end

assign parity = parity_reg;

endmodule
