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
        5'b0000_0: q = 4'b1111;
        5'b0001_0: q = b;
        5'b0010_0: q = e;
        5'b0011_0: q = a;
        5'b0100_0: q = d;
        default: q = 4'b1110;
    endcase
end

endmodule
