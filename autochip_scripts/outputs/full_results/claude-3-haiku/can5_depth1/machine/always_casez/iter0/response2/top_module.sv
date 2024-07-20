module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    casez (in)
        8'b11111111: pos = 3'h7;
        8'b1111111z: pos = 3'h6;
        8'b111111zz: pos = 3'h5;
        8'b11111zzz: pos = 3'h4;
        8'b1111zzzz: pos = 3'h3;
        8'b111zzzzz: pos = 3'h2;
        8'b11zzzzzz: pos = 3'h1;
        8'b1zzzzzzz: pos = 3'h0;
        default: pos = 3'h0;
    endcase
end

endmodule
