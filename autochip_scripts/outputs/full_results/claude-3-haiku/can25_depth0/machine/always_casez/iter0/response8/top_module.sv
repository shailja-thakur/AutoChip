module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b0000_0001: pos = 3'h0;
        8'b0000_001z: pos = 3'h1;
        8'b0000_01zz: pos = 3'h2;
        8'b0000_1zzz: pos = 3'h3;
        8'b0001_zzzz: pos = 3'h4;
        8'b001z_zzzz: pos = 3'h5;
        8'bz01z_zzzz: pos = 3'h6;
        8'bzz1z_zzzz: pos = 3'h7;
        default: pos = 3'h0;
    endcase
end

endmodule
