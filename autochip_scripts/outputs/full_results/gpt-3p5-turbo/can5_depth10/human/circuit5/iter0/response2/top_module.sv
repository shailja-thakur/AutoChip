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
		case({a,b,c,d,e})
			{4'b0000, d, e}: q = b;
			{4'b0001, d, e}: q = e;
			{4'b0010, d, e}: q = a;
			{4'b0011, d, e}: q = d;
			{4'b0100, d, e}: q = f;
			default: q = f;
		endcase
	end
	
endmodule
