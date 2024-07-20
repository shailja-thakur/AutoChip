module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b000000001: pos = 3'd0;
        8'b00000001?: pos = 3'd1;
        8'b0000011??: pos = 3'd2;
        8'b000111???: pos = 3'd3;
        8'b001111????: pos = 3'd4;
        8'b011111????: pos = 3'd5;
        8'b111111????: pos = 3'd6;
        8'b?????????: pos = 3'd7;
        default: pos = 3'd0;
    endcase
end

endmodule
