module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(a, b, c, d, e) begin
    case({a, b, c, d, e})
        4'bxxxxxxxxxx: q = 4'bxxxx;
        4'bxxxx0xxxxx: q = b;
        4'bxxxx1xxxxx: q = e;
        4'bx{a[2:0]}xxxxx: q = a;
        4'bxxxxxxxxxf: q = d;
        4'bx{c[2:0]}xxxx: q = f;
        4'bx{d[2:0]}xxxx: q = g;
        4'bx{e[2:0]}xxxx: q = h;
        default: q = 4'bxxxx;
    endcase
end

endmodule
