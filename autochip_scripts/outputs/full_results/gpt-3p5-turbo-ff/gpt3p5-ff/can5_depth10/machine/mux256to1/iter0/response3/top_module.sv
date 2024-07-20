module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	reg [255:0] temp; // Define a temporary register to hold the selected bit

	always @(sel) begin
		temp = in[sel]; // Select the bit from the input vector based on the selection vector
	end

	assign out = temp[0]; // Assign the selected bit to the output

endmodule
