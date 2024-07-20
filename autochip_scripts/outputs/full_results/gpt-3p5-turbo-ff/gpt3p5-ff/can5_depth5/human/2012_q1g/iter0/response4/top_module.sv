module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	if (x == 4'b0000)
		f = 1;
	else if (x == 4'b0010)
		f = 0;
	else if (x == 4'b0011)
		f = 0;
	else if (x == 4'b0011)
		f = 0;
	else if (x == 4'b0110)
		f = 0;
	else if (x == 4'b0111)
		f = 1;
	else if (x == 4'b0100)
		f = 1;
	else if (x == 4'b0101)
		f = 1;
	else if (x == 4'b1100)
		f = 1;
	else if (x == 4'b1101)
		f = 1;
	else if (x == 4'b1111)
		f = 0;
	else if (x == 4'b1110)
		f = 0;
	else
		f = 0;
end

endmodule
