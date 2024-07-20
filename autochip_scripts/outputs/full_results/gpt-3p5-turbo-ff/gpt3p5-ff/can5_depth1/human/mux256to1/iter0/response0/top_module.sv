module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	reg [0:255] select_output;
	
	always @(*) begin
		case (sel)
			0: select_output = in[0];
			1: select_output = in[1];
			2: select_output = in[2];
			3: select_output = in[3];
			4: select_output = in[4];
			5: select_output = in[5];
			6: select_output = in[6];
			7: select_output = in[7];
			default: select_output = 0;
		endcase
	end
	
	assign out = select_output;
endmodule
