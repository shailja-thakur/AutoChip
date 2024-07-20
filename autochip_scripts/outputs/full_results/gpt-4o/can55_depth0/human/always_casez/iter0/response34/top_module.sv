module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @(*) begin
    casex (in)
        8'b00000001: pos = 3'd0;
        8'b0000001X: pos = 3'd1;
        8'b000001XX: pos = 3'd2;
        8'b00001XXX: pos = 3'd3;
        8'b0001XXXX: pos = 3'd4;
        8'b001XXXXX: pos = 3'd5;
        8'b01XXXXXX: pos = 3'd6;
        8'b1XXXXXXX: pos = 3'd7;
        default: pos = 3'd0; // If no bits are high, output is 0
    endcase
end

endmodule
