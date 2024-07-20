module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg valid_sel;  // Added a reg to store valid selection bit
wire [7:0] valid_sel_wire;  // Added a wire for connecting to the valid_sel reg

always @* begin
	case(sel)  // Added a case statement to determine the valid selection bit
		8'b00000001: valid_sel = 1;
		8'b00000010: valid_sel = 1;
		8'b00000100: valid_sel = 1;
		8'b00001000: valid_sel = 1;
		8'b00010000: valid_sel = 1;
		8'b00100000: valid_sel = 1;
		8'b01000000: valid_sel = 1;
		8'b10000000: valid_sel = 1;
		default: valid_sel = 0;
	endcase
end

assign valid_sel_wire = valid_sel;  // Assign the valid_sel reg to the valid_sel_wire

assign out = in[sel];  // Use the sel input as the index to select the corresponding bit from the input vector

endmodule
