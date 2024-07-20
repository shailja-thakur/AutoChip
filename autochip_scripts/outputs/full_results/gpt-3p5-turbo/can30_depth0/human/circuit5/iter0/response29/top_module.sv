module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @(*)
begin
    case ({a[3], b[3], c[3], d[3], e[3]})
        5'b0????:  q = b;
        5'b1????:  q = e;
        5'b01???:  q = a;
        5'b11???:  q = d;
        5'b??001:  q = e;
        5'b??101:  q = f;
        default:   q = f;
    endcase
end 

endmodule
