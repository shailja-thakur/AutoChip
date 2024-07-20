module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	reg [3:0] selected_input;

	always @(sel) begin
		case(sel)
			0: selected_input = in[3:0];
			1: selected_input = in[7:4];
			2: selected_input = in[11:8];
			3: selected_input = in[15:12];
			4: selected_input = in[19:16];
			5: selected_input = in[23:20];
			6: selected_input = in[27:24];
			7: selected_input = in[31:28];
			8: selected_input = in[35:32];
			
			// continue with the remaining cases
			
			default: selected_input = 4'b0000; // default case
			
		endcase
	end

	assign out = selected_input;

endmodule
