module mux256to1v (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);
	reg [7:0] sel_index;

	always @* begin
		sel_index = sel * 4; // Calculate the index for selecting the 4-bit input
		out = in[sel_index +: 4]; // Select the 4-bit input based on the index
	end
	
endmodule
