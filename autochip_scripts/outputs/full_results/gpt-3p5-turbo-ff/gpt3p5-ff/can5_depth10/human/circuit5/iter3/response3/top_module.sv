module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
    case({a, b, c, d, e})
        5'b0000: q = 4'b0000;
        5'b0001: q = b;
        5'b0010: q = e;
        5'b0011: q = a;
        5'b0100: q = d;
        5'b0101: q = c;
        5'b0110: q = c;
        5'b0111: q = c;
        5'b1000: q = c;
        5'b1001: q = c;
        5'b1010: q = c;
        5'b1011: q = c;
        5'b1100: q = c;
        5'b1101: q = c;
        5'b1110: q = c;
        5'b1111: q = c;
        default: q = 4'b1111;
    endcase
end

endmodule
