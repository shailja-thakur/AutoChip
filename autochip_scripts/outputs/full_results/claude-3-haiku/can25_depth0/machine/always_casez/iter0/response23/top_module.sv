module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    case (in)
        8'b1xxxxxxx: pos = 3'h7;
        8'b01xxxxxx: pos = 3'h6;
        8'b001xxxxx: pos = 3'h5;
        8'b0001xxxx: pos = 3'h4;
        8'b00001xxx: pos = 3'h3;
        8'b000001xx: pos = 3'h2;
        8'b0000001x: pos = 3'h1;
        8'b00000001: pos = 3'h0;
        default: pos = 3'b0;
    endcase
end

endmodule
