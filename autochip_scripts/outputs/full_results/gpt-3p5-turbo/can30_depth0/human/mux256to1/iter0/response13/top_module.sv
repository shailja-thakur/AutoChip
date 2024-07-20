module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [255:0] temp_out;  // Create a temporary register to store the selected input

always @(*) begin
	case(sel)
		8'b00000000: temp_out <= in[0];
		8'b00000001: temp_out <= in[1];
		8'b00000010: temp_out <= in[2];
		8'b00000011: temp_out <= in[3];
		8'b00000100: temp_out <= in[4];
		8'b00000101: temp_out <= in[5];
		8'b00000110: temp_out <= in[6];
		8'b00000111: temp_out <= in[7];
		default: temp_out <= 8'b0;
	endcase
end

assign out = temp_out;  // Assign the value of the temporary register to the output

endmodule
