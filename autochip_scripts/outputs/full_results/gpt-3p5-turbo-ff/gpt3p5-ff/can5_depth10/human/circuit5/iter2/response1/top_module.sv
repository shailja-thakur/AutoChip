module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
    if (c == 4'b0100 && e == 4'b1110)
        q = b;
    else if (c == 4'b1010 && e == 4'b1110)
        q = e;
    else if (c == 4'b1100 && e == 4'b1110)
        q = a;
    else if (c == 4'b0011 && e == 4'b1110)
        q = d;
    else
        q = 4'b1111;
end

endmodule
