module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	reg [255:0] temp;
	assign out = temp[sel];

	always @(in) begin
		temp <= in;
	end

endmodule
