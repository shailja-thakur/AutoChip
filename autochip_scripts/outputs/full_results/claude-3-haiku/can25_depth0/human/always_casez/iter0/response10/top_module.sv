module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b0000_0001: pos = 3'd0;
        8'b000_0010?: pos = 3'd1;
        8'b00_0100??: pos = 3'd2;
        8'b0_10000??: pos = 3'd3;
        8'b1_0000???: pos = 3'd4;
        default: pos = 3'd0;
    endcase
end

endmodule
