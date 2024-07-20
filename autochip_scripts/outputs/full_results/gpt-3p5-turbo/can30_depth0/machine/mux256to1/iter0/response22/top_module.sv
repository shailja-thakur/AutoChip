module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

reg [7:0] sel_temp;
reg out_temp;

always @(*) begin
    sel_temp = sel; // Creating a temporary variable for the selection vector
    out_temp = in[sel_temp]; // Assigning the bit from the input vector based on the selection vector to the temporary output
end

assign out = out_temp; // Assigning the temporary output to the final output

endmodule
