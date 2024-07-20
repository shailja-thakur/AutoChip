module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

always @*
begin
	pos = 0;
	if (in[3] == 1)
		pos = 3;
	else if (in[2] == 1)
		pos = 2;
	else if (in[1] == 1)
		pos = 1;
	else if (in[0] == 1)
		pos = 0;
end

endmodule
