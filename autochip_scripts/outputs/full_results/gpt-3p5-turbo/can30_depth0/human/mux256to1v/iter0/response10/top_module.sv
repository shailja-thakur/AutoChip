module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create a wire to hold the selected input
wire [3:0] selected_input;

// Assign the selected input based on the value of sel
always @*
begin
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
		9: selected_input = in[39:36];
		10: selected_input = in[43:40];
		11: selected_input = in[47:44];
		12: selected_input = in[51:48];
		13: selected_input = in[55:52];
		14: selected_input = in[59:56];
		15: selected_input = in[63:60];
		16: selected_input = in[67:64];
		17: selected_input = in[71:68];
		18: selected_input = in[75:72];
		19: selected_input = in[79:76];
		20: selected_input = in[83:80];
		21: selected_input = in[87:84];
		22: selected_input = in[91:88];
		23: selected_input = in[95:92];
		24: selected_input = in[99:96];
		25: selected_input = in[103:100];
		default: selected_input = 4'b0;
	endcase
end

assign out = selected_input;

endmodule
