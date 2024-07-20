module top_module (
	input [4:1] x,
	output logic f
);

// Assign values based on Karnaugh map
always_comb begin
	if (x == 4'b0000) 
		f = 1'b1;
	else if (x == 4'b0001)
		f = 1'b0;
	else if (x == 4'b0011)
		f = 1'b0;
	else if (x == 4'b0010)
		f = 1'b1;
	else if (x == 4'b1100)
		f = 1'b1;
	else if (x == 4'b1101)
		f = 1'b1;
	else if (x == 4'b1111)
		f = 1'b0;
	else if (x == 4'b1110)
		f = 1'b1;
	else
		f = 1'b0;
end

endmodule
