module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez (in)
        4'b1???: pos = 2'd3; // When bit[3] is high
        4'b01??: pos = 2'd2; // When bit[2] is high
        4'b001?: pos = 2'd1; // When bit[1] is high
        4'b0001: pos = 2'd0; // When bit[0] is high
        default: pos = 2'd0; // When no bits are high or all bits are zero
    endcase
end

endmodule
