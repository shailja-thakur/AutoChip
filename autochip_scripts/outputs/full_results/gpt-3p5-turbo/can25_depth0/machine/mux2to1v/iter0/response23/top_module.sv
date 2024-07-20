module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output reg [99:0] out
);

always @ (a, b, sel)
begin
	if(sel == 0)
		out = a;
	else if(sel == 1)
		out = b;
end

endmodule
