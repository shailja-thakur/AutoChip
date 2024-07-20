module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b1zzzzzzz: pos = 3'h0;
        8'b01zzzzzz: pos = 3'h1;
        8'b001zzzzz: pos = 3'h2;
        8'b0001zzzz: pos = 3'h3;
        8'b00001zzz: pos = 3'h4;
        8'b000001zz: pos = 3'h5;
        8'b0000001z: pos = 3'h6;
        8'b00000001: pos = 3'h7;
        default: pos = 3'h0;
    endcase
end

endmodule
