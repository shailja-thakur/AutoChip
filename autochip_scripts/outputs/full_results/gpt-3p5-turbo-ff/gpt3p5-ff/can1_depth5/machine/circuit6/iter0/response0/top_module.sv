module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @* begin
	case(a)
		0: q = 16'd4658;
		1: q = 16'd44768;
		2: q = 16'd10196;
		3: q = 16'd23054;
		4: q = 16'd8294;
		5: q = 16'd25806;
		6: q = 16'd50470;
		7: q = 16'd12057;
	endcase
end

endmodule
