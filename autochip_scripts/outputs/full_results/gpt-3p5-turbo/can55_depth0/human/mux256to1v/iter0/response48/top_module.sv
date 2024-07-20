module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create a wire to hold the selected 4-bit input based on the value of sel
wire [3:0] selected_input;

// Create a case statement to select the appropriate bits from the input
always @*
begin
	case(sel)
		0: selected_input = in[3:0];
		1: selected_input = in[7:4];
		2: selected_input = in[11:8];
		// Add more cases for remaining selections
	endcase
end

// Assign the selected_input to the output
assign out = selected_input;

endmodule
