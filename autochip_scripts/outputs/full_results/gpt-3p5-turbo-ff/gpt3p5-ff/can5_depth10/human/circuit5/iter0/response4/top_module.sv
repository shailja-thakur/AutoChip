module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	
	always @* begin
		case({a,b,c,d,e})
			4'b0000: q = b; // If a=b=c=d=e=0, q=b
			4'b0001: q = e; // If a=b=c=d=0, e= 1, q= e
			4'b0010: q = a; // If a=0 and b=c=d=e=1, q=a
			4'b0011: q = d; // If a=0, b=c=d=e=1, q = d
			4'b0100: q = 'hF; // If a=0 and b=c=d=e=2-15, q=15
			4'b0101: q = 'hF; // If a=0 and b=c=d=e=2-15, q=15
			4'b0110: q = 'hF; // If a=0 and b=c=d=e=2-15, q=15
			4'b0111: q = 'hF; // If a=0 and b=c=d=e=2-15, q=15
			4'b1000: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			4'b1001: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			4'b1010: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			4'b1011: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			4'b1100: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			4'b1101: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			4'b1110: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			4'b1111: q = 'hF; // If a=1 and b=c=d=e=0-15, q=15
			default: q = 4'hX; // If inputs don't match any previous cases, q is X.
		endcase
	end
	
endmodule
