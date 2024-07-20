module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(*) begin
    casez (in)
        8'b1xxxxxxx: pos = 3'b000;
        8'b01xxxxxx: pos = 3'b001;
        8'b001xxxxx: pos = 3'b010;
        8'b0001xxxx: pos = 3'b011;
        8'b00001xxx: pos = 3'b100;
        8'b000001xx: pos = 3'b101;
        8'b0000001x: pos = 3'b110;
        8'b00000001: pos = 3'b111;
        default: pos = 3'b000;
    endcase
end

endmodule
