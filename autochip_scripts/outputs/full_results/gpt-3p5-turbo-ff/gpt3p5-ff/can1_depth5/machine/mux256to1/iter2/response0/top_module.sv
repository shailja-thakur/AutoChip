module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
	reg  select_bit;
	always @(sel)
		begin
			case(sel)
				0: select_bit = in[0];
				1: select_bit = in[1];
				2: select_bit = in[2];
				3: select_bit = in[3];
				4: select_bit = in[4];
				5: select_bit = in[5];
				6: select_bit = in[6];
				7: select_bit = in[7];
				default: select_bit = 1'b0;
			endcase
		end
		
	assign out = select_bit;
	
endmodule
