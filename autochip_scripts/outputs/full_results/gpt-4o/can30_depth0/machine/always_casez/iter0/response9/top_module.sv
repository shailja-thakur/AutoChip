module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'bzzzz_zzz1: pos = 3'h0;
        8'bzzzz_zz1z: pos = 3'h1;
        8'bzzzz_z1zz: pos = 3'h2;
        8'bzzzz_1zzz: pos = 3'h3;
        8'bzzz1_zzzz: pos = 3'h4;
        8'bzz1z_zzzz: pos = 3'h5;
        8'bz1zz_zzzz: pos = 3'h6;
        8'b1zzz_zzzz: pos = 3'h7;
        default: pos = 3'h0;
    endcase
end

endmodule
