module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [1023:0] temp;

	always @*
	begin
		temp = in >> (sel * 4);
		out = temp[3:0];
	end

endmodule
