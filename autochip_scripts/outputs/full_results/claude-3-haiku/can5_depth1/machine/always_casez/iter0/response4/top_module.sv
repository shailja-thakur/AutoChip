module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    casez (in)
        8'b1zzzzzzz: pos = 3'h7;
        8'bz1zzzzz: pos = 3'h6;
        8'bzz1zzzz: pos = 3'h5;
        8'bzzz1zzz: pos = 3'h4;
        8'bzzzz1zz: pos = 3'h3;
        8'bzzzz1z: pos = 3'h2;
        8'bzzzz1: pos = 3'h1;
        8'b1: pos = 3'h0;
        default: pos = 3'h0;
    endcase
end

endmodule
