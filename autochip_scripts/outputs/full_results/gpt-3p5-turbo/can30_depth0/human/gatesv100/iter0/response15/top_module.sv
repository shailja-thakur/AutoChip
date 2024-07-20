module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	reg [98:0] out_both_reg;
	reg [99:1] out_any_reg;
	reg [99:0] out_different_reg;

	always @*
	begin
		for (int i = 0; i < 99; i = i + 1)
		begin
			if (in[i] && in[i+1])
				out_both_reg[i] = 1;
			else
				out_both_reg[i] = 0;
			
			if (in[i] || in[i+1])
				out_any_reg[i] = 1;
			else
				out_any_reg[i] = 0;
			
			if (in[i] != in[i+1])
				out_different_reg[i] = 1;
			else
				out_different_reg[i] = 0;
		end
		
		out_both_reg[99] = 0;
		out_any_reg[99] = in[99];
		out_different_reg[99] = (in[99] != in[0]);
	end
	
	assign out_both = out_both_reg;
	assign out_any = out_any_reg;
	assign out_different = out_different_reg;
	
endmodule
