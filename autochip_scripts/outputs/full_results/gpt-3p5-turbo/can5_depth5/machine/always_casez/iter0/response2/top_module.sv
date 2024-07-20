module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    casez(in)
        8'b00000001: pos <= 3'b0;
        8'b0000001x: pos <= 3'b1;
        8'b000001xx: pos <= 3'b2;
        8'b00001xxx: pos <= 3'b3;
        8'b0001xxxx: pos <= 3'b4;
        8'b001xxxxx: pos <= 3'b5;
        8'b01xxxxxx: pos <= 3'b6;
        8'b1xxxxxxx: pos <= 3'b7;
        default: pos <= 3'b0;
    endcase
end

endmodule
