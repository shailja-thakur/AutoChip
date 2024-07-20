module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

    always @(*) begin
        casex (in)
            4'b1xxx: pos = 2'd3; // Bit 3 is the first high bit
            4'b01xx: pos = 2'd2; // Bit 2 is the first high bit
            4'b001x: pos = 2'd1; // Bit 1 is the first high bit
            4'b0001: pos = 2'd0; // Bit 0 is the first high bit
            default: pos = 2'd0; // No bits are high, output zero
        endcase
    end

endmodule
