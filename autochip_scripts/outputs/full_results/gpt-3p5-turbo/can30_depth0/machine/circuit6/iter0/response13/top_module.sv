module top_module (
    input [2:0] a, 
    output reg [15:0] q
);

always @(a) begin
    case(a)
        3'b000: q = 16'b0100100001100010;
        3'b001: q = 16'b1010111010000000;
        3'b010: q = 16'b0010010011010100;
        3'b011: q = 16'b1011000110010110;
        3'b100: q = 16'b0010000101011010;
        3'b101: q = 16'b0110010110001110;
        3'b110: q = 16'b1100010101101110;
        3'b111: q = 16'b0010111011001001;
        default: q = 16'b0; // Added default case to handle unknown values
    endcase
end

endmodule
