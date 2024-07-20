module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(*) begin
    case ({a, b, c, d, e})
        8'b...._.... -> q = 4'b0000;
        8'b...._.... -> q = 4'b1011;
        8'b...._.... -> q = 4'b1110;
        8'b...._.... -> q = 4'b0100;
        8'b...._.... -> q = 4'b1111;
        default      -> q = 4'b1111;
    endcase
end

endmodule
