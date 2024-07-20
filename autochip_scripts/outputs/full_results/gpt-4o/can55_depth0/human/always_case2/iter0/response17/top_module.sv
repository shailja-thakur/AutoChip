module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez (in)
        4'b1???: pos = 2'd3; // if bit 3 is 1
        4'b01??: pos = 2'd2; // if bit 2 is 1
        4'b001?: pos = 2'd1; // if bit 1 is 1
        4'b0001: pos = 2'd0; // if bit 0 is 1
        default: pos = 2'd0; // if none of the bits are 1
    endcase
end

endmodule
