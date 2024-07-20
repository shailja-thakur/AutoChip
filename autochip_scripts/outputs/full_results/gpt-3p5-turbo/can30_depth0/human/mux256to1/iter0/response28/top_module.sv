module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [7:0] address;
reg out;

always @ (sel) begin
	case(sel)
		0: address = 0;
		1: address = 1;
		2: address = 2;
		// Add remaining cases for address assignment
	endcase
	
	// Assign output based on selected address
	out = in[address];
end

endmodule
