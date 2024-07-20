module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create a wire to store the selected range of bits
wire [3:0] selected;

// Create a for loop to select the appropriate bits based on the value of sel
integer i;
always @*
begin
	for (i = 0; i < 256; i = i + 1)
	begin
		// Select the range of bits based on sel
		case(sel)
			0: selected = in[4*i +: 4];
			1: selected = in[4*i + 4 +: 4];
			2: selected = in[4*i + 8 +: 4];
			default: selected = 4'b0; // Default case for invalid sel values
		endcase
	end
end

// Assign the selected bits to the output
assign out = selected;

endmodule
