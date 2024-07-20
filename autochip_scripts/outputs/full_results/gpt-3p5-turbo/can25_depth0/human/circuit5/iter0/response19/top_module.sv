module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @* begin
    if (a == 4'b0000 && b == 4'b0000 && c == 4'b0000 && d == 4'b0000 && e == 4'b0000)
        q = 4'b0000;
    else if (c == 4'b0000)
        q = b;
    else if (c == 4'b0001)
        q = e;
    else if (c == 4'b0010)
        q = a;
    else if (c == 4'b0011)
        q = d;
    else
        q = 4'b1111;
end

endmodule
