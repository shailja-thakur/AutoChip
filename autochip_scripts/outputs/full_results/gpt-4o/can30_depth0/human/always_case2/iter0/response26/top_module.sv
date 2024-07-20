module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez (in)
        4'b1???: pos = 2'd3;  // First '1' at bit 3
        4'b01??: pos = 2'd2;  // First '1' at bit 2
        4'b001?: pos = 2'd1;  // First '1' at bit 1
        4'b0001: pos = 2'd0;  // First '1' at bit 0
        default: pos = 2'd0;  // No '1' bits, output zero
    endcase
end

endmodule
