module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

always @*
begin
	if (c[0] == 1)  
		q = e;
	else if (c[1] == 1)  
		q = a;
	else if (c[2] == 1)  
		q = d;
	else if (c[3] == 1)  
		q = f;
	else  
		q = b;
end

endmodule
